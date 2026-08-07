---
name: 标签交互规范 — 可关闭 / 可编辑 / Checkable / 超长截断
category: interaction
scene: closable-editable
status: stable
component: tag
paired-with: ../../tag.md
applies-to: 所有 Tag / Checkable Tag / 多选已选 Tag / Filter Tag
---

# 标签交互规范 — 关闭 / 编辑 / 选中 / 超长截断

> **本文件解决「Tag 删除没二次确认」「Tag 文本过长撑爆容器」「Checkable Tag 键盘不可达」「输入新增 Tag 没有限制」四类问题。**
>
> 视觉规范见 [`../../tag.md`](../../tag.md)。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **关闭可控** | 点击 ✕ 立即移除；可配置二次确认 |
| **编辑就地** | 双击 Tag 进入就地编辑，不打开弹窗 |
| **筛选可达** | Checkable Tag 支持键盘 Space 切换 |
| **不撑容器** | 超长 Tag 内部截断 + Tooltip 显示全文 |

---

## 二、可关闭 Tag

### 2.1 关闭按钮显示

| 条件 | 是否显示 |
|------|---------|
| 标签设为 closable | 始终显示 |
| Tag hover | 透明度从 0.6 提升到 1.0（参考 tag.md 第四节）|

> **不要"hover 才显示"：** 关闭按钮始终可见，但 hover 时变深，避免用户找不到入口。

### 2.2 关闭交互

| 触发 | 行为 |
|------|------|
| 点击 ✕ | 立即移除 Tag（默认）|
| 配置二次确认 | 弹出 Popconfirm "确定移除该标签？" |
| 键盘 Backspace / Delete | 当 Tag 聚焦时移除自身 |

### 2.3 移除动画

| 阶段 | 过渡 |
|------|------|
| 点击瞬间 | `opacity 1→0` + `scale 1→0.85` 200ms |
| 后续 Tag 重排 | `transform` 200ms cubic-bezier(.4,0,.2,1) |

> 移除动画期间该 Tag 的 ✕ 按钮不再响应（避免双击触发两次 onClose）。

### 2.4 触觉提示

- 移除"重要标签"（业务方标注）时，Toast "已移除：{tag name}" + Undo 按钮（5s 内可撤销）
- 撤销操作详见 [`../../notification/interaction/stack-queue.md`](../../notification/interaction/stack-queue.md)

---

## 三、可编辑 Tag

### 3.1 进入编辑

| 触发 | 行为 |
|------|------|
| 双击 Tag 文本区 | 文字变为 input，自动聚焦 + 全选文本 |
| 键盘 F2 | Tag 聚焦时按 F2 进入编辑 |

### 3.2 编辑期间

- input 高度与 Tag 一致；padding 同 Tag
- 字号 / 字色 / 字重保持不变（避免视觉跳变）
- 边框：`1px solid var(--primary-600)`，覆盖原 Tag 背景边缘
- IME composition 期间不触发 onChange（同 [`../../input/interaction/composition.md`](../../input/interaction/composition.md)）

### 3.3 退出编辑

| 触发 | 行为 |
|------|------|
| Enter | 保存修改并退出 |
| Esc | 放弃修改并退出 |
| 失焦（点击外部）| 保存修改并退出（与 Enter 一致）|
| 输入为空 + 失焦 | 询问是否删除该 Tag（用 Popconfirm）|

### 3.4 长度限制

- 编辑态 input 必须接受业务 maxLength
- 超出时输入被静默截断（不允许输入），不弹错误提示

---

## 四、Checkable Tag（筛选场景）

### 4.1 切换交互

| 触发 | 行为 |
|------|------|
| 点击 | 切换选中态 |
| 键盘 Tab | 聚焦该 Tag（Tag 必须 `tabindex="0"`）|
| 键盘 Space / Enter | 切换选中态 |

### 4.2 单选 vs 多选

| 模式 | 行为 |
|------|------|
| 多选（默认）| 多个 Tag 可同时选中 |
| 单选（exclusive）| 选中一个时其他自动取消 |
| 必选（required）| 至少 1 个选中，不能全部取消 |

### 4.3 Group 内键盘

| 按键 | 行为 |
|------|------|
| Tab | 进入 Group 的当前选中项（多选时是第一项），再 Tab 离开 |
| ArrowLeft / ArrowRight | Group 内移动焦点，不切换选中 |
| Space | 切换聚焦 Tag 选中态 |

> 这是 Tag Group 与 Radio Group 的差异：Radio Group 的 Arrow 直接切换选中；Checkable Tag 的 Arrow 只移动焦点，需要 Space 才切换。

### 4.4 全部 / 清空

| 元素 | 规则 |
|------|------|
| "全部" Tag | 通常居首，特殊样式（如选中时主色填充）|
| 点击"全部" | 取消其他所有选中，仅保留"全部"|
| 点击其他 Tag | 自动取消"全部"|

---

## 五、超长截断

### 5.1 单行截断

| 模式 | 实现 |
|------|------|
| 默认 | `max-width` + `overflow: hidden; text-overflow: ellipsis; white-space: nowrap` |
| max-width 推荐值 | SM 120px / Default 180px / LG 240px |

### 5.2 Tooltip

- 截断后 hover 显示 Tooltip 全文
- 触发延迟 300ms（同 [`../../tooltip/interaction/trigger-positioning.md`](../../tooltip/interaction/trigger-positioning.md)）
- 仅当**实际发生截断**时触发（运行时判断 `scrollWidth > clientWidth`）

---

## 六、新增 Tag（输入式）

### 6.1 触发新增

| 触发 | 行为 |
|------|------|
| 点击末尾的 "+ 添加" 按钮 | 输入框替换"+ 添加"，自动聚焦 |
| 键盘焦点在末尾 + Enter | 同上 |

### 6.2 提交新增

| 触发 | 行为 |
|------|------|
| Enter | 提交，input 切回"+ 添加"按钮 |
| 失焦 + 内容非空 | 提交 |
| 失焦 + 内容为空 | 取消，input 切回"+ 添加" |
| Esc | 取消 |
| 输入逗号 / 分号 | 提交并继续输入下一个（连续添加模式）|

### 6.3 重复 Tag 处理

- 提交时检测是否已存在同名 Tag
- 已存在：抖动现有 Tag + Toast"标签已存在"，input 内容保留待用户修改
- 不存在：新增并保留 input 焦点继续输入（连续模式）

### 6.4 数量上限

- 达到 max 时"+ 添加"按钮 disabled
- hover 显示 Tooltip "最多添加 N 个标签"

---

## 七、自检清单

- [ ] 关闭按钮始终可见，hover 时透明度变深
- [ ] 点击 ✕ 后 Tag 淡出 + 后续 Tag 重排动画 200ms
- [ ] 移除"重要标签"后 Toast 提供 5s Undo
- [ ] 双击 Tag 进入编辑态，文字自动全选
- [ ] 编辑态 Enter 保存 / Esc 放弃 / 失焦保存
- [ ] Checkable Tag 可被 Tab 聚焦，Space 切换
- [ ] Checkable Tag Group 中 Arrow 只移动焦点不切换选中
- [ ] 单选 Checkable 切换时其他自动取消
- [ ] "全部" Tag 与其他 Tag 互斥
- [ ] 超长 Tag 自动截断 + 实际截断时才触发 Tooltip
- [ ] 输入新增逗号 / 分号自动提交并继续输入
- [ ] 重复 Tag 提交时抖动 + Toast 提示
- [ ] 达到上限时"+ 添加"按钮 disabled

---

## 八、不适用场景

- **状态展示 Tag**（如"进行中"、"已完成"）：纯展示，不允许关闭 / 编辑
- **结构化标签**（如带颜色 / 图标的多元 Tag）：复杂 Tag 走业务定制
- **文章详情页的"分类 / Tag"链接**：本质是导航，应用 Link 而非 Tag
