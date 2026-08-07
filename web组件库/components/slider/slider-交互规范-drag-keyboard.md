---
name: 滑块交互规范 — 拖拽 / 键盘 / 双滑块 / 气泡跟随
category: interaction
scene: drag-keyboard
status: stable
component: slider
paired-with: ../../slider.md
applies-to: 所有 Slider（单值 / 范围 / 分档 / 带标签 / 垂直）
---

# 滑块交互规范 — 拖拽 / 键盘 / 双滑块协同 / 气泡跟随

> **本文件解决「拖动慢半拍」「键盘步进精度不够」「双滑块互相穿越」「气泡遮挡当前值」四类问题。**
>
> 视觉规范见 [`../../slider.md`](../../slider.md)。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **拖拽即时跟手** | 拖拽期间无延迟，松手才触发 onChange |
| **键盘精确步进** | Arrow 1×step、PageUp/Down 10×step |
| **双滑块不穿越** | min ≤ max 始终成立，最小间距可配置 |
| **气泡可读** | 显示当前值、不遮挡轨道、跟随滑块移动 |

---

## 二、拖拽交互

### 2.1 触发与跟手

| 阶段 | 行为 |
|------|------|
| mousedown 滑块 | 滑块进入 active 态（scale 1.1，参考 slider.md）|
| mousemove | 滑块实时跟随鼠标 X 坐标，value 实时计算 |
| mouseup | 触发 onChange（最终值）|

### 2.2 onChange vs onInput

| 事件 | 触发时机 | 适用场景 |
|------|---------|---------|
| onInput | 拖拽过程中实时（节流 16ms / 1 帧）| 实时预览（如调整字号、调色板）|
| onChange | mouseup 后一次 | 接口提交、表单字段值 |

> 默认场景使用 onChange；业务方需要实时预览时显式监听 onInput。

### 2.3 轨道点击跳转

| 触发 | 行为 |
|------|------|
| 点击轨道任意位置 | 滑块**带过渡动画**移动到该位置（200ms cubic-bezier）|
| 范围 Slider 点击轨道 | 距离哪个滑块近，哪个滑块移动 |
| 已禁用 | 不响应 |

---

## 三、键盘交互

### 3.1 焦点

- 滑块 `tabindex="0"`，每个滑块单独占焦点（双滑块占两个 Tab 位）
- Focus Ring：`0 0 0 4px rgba(21,92,203,.15)`（同 slider.md 第三节）
- 鼠标拖拽不显示 Focus Ring

### 3.2 按键

| 按键 | 行为 |
|------|------|
| ArrowRight / ArrowUp | value += step |
| ArrowLeft / ArrowDown | value -= step |
| PageUp | value += 10 × step（默认大步长）|
| PageDown | value -= 10 × step |
| Home | value = min |
| End | value = max |

### 3.3 持续按键

- 持续按住 ArrowRight：500ms 后每 80ms 触发一次（加速）
- PageUp/Down 不加速

### 3.4 双滑块切换

| 按键 | 行为 |
|------|------|
| Tab | 在两个滑块间切换 |
| 焦点在 min 滑块 + ArrowRight 让 value > max | 阻止（不允许穿越）|
| 焦点在 max 滑块 + ArrowLeft 让 value < min | 阻止 |

---

## 四、双滑块协同

### 4.1 互不穿越

| 约束 | 实现 |
|------|------|
| min ≤ max | 始终成立 |
| 最小间距 | 默认 1×step；可配置 minGap |
| 拖拽 min 滑块到 max 位置 | 停在 max - minGap |
| 拖拽 max 滑块到 min 位置 | 停在 min + minGap |

### 4.2 同位置时的优先级

- 当 min === max 时，鼠标点击轨道：
  - 点击位置 < 当前值 → 拖动 min 滑块
  - 点击位置 > 当前值 → 拖动 max 滑块

### 4.3 整体拖拽（已选区域）

- 已选区域（min 与 max 之间）支持鼠标拖拽
- 拖拽时两个滑块**同步移动**，保持间距不变
- 触达 min 或 max 边界时停止
- 移动端通过两指捏合（可选，业务方启用）

---

## 五、气泡（值提示）

### 5.1 显示时机

| 场景 | 是否显示 |
|------|---------|
| hover 滑块 | 显示 |
| 拖拽中 | 显示 |
| 键盘聚焦 | 显示 |
| mouseleave + blur | 隐藏 |
| 始终显示模式（业务方配置 alwaysShow=true）| 始终显示 |

### 5.2 内容

- 默认显示 value
- 业务方可传入 formatter（如 `${value}%`、`${value} 元`、`${value}/100`）
- 范围 Slider：每个滑块上独立气泡

### 5.3 跟随定位

- 气泡位置：滑块上方 8px（参考 slider.md 第四节）
- 滑块靠近视口边缘时气泡反向偏移（同 [`../../tooltip/interaction/trigger-positioning.md`](../../tooltip/interaction/trigger-positioning.md)）
- 双滑块靠近时气泡可能重叠：自动错位（min 气泡靠左、max 气泡靠右）

---

## 六、分档（Marks）交互

### 6.1 吸附（snap）

| 配置 | 行为 |
|------|------|
| `step="auto"` + 仅 marks 可选 | 拖拽时滑块吸附到最近的 mark |
| 普通 step | 拖拽过程中按 step 跳动（不在两个 step 之间停留）|

### 6.2 点击 mark 标签

- 点击 mark 标签文字直接跳转 value 到该 mark
- 与点击轨道相同的过渡动画

### 6.3 已激活 mark 视觉

- 滑块经过的 mark 大刻度变 `--primary-600`
- mark 标签文字变 `--primary-600`

---

## 七、垂直 Slider

| 维度 | 区别 |
|------|------|
| 拖拽 | mousemove 跟随 Y 坐标 |
| 键盘 ArrowUp / Down | 增 / 减 value（与 ArrowRight / Left 等效）|
| 气泡位置 | 滑块右侧 8px |
| 适用场景 | 音量调节、温度计、楼层选择 |

---

## 八、禁用与只读

### 8.1 禁用（disabled）

- 不响应任何交互（鼠标 / 键盘 / 触摸）
- 视觉透明度 0.6（参考 slider.md 第七节）
- 不可聚焦（`tabindex="-1"`）

### 8.2 只读（readonly）

- 视觉与 active 一致（不灰化）
- 不响应鼠标 / 键盘改变 value
- 仍可聚焦 + Tab，气泡可显示

---

## 九、自检清单

- [ ] 拖拽时滑块跟手无延迟，松手才触发 onChange
- [ ] onInput 实时（节流 16ms），onChange 仅 mouseup 一次
- [ ] 点击轨道滑块带 200ms 过渡动画
- [ ] Tab 聚焦显示 Focus Ring
- [ ] Arrow 步进 1×step，PageUp/Down 10×step
- [ ] Home/End 跳到 min/max
- [ ] 持续按住 Arrow 500ms 后加速
- [ ] 双滑块不允许穿越（保持 minGap）
- [ ] 拖拽已选区域时两滑块同步移动
- [ ] 气泡 hover/拖拽/聚焦时显示，离开时隐藏
- [ ] 气泡靠近视口边缘时反向偏移
- [ ] 双气泡重叠时自动错位
- [ ] 分档模式下吸附最近 mark
- [ ] 点击 mark 标签跳转 value
- [ ] 垂直 Slider 用 ArrowUp/Down 控制
- [ ] 禁用态不响应交互且不可聚焦

---

## 十、不适用场景

- **离散选项**（如档位 1/2/3 = 慢/中/快）：用 Segmented Control 或 Radio Group
- **超大数值范围**（如 1–10000）：用 InputNumber 或 Slider + InputNumber 组合
- **多维度联动**（如调色板 RGB）：拆分为 3 个 Slider
- **触摸密集场景**（移动端表单）：考虑大尺寸或 Stepper
