---
name: 输入框交互规范 — 中文输入法与字数限制
category: interaction
scene: composition
status: stable
component: input
paired-with: ../visual.md
applies-to: 所有 Input/Textarea 组件涉及 IME 输入的场景
---

# 输入框交互规范 — 中文输入法与字数限制

> **本文件解决「中文输入法（IME）与实时校验/字数限制冲突」问题**：composing 期间不触发校验、字数统计何时生效、超限如何处理。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **不打断输入** | 拼音输入过程中不触发校验、不截断文字 |
| **字数准确** | 字数统计只计算已确认的文字，不计算拼音字母 |
| **超限有感** | 达到字数上限时有明确视觉提示 |
| **粘贴兼容** | 粘贴超长文本时正确截断并提示 |

---

## 二、IME Composing 状态处理

### 2.1 核心规则

| 事件 | 行为 |
|------|------|
| `compositionstart` | 标记进入 composing 状态，暂停所有实时校验 |
| `compositionupdate` | 不触发任何校验或字数限制逻辑 |
| `compositionend` | 退出 composing 状态，用确认后的文字触发校验 |

### 2.2 禁止在 composing 期间做的事

- 禁止触发 `onChange` 回调（会导致拼音被当作输入值）
- 禁止执行字数截断（会把拼音字母计入字数）
- 禁止触发搜索请求（会用拼音去搜索）
- 禁止显示格式校验错误（拼音不是最终值）

### 2.3 实现要点

```js
let isComposing = false
input.addEventListener('compositionstart', () => { isComposing = true })
input.addEventListener('compositionend', (e) => {
  isComposing = false
  handleInput(e.target.value) // 此时才触发校验/搜索
})
input.addEventListener('input', (e) => {
  if (!isComposing) handleInput(e.target.value)
})
```

---

## 三、字数限制

### 3.1 字数统计规则

| 维度 | 规则 |
|------|------|
| 统计对象 | 已确认的文字（不含 composing 中的拼音） |
| 统计方式 | `String.length`（中英文各算 1 个字符） |
| 显示位置 | 输入框右下角，格式 `当前/上限`（如 `12/100`） |
| 显示时机 | 始终显示（或仅聚焦时显示，可配置） |

### 3.2 达到上限时的行为

| 场景 | 行为 |
|------|------|
| 键盘输入达到上限 | 阻止继续输入，字数统计变为警告色（`#E54954`） |
| 粘贴超长文本 | 截断到上限长度，显示提示「已超出字数限制，多余内容已截断」 |
| IME 确认后超限 | 保留已确认文字（可能暂时超限），下次输入时阻止 |

### 3.3 字数接近上限的视觉提示

| 剩余字数 | 视觉变化 |
|---------|---------|
| > 20% 上限 | 正常色（`#879199`） |
| ≤ 20% 上限 | 警告色（`#F59300`） |
| = 0（已满） | 错误色（`#E54954`） |

---

## 四、与搜索框的关系

当 Input 用于搜索场景时：

| 规则 | 说明 |
|------|------|
| composing 期间不发请求 | 避免用拼音字母去搜索 |
| compositionend 后 debounce | 确认文字后等待 300ms 再发请求 |
| 连续输入合并 | 快速输入多个字时只发最后一次请求 |

---

## 五、自检清单

- [ ] 中文输入法输入过程中不触发校验
- [ ] 拼音确认后才触发 onChange 和校验
- [ ] 字数统计不计算 composing 中的拼音字母
- [ ] 达到字数上限时阻止继续输入
- [ ] 粘贴超长文本正确截断并提示
- [ ] 字数接近上限时颜色变化（警告→错误）
- [ ] 搜索场景 composing 期间不发请求
