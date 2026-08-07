---
name: 按钮交互规范 — Loading 防重复点击与键盘可达
category: interaction
scene: loading-state
status: stable
component: button
paired-with: ../../button.md
applies-to: 所有 Button 组件（Primary/CTA/Secondary/Outline/Danger/Success/Ghost/Text）
---

# 按钮交互规范 — Loading 防重复点击 / Disabled 反馈 / 键盘可达

> **本文件解决「按钮在异步操作中被重复点击」「禁用按钮静默无响应」「键盘用户无法操作」三类问题。**
>
> 视觉规范见 [`../../button.md`](../../button.md)，本文件只补行为。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **异步不可重入** | 点击触发异步后，按钮立即进入 loading 态，期间无视点击 |
| **禁用要可解释** | 禁用按钮 hover 时给出原因提示，不允许"灰着不响应" |
| **键盘可达** | Tab 可聚焦、Space/Enter 可触发、Focus Ring 可见 |
| **状态切换无闪烁** | loading→default 切换时按钮宽度保持稳定 |

---

## 二、Loading 态行为

### 2.1 触发时机

| 触发源 | 行为 |
|-------|------|
| 异步操作（保存 / 提交 / 删除）| 点击瞬间立即进入 loading，不等服务器返回 |
| 文件上传 / 下载 | 进入 loading，期间显示进度（可选）|
| 跳转操作（路由切换前需校验）| 校验期间 loading；校验通过 / 失败后切回 |

> **关键约束：** `onClick` 内的异步调用必须由组件自身管理 loading 态，不允许业务方手动 setState。

### 2.2 视觉表现

| 元素 | 规则 |
|------|------|
| 文字 | 保留原文字（不替换为"加载中…"），避免宽度跳变 |
| 图标位置 | 用 16/20/24px Spinner 替换原前置图标；如无前置图标，则插入到文字左侧 8px |
| Spinner 颜色 | 与按钮文字同色（Primary→白色，Outline→主色，Danger→白色）|
| 透明度 | 整体 0.7（区分于 disabled 的 0.5）|
| cursor | `cursor: wait` |

### 2.3 防重入逻辑

```
点击事件触发
  ├─ loading === true → 直接 return，不触发 onClick
  └─ loading === false → 进入 loading，调用 onClick
                          ├─ Promise resolve → loading = false
                          └─ Promise reject → loading = false + Toast 错误
```

### 2.4 最小 loading 时长

| 场景 | 最小展示 | 说明 |
|------|---------|------|
| 默认 | 300ms | 接口快于 300ms 也保持显示 300ms，避免闪烁 |
| 长任务 | 实际时长 | 超过 300ms 按真实进度显示 |

> **不使用最小时长会导致快速接口下按钮"闪一下"，用户感知不到反馈。**

---

## 三、Disabled 态行为

### 3.1 禁用条件清单

| 类型 | 触发条件 | 是否需要提示 |
|------|---------|-------------|
| 表单未通过校验 | 必填项未填 / 格式错 | **必须**（Tooltip 显示原因）|
| 权限不足 | 用户角色不允许 | **必须**（Tooltip "无操作权限"）|
| 业务限制 | 如"未满 24 小时不可重发" | **必须**（Tooltip 显示具体原因）|
| 加载中 | loading 态 | 不需要（已有 Spinner 表达）|

### 3.2 Hover 反馈

- 禁用按钮**仍可 hover**，触发 Tooltip 解释原因
- Tooltip 复用 [`../../tooltip/interaction/trigger-positioning.md`](../../tooltip/interaction/trigger-positioning.md) 规则
- Tooltip 文案必须**具体到原因**：
  - ✅ "请先勾选至少一条记录"
  - ❌ "按钮已禁用"

### 3.3 点击行为

- 禁用按钮 `pointer-events: none` 不阻断（因为要保留 hover）
- `onClick` 在禁用态下**不触发**（组件内部判断）
- 不允许悄无声息：**禁用按钮被点击时，触发对应 Tooltip 抖动 1 次**（震荡 200ms）以提示用户注意

---

## 四、键盘可达

### 4.1 焦点

| 状态 | Focus Ring |
|------|-----------|
| `:focus-visible` | `box-shadow: var(--shadow-focus-ring)` |
| `:focus`（鼠标点击触发的）| 不显示 ring（避免点击后残留焦点环）|

### 4.2 键盘触发

| 按键 | 行为 |
|------|------|
| Space | 按下时按钮进入 active 态（视觉同 mouse down），松开触发 onClick |
| Enter | 按下立即触发 onClick（不等松开）|
| Tab | 移动焦点到下一个可聚焦元素 |
| Shift+Tab | 反向移动 |

### 4.3 焦点陷阱（Dialog 内按钮）

- 弹窗中 Tab 循环到最后一个按钮后，下一次 Tab 回到第一个可聚焦元素
- 详见 [`../../dialog/interaction/focus-trap.md`](../../dialog/interaction/focus-trap.md)

---

## 五、按钮组焦点

### 5.1 工具栏 / Form Footer 中的按钮组

| 规则 | 说明 |
|------|------|
| Tab 顺序 | 按 DOM 顺序，不允许 `tabindex` 跳跃 |
| 主操作位置 | 右侧（弹窗）/ 左侧（页面工具栏）|
| 默认焦点 | 弹窗打开时自动聚焦**主操作按钮**（除危险操作）|
| 危险操作默认焦点 | 默认聚焦**取消按钮**，防止误回车 |

### 5.2 多按钮组合（如"上一步 / 下一步"）

- 两个按钮间距 8px（参考 button.md `--btn-group-gap`）
- 主操作处于 Tab 顺序末尾
- 不允许在 Tab 顺序中插入其他控件

---

## 六、特殊场景

### 6.1 删除 / 重置等危险操作

- 必须配合 Popconfirm 或 Dialog 二次确认
- 直接点击不允许触发不可逆动作
- 详见 [`../../popconfirm/interaction/positioning.md`](../../popconfirm/interaction/positioning.md)

### 6.2 防抖按钮（如"发送验证码"）

| 阶段 | 表现 |
|------|------|
| 点击瞬间 | 进入 loading（接口）|
| 接口返回成功 | 切换为倒计时态：文字"60s 后重发"，按钮禁用 |
| 倒计时结束 | 文字恢复"获取验证码"，按钮恢复可用 |

> 倒计时期间按钮文字必须使用 `tabular-nums` 防止宽度抖动。

### 6.3 CTA 的 loading 表现

- 实色背景保持不变
- Spinner 替换尾部箭头位置（不替换文字前的图标）
- 整体透明度 0.85（比标准 loading 高一档）

---

## 七、自检清单

- [ ] 异步按钮点击后 300ms 内可见 Spinner，期间无法重复点击
- [ ] 异步成功 / 失败后 loading 态消失
- [ ] 禁用按钮 hover 后弹出 Tooltip 显示具体原因
- [ ] 禁用按钮被点击时 Tooltip 抖动一次
- [ ] Tab 键可聚焦按钮，Focus Ring 可见
- [ ] Space 按下显示 active 态，松开触发 onClick
- [ ] Enter 按下立即触发 onClick
- [ ] 弹窗内 Tab 循环不跳出弹窗
- [ ] 危险操作弹窗默认焦点在"取消"
- [ ] 防抖按钮的倒计时数字使用 `tabular-nums`
- [ ] CTA-Gradient loading 时尾部箭头被替换为 Spinner，文字保留

---

## 八、不适用场景

- **链接型 Text 按钮** 跳转外部 URL：不进入 loading（浏览器自身处理）
- **纯展示文字按钮**（如"剩余 5 次"）：本规范不适用，应用 Tag 或 Text 组件
- **持续按住才生效的按钮**（如"长按删除"）：另行设计交互，不走 Loading 态
