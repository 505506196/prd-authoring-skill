---
name: 面包屑交互规范 — 超长收起 / 折叠展开 / 跳转
category: interaction
scene: overflow-collapse
status: stable
component: breadcrumb
paired-with: ../../breadcrumb.md
applies-to: 所有 Breadcrumb（多级导航 / 长路径折叠 / 移动端）
---

# 面包屑交互规范 — 超长收起 / 折叠展开 / 单项截断 / 跳转

> **本文件解决「层级过深面包屑撑爆容器」「单项标题过长把后续挤出」「最后一级被误点击触发跳转」三类问题。**
>
> 视觉规范见 [`../../breadcrumb.md`](../../breadcrumb.md)。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **不撑容器** | 超过 4 级中间折叠为 `...` |
| **单项不挤压** | 单项最大 160px，超出 ellipsis + Tooltip |
| **跳转可靠** | 中间项点击跳转，最后一级不可点击 |
| **键盘可达** | Tab 可聚焦，Enter 跳转 |

---

## 二、层级折叠

### 2.1 触发条件

| 总层级 | 处理 |
|-------|------|
| ≤ 4 级 | 全部展开显示 |
| > 4 级 | 保留首项 + 末两项，中间折叠为 `...`（参考 breadcrumb.md 第四节）|

例：
```
首页 / 部门 A / 项目 B / 任务 C / 子任务 D / 详情页
↓
首页 / ... / 子任务 D / 详情页
```

### 2.2 折叠的展开

| 触发 | 行为 |
|------|------|
| 点击 `...` | 弹出 popover 显示折叠的所有层级 |
| popover 内点击层级 | 跳转到该层 + 关闭 popover |
| 点击 popover 外 | 关闭 popover |
| Esc | 关闭 popover |
| 键盘 Tab | 进入 popover 内 |

### 2.3 popover 视觉

| 元素 | 规则 |
|------|------|
| 背景 | `#FFF` |
| 圆角 | 8px |
| 阴影 | `--shadow-dropdown` |
| padding | 6px |
| 项高度 | 36px |
| 项字号 | 12/18 Regular |
| 项 hover | `--primary-50` 背景 |
| 项 padding | 12px 水平 |

---

## 三、单项截断

### 3.1 最大宽度

- 单项最大 160px（参考 breadcrumb.md 第二节）
- 超出时 `text-overflow: ellipsis`

### 3.2 Tooltip 显示完整文本

- 仅当**实际发生截断**时触发 Tooltip
- 触发延迟 300ms（同 [`../../tooltip/interaction/trigger-positioning.md`](../../tooltip/interaction/trigger-positioning.md)）
- Tooltip 内容为完整层级名称

### 3.3 当前页（最后一级）的截断

- 同样适用 160px 限制
- 但**不允许折叠到 ...**（用户必须知道当前在哪）
- 如总宽度无法容纳，优先收起前面的中间层级

---

## 四、跳转规则

### 4.1 可点击 vs 不可点击

| 层级 | 可点击 |
|------|-------|
| 中间层级（含返回按钮）| 可点击 |
| 最后一级（当前页）| **不可点击**（参考 breadcrumb.md 第一节）|
| 折叠的 ... | 可点击（弹出 popover）|

### 4.2 当前页视觉

- `--text-900` Semibold（参考 breadcrumb.md 第二节）
- cursor: default
- 不响应 hover 主色变化
- 不可 Tab 聚焦（`tabindex="-1"`）

### 4.3 中间层级

| 状态 | 表现 |
|------|------|
| 默认 | `--text-500` Regular |
| Hover | `--primary-600` |
| Active（点击瞬间）| `--primary-700` |
| Visited | 不变化（B 端导航不需要 visited 概念）|

---

## 五、返回按钮

### 5.1 显示规则

- 默认显示（参考 breadcrumb.md 第一节）
- 业务方可关闭（`showBack=false`）
- 历史栈为空时（首次直接打开此页）按钮 disabled + Tooltip"无上一页"

### 5.2 触发

| 触发 | 行为 |
|------|------|
| 点击"← 返回" | `router.back()` |
| 键盘 Alt+Left（可选） | 同上 |
| 浏览器原生返回按钮 | 不影响（独立机制）|

### 5.3 与面包屑的间距

- 返回按钮与第一个面包屑层级用 1px × 14px 竖线分隔
- 间距 8px（参考 breadcrumb.md 第二节）

---

## 六、键盘交互

### 6.1 Tab 顺序

```
返回按钮 → 第一层级 → 第二层级 → ... → ...（折叠时）→ 倒数第二层级 → 当前页（不聚焦）
```

> 当前页 `tabindex="-1"` 不进 Tab 顺序。

### 6.2 按键

| 按键 | 行为 |
|------|------|
| Tab | 在可聚焦层级间移动 |
| Enter | 触发跳转 / 展开 popover |
| Space | 同 Enter |
| Esc（popover 展开时）| 关闭 popover |

---

## 七、与 Layout 集成

### 7.1 位置

- 在白色内容卡片**外部**顶部（参考 breadcrumb.md 第三节）
- 与卡片左边缘对齐
- 与卡片间距 12px
- 与顶栏间距 8px

### 7.2 多 tab 嵌套

- Tab 内容使用面包屑时，面包屑应位于 Tab 内容区顶部
- 不允许"两层面包屑"（一个全局 + 一个 Tab 内）

---

## 八、动画

### 8.1 折叠 / 展开

- 总层级超过 4 时折叠为 `...`：进入页面时直接渲染折叠态，无动画
- 点击 `...` 展开 popover：fadeIn 200ms + scale .96→1
- 关闭 popover：fadeOut 150ms

### 8.2 hover 颜色过渡

- 100ms ease-in-out
- 链接颜色 `--text-500` → `--primary-600`

---

## 九、移动端

| 维度 | 桌面 | 移动 |
|------|------|------|
| 单项最大宽度 | 160px | 100px（屏幕窄）|
| 折叠阈值 | 4 级 | 3 级 |
| 显示返回按钮 | ✓ | 与导航栏返回按钮重复时可关闭 |
| popover 展开 | 浮层 | 底部抽屉式（更易点）|

---

## 十、自检清单

- [ ] 总层级 ≤4 时全部展开
- [ ] 总层级 >4 时中间折叠为 ...
- [ ] 折叠保留首项 + 末两项
- [ ] 点击 ... 弹出 popover
- [ ] popover 内点击层级跳转 + 关闭
- [ ] popover 外点击 / Esc 关闭
- [ ] 单项超过 160px 截断 + Tooltip
- [ ] Tooltip 仅在实际截断时触发
- [ ] 最后一级不可点击且不可 Tab 聚焦
- [ ] 中间层级 hover 主色，active 主色 700
- [ ] 返回按钮历史栈为空时 disabled
- [ ] Tab 在可聚焦层级间移动，跳过当前页
- [ ] Enter / Space 触发跳转
- [ ] popover 展开 fadeIn 200ms
- [ ] hover 颜色过渡 100ms
- [ ] 移动端折叠阈值降为 3 级，单项最大 100px

---

## 十一、不适用场景

- **流程式步骤**：用 Steps 而非 Breadcrumb
- **Tab 切换**：用 Tabs 而非 Breadcrumb
- **网站全局导航**：用 Navigation 而非 Breadcrumb
- **极简页面（仅 1 层）**：不显示 Breadcrumb（避免无意义占位）
