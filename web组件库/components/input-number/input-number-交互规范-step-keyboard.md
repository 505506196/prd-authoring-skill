---
name: 数字输入框交互规范 — 步进 / 长按加速 / 键盘 / 范围限制
category: interaction
scene: step-keyboard
status: stable
component: input-number
paired-with: ../../input-number.md
applies-to: 所有 InputNumber（外置按钮 / 内置堆叠 / 表单内 / 表格行内）
---

# 数字输入框交互规范 — 步进 / 长按加速 / 键盘 / 范围限制

> **本文件解决「步进按钮单次点击效率低」「键盘只能输入数字不能用 ↑↓」「输入超范围没有清晰反馈」三类问题。**
>
> 视觉规范见 [`../../input-number.md`](../../input-number.md)。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **快速调整** | 长按加减按钮持续触发，速度递增 |
| **键盘可达** | ArrowUp/Down 步进 + PageUp/Down 大步进 |
| **范围内合法** | 超出 min/max 自动 clamp + 视觉提示 |
| **精度可控** | precision 参数控制小数位 |

---

## 二、点击与长按

### 2.1 单次点击

| 触发 | 行为 |
|------|------|
| 点击 + 按钮 | value += step |
| 点击 - 按钮 | value -= step |
| 点击 + value === max | 按钮 disabled，hover 显示"已达上限" |
| 点击 - value === min | 按钮 disabled，hover 显示"已达下限" |

### 2.2 长按加速

| 阶段 | 触发频率 |
|------|---------|
| 0–500ms（按下后前 500ms）| 仅触发一次 |
| 500ms–1500ms | 每 150ms 触发一次 |
| 1500ms 后 | 每 50ms 触发一次（高速档）|

> 长按阈值基于人手反应：500ms 内属于"单次点击"，超过才进入长按。

### 2.3 长按结束

- mouseup / mouseleave / touchend / 失焦 → 立即停止
- value 达到 min / max → 立即停止
- 期间不触发 onChange 防抖（每次改变都触发，因为是用户主动）

---

## 三、键盘交互

### 3.1 焦点

- 输入框 `tabindex="0"`
- 按钮**不**单独占 Tab 顺序（避免 Tab 5 次才离开 InputNumber）
- 输入框聚焦时 Focus Ring 整体显示在容器外层

### 3.2 按键

| 按键 | 行为 |
|------|------|
| ArrowUp | value += step |
| ArrowDown | value -= step |
| PageUp | value += 10 × step |
| PageDown | value -= 10 × step |
| Home | value = min（如有定义）|
| End | value = max（如有定义）|
| Enter | 提交（触发 form submit / blur 校验）|
| Esc | 撤销本次输入，恢复 prevValue |

### 3.3 持续按键加速

- 持续按住 ArrowUp 同样适用长按加速规则（500ms 后每 150ms 触发）
- PageUp / PageDown 不加速（每次都触发完整 10×step）

---

## 四、输入与校验

### 4.1 输入限制

| 输入字符 | 行为 |
|---------|------|
| 数字 | 接受 |
| 小数点（精度允许时）| 接受 |
| 负号（min < 0 时）| 接受 |
| `e` / `E`（科学计数法）| **拒绝**（避免业务方解析错误）|
| 其他字符 | 拒绝（不写入输入框）|

### 4.2 失焦校验

| 输入态 | 失焦后行为 |
|--------|----------|
| 合法数字在范围内 | 保持原值 |
| 合法数字超 max | clamp 到 max + 抖动红色边框 200ms + Toast"已调整为最大值"|
| 合法数字低于 min | clamp 到 min + 抖动红色边框 200ms + Toast"已调整为最小值"|
| 不合法（多余小数点 / 字符）| 恢复 prevValue + 抖动红色边框 200ms |
| 空值 | 恢复 prevValue 或保持空（按业务配置）|

### 4.3 抖动动画

```css
@keyframes shake {
  0%, 100% { transform: translateX(0); }
  20% { transform: translateX(-4px); }
  40% { transform: translateX(4px); }
  60% { transform: translateX(-4px); }
  80% { transform: translateX(4px); }
}
```

边框色：`--danger-500`，200ms 后恢复 `--border` 或 `--primary-600`（视焦点状态）。

---

## 五、精度处理

### 5.1 precision 参数

| precision | 显示与存储 |
|-----------|----------|
| 0 | 仅整数，输入小数点拒绝 |
| 1 | 1.5、2.0；输入更高位拒绝 |
| 2 | 1.50、2.05；输入更高位拒绝 |
| 不指定 | 跟随用户输入，不强制 |

### 5.2 step 与 precision 的关系

- 默认 step = 10^(-precision)
- 业务方可分别指定 step 与 precision
- step = 0.1 + precision = 2 时，每次 +0.10（保留两位小数显示）

### 5.3 浮点误差

- 内部使用字符串运算或 Decimal 库避免 `0.1 + 0.2 = 0.30000000000000004`
- 显示时按 precision 截断

---

## 六、千分位分隔（可选）

| 配置 | 显示 |
|------|------|
| `formatter: thousands` | `1234567` → `1,234,567` |
| 输入态 | 不显示分隔（避免光标跳动）|
| 失焦态 | 显示分隔 |

> 千分位是显示层面，存储仍为纯数字。

---

## 七、与表单集成

### 7.1 表单内 InputNumber

- onBlur 触发表单字段校验
- onChange 实时更新表单 state（不防抖）
- onPressEnter 触发表单提交（如外层是 form）

### 7.2 范围限制冲突

- 业务方传入 min > max → 控制台 warning + 取 min 为准
- value 在初始化时已超出 min/max → 立即 clamp

### 7.3 步进对齐

- value 必须是 step 的整数倍（如 step=5，value 应为 0、5、10）
- 输入 7 后失焦：clamp 到最近倍数（5 或 10，向下取整）+ Toast"已调整为 5"

---

## 八、移动端

| 维度 | 桌面 | 移动 |
|------|------|------|
| 长按加速 | ✓ | ✓（同样阈值）|
| 键盘类型 | text + inputmode=numeric | inputmode=decimal（带小数点）|
| 按钮宽度 | 40px | 44px（满足触摸热区）|
| 内置堆叠按钮 | 支持 | 不推荐（按钮太小）|

---

## 九、自检清单

- [ ] 单次点击 + / - 按钮，value 按 step 变化
- [ ] 长按 500ms 后开始持续触发，1500ms 后加速
- [ ] mouseleave / touchend 立即停止长按
- [ ] value 达到 min/max 时对应按钮 disabled + Tooltip 提示
- [ ] ArrowUp/Down 步进，PageUp/Down 10×step
- [ ] Home/End 跳到 min/max
- [ ] Enter 触发提交，Esc 撤销输入
- [ ] 输入 e / E 字符被拒绝
- [ ] 失焦超范围时 clamp + 抖动 + Toast
- [ ] 失焦不合法时恢复 prevValue + 抖动
- [ ] precision 控制小数位显示
- [ ] 千分位仅在失焦态显示，输入态不显示
- [ ] 移动端 inputmode 正确，按钮触摸热区充足

---

## 十、不适用场景

- **金额输入（带货币符号）**：用 InputNumber 但禁用步进按钮（用户极少 +1 元）
- **百分比输入**：用 Slider 或独立 Percent 组件，避免数字 + "%" 字符冲突
- **超大数字（如手机号 / 身份证）**：用 Input 而非 InputNumber，避免精度丢失
- **范围两端无限制**（如自由温度输入）：本规范的 clamp 不适用
