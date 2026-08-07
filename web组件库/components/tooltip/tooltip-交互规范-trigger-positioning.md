---
name: 文字提示交互规范 — 触发方式 / 延迟 / 定位翻转
category: interaction
scene: trigger-positioning
status: stable
component: tooltip
paired-with: ../../tooltip.md
applies-to: 所有 Tooltip 触发场景（hover / focus / click / 表格截断 / 禁用按钮）
---

# 文字提示交互规范 — 触发 / 延迟 / 定位 / 边界翻转

> **本文件解决「Tooltip 闪烁打扰用户」「贴边的 Tooltip 被截断」「键盘用户看不到 Tooltip」「移动端 hover 不可用」四类问题。**
>
> 视觉规范见 [`../../tooltip.md`](../../tooltip.md)。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **不闪烁打扰** | 入场延迟 300ms，避免快速划过频繁弹出 |
| **键盘可达** | focus 同样能触发，焦点离开立即关闭 |
| **不被裁切** | 视口边缘自动翻转方向 |
| **移动端友好** | 不依赖 hover；改为 long-press 触发 |

---

## 二、触发方式

### 2.1 三种模式

| 模式 | 入场触发 | 离场触发 |
|------|---------|---------|
| **hover（默认）** | mouseenter | mouseleave |
| **focus** | focus | blur |
| **click** | click | click 切换 / 点击外部 |

### 2.2 自动复合（推荐）

| 默认行为 | 说明 |
|---------|------|
| **hover + focus 同时启用** | 鼠标用户与键盘用户都能触发；mouseenter / focus 任一即可入场 |
| 离场判定 | 仅当 hover **和** focus 都失去时才隐藏 |

> 这是默认推荐配置：业务方不指定 trigger 时按此处理，确保无障碍体验。

### 2.3 click 模式适用场景

- 复杂提示需要用户主动查看（如"这个字段是什么意思？"图标）
- 移动端（无 hover）

---

## 三、延迟规则

### 3.1 入场延迟

| 场景 | 延迟 |
|------|------|
| 默认 | 300ms |
| 同一组连续 Tooltip 切换 | 0ms（立即切换，不二次延迟）|
| click 触发 | 0ms |

> "同一组"：相邻可触发 Tooltip 的元素，且上一次 Tooltip 离场不超过 200ms。

### 3.2 离场延迟

| 场景 | 延迟 |
|------|------|
| 默认 | 100ms |
| 鼠标进入 Tooltip 自身 | 不离场（允许鼠标移到 Tooltip 上）|
| Esc 键按下 | 0ms |

### 3.3 入场前取消

如果在入场延迟内（300ms 内）鼠标已经离开，**取消即将入场**，避免快速划过时弹出。

---

## 四、定位与边界翻转

### 4.1 默认定位

| 方位 | 默认偏移（距触发元素）|
|------|--------------------|
| top | 8px |
| bottom | 8px |
| left | 8px |
| right | 8px |

### 4.2 翻转规则

```
默认尝试 → top
  视口上方空间 < (Tooltip 高度 + 8px) → 翻转到 bottom
    视口下方空间也不足 → 翻转到 right
      视口右侧空间也不足 → 翻转到 left
        都不足 → 强制使用 top + 滚动 Tooltip 内部
```

### 4.3 边缘对齐

- Tooltip 默认与触发元素**居中对齐**
- 如果居中后会超出视口，向反向偏移直到不超出（保持小箭头仍指向触发元素中心）
- 视口距离最小 8px

### 4.4 滚动跟随

- 触发元素所在容器滚动时，Tooltip 跟随实时更新位置
- 触发元素滚出视口时 Tooltip 立即关闭
- 详见 [`../../select/interaction/dropdown-panel.md`](../../select/interaction/dropdown-panel.md) 第六节（同样的浮层逻辑）

---

## 五、动画

| 阶段 | 过渡 |
|------|------|
| 入场 | `opacity 0→1 + transform: scale(.98→1)` 150ms |
| 离场 | `opacity 1→0` 100ms |
| 翻转方向 | 切换瞬间不做动画（避免视觉跳跃）|

---

## 六、内容规则

### 6.1 允许内容

- 纯文字（默认）
- 简单 HTML（强调 / 换行 / 链接，但**不允许**按钮 / 表单 / 复杂结构）
- 业务方塞入复杂内容必须改用 Popover / Popconfirm

### 6.2 长度

- 默认 `max-width: 240px`，超出自动换行
- 超过 100 字提示业务方："Tooltip 不适合承载长说明，请改用 Alert / Popover"

### 6.3 多行

- 内部支持 `\n` 或 `<br>`
- 多行 Tooltip 内 padding 不变（6px 10px），仅高度自适应

---

## 七、移动端

| 维度 | 桌面 | 移动 |
|------|------|------|
| 触发方式 | hover + focus | long-press 600ms |
| 离场方式 | mouseleave + blur | 点击外部 / 任意触摸 |
| 显示位置 | 跟随触发元素 | 同左 |
| 自动隐藏 | 无（用户离开才隐藏）| 4s 后自动隐藏 |

> long-press 触发后**抑制原生 click 事件**，避免误点击触发元素。

---

## 八、与其他组件的协同

### 8.1 表格单元格截断

- 仅在**实际截断**时触发（参考 [`../../table/interaction/truncate.md`](../../table/interaction/truncate.md)）
- 入场延迟同样 300ms
- 内容为单元格全文

### 8.2 禁用按钮

- 禁用按钮也能 hover 触发 Tooltip，解释禁用原因
- 详见 [`../../button/interaction/loading-state.md`](../../button/interaction/loading-state.md) 第三节

### 8.3 表单字段说明

- 字段标签后的"?" 图标用 click 模式（避免误触发）
- 内容必须在 100 字以内，否则改用 Popover

---

## 九、自检清单

- [ ] hover 默认 300ms 后入场，快速划过 200ms 不入场
- [ ] focus 同样能触发 Tooltip
- [ ] hover 与 focus 同时离开后才离场（100ms 延迟）
- [ ] 鼠标进入 Tooltip 自身时不离场
- [ ] 视口上方空间不足时自动翻转到下方
- [ ] 居中对齐超出视口时向反向偏移，箭头仍指向触发元素中心
- [ ] 容器滚动时 Tooltip 跟随更新位置
- [ ] 触发元素滚出视口时 Tooltip 立即关闭
- [ ] 多行内容支持 `\n` 或 `<br>`
- [ ] 移动端用 long-press 600ms 触发，4s 自动关闭
- [ ] 同一组连续 Tooltip 切换无二次延迟
- [ ] Esc 立即关闭

---

## 十、不适用场景

- **复杂交互内容**：用 Popover / Popconfirm
- **持久信息提示**（如表单错误）：用 inline 校验文案
- **超过 100 字的说明**：用 Alert / Drawer / 帮助页
- **键盘陷阱场景**：Tooltip 内不允许有可聚焦元素，否则破坏 Tab 顺序
