---
name: 单选框交互规范 — Group 键盘 / Radio Card 卡片选择
category: interaction
scene: group-keyboard
status: stable
component: radio
paired-with: ../../radio.md
applies-to: 所有 Radio / Radio Group / Radio Card（身份选择 / 流程分支 / 付费方案）
---

# 单选框交互规范 — Group 键盘箭头 / Radio Card 卡片选择 / 焦点循环

> **本文件解决「Radio Group 不支持键盘箭头切换」「Radio Card 大区域不可点击」「无障碍标签缺失」三类问题。**
>
> 视觉规范见 [`../../radio.md`](../../radio.md)。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **键盘可全选** | Tab 进 Group → Arrow 切换选项 → 自动选中 |
| **大区域可点** | Radio Card 整个卡片都是热区 |
| **焦点跟随选中** | Tab 进 Group 时聚焦当前选中项（不是第一项）|
| **无障碍标签** | 必须有 `role="radiogroup"` + label |

---

## 二、Radio Group 键盘交互

### 2.1 焦点进入与离开

| 按键 | 行为 |
|------|------|
| Tab 进入 Group | 焦点落在**当前选中**的 Radio（而非第一项）|
| Tab 离开 Group | 焦点跳到下一个表单控件，**不在 Group 内循环** Tab |
| Shift+Tab | 反向移动 |

> **关键差异：** Radio Group 不像 Checkbox Group 每项都进 Tab 顺序——Radio Group **整个组只占一个 Tab 焦点位**，组内用 Arrow 导航。这是 ARIA 规范的标准。

### 2.2 组内导航

| 按键 | 行为 |
|------|------|
| ArrowDown / ArrowRight | 移动到下一个 Radio + **同时切换选中** |
| ArrowUp / ArrowLeft | 移动到上一个 Radio + **同时切换选中** |
| Home | 跳到第一项并选中 |
| End | 跳到最后一项并选中 |
| Space | 选中当前聚焦项（如未选中）|

> **Arrow 同时切换选中**：这是 Radio Group 与 Tab Group / Menu Group 的差异。Radio 强调"用户已经做出选择"。

### 2.3 禁用项跳过

- Arrow 导航时**跳过**禁用 Radio（不停留）
- Home / End 跳到第一个 / 最后一个**非禁用**项
- 全部禁用时 Group 不可聚焦（`tabindex="-1"`）

### 2.4 循环

- ArrowDown 从最后一项跳回第一项
- ArrowUp 从第一项跳到最后一项
- 循环只在 Group 内有效

---

## 三、Radio Card 大区域点击

### 3.1 热区

- **整个卡片**都是点击热区（不只是左上角的图标 Tile）
- 卡片任意位置点击即选中
- 内部嵌套链接 / 按钮时点击该子元素**不**触发卡片选中

### 3.2 hover 反馈

| 元素 | hover 表现 |
|------|----------|
| 整卡 | 边框变 `--primary-300`、阴影加深、`translateY(-2px)`（参考 radio.md 3.3）|
| 右上角箭头 | 从 `--text-400` 变 `--primary-400` |
| 图标 Tile | 不变（除非已选）|

### 3.3 选中后的箭头

- 默认箭头 `--text-400` 半透明
- 选中后 `--primary-600` 实色 + 实箭头
- Hover 未选时 `--primary-400`，hover 已选不变化

### 3.4 卡片间距

- 横向布局：卡片间距 16px
- 竖向布局：卡片间距 12px
- 距下方说明文字 24px

---

## 四、与表单校验集成

### 4.1 必填校验

| 触发时机 | 行为 |
|---------|------|
| 表单提交时 | 整个 Group 校验"是否选中至少 1 项" |
| Group 失焦后 | **不**单项校验（Radio 单项无"未选"概念）|

### 4.2 错误态视觉

- Group 容器边框变 `--danger-500`
- 下方显示错误文案 12/18，`--danger-500`
- 选中任一项后错误态消失

### 4.3 默认值

- 业务方不指定默认值时，Group 进入未选状态
- 已选状态不允许通过点击当前选中项取消（与 Checkbox 的核心差异）

---

## 五、动效

| 状态切换 | 过渡 |
|---------|------|
| Radio 内点 | `scale 0→1` 200ms cubic-bezier(.4,0,.2,1) |
| Radio Card 边框切换 | `border-color` 200ms |
| Radio Card translateY | hover 触发 200ms |
| 取消选中（仅程序触发，用户无法触发）| 反向 200ms |

---

## 六、无障碍

| 元素 | 必须的 ARIA |
|------|-----------|
| Group 容器 | `role="radiogroup"` + `aria-labelledby` 关联标题 |
| 每个 Radio | `role="radio"` + `aria-checked` + `aria-disabled` |
| Radio Card | 同上 + `aria-describedby` 关联说明文字 |

> ARIA 角色比 native `<input type="radio">` 灵活，但必须显式声明。

### 6.1 Radio Card 的语义

- 卡片本身扮演 Radio 角色，内部不嵌真实 `<input type="radio">`（避免双重交互）
- 内部图标、标题、说明仅为视觉装饰，`aria-hidden="true"`
- 整体由 `aria-checked` 统一表达状态

---

## 七、特殊场景

### 7.1 Radio Card 内的"了解更多"链接

- 链接独立可 Tab 聚焦
- 点击链接**不触发**卡片选中（事件 `stopPropagation`）
- 链接的 hover / focus 不影响卡片整体的 hover

### 7.2 Radio Card 用作"流程入口"

- 选中后通常下一步触发跳转（参考登录页身份选择）
- 选中状态保持 200ms 后再跳转，避免视觉突兀
- 跳转期间显示 loading 遮罩

### 7.3 与 Form 的 layout 联动

- Radio Group 在表单中通常 label 在左、Group 在右
- Radio Card 通常占满表单宽度，label 在上
- 详见 [`../../form/interaction/layout-responsive.md`](../../form/interaction/layout-responsive.md)

---

## 八、自检清单

- [ ] Tab 进入 Group 时聚焦当前选中项（非第一项）
- [ ] ArrowDown / ArrowRight 切换到下一项**并选中**
- [ ] ArrowUp / ArrowLeft 切换到上一项并选中
- [ ] Home / End 跳到首 / 末项
- [ ] Arrow 跳过禁用项
- [ ] Arrow 在首尾循环
- [ ] Space 选中当前聚焦项（如未选中）
- [ ] Radio Card 整个卡片可点击
- [ ] Radio Card 内嵌链接点击不触发卡片选中
- [ ] Radio Card 选中后箭头从灰变主色
- [ ] 已选 Radio **不能**通过点击取消
- [ ] Group 必填校验失败时容器边框变红
- [ ] 选中任一项后错误态消失
- [ ] role="radiogroup" + aria-checked 正确

---

## 九、不适用场景

- **多选语义**（"以下哪些适用"）：必须用 Checkbox
- **可逆切换**（"开 / 关"）：用 Switch
- **菜单选项**（"选择主题颜色后立即应用"）：业务上是 Radio 但 UX 上更适合 Segmented Control
- **超过 5 个选项**：Radio Group 不易扫读，建议改为 Select
