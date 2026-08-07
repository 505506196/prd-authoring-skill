---
name: 导航交互规范 — 键盘导航与无障碍
category: interaction
scene: keyboard
status: stable
component: navigation
paired-with: ../visual.md
applies-to: 侧边导航、顶部导航的键盘操作场景
---

# 导航交互规范 — 键盘导航与无障碍

> **本文件解决「键盘用户如何操作导航菜单」问题**：Tab 顺序、Arrow 键行为、Enter 激活、子菜单展开。
>
> 侧边栏收起/展开的过渡规范在同目录 [`collapse.md`](./collapse.md)。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **全键盘可达** | 不用鼠标也能完成所有导航操作 |
| **方向键直觉** | ↑↓ 在同级菜单间移动，→ 展开子菜单，← 收起 |
| **焦点可见** | 当前聚焦项有明显的 focus 视觉指示 |
| **不困住用户** | Tab 可以离开导航区域，不形成陷阱 |

---

## 二、Tab 键行为

### 2.1 进入与离开

| 按键 | 行为 |
|------|------|
| Tab（进入导航） | 聚焦到当前激活的菜单项（已选中项） |
| Tab（在导航内） | 离开导航区域，焦点移到主内容区 |
| Shift+Tab | 从主内容区回到导航 |

### 2.2 设计原理

- 导航作为一个整体只占一个 Tab stop
- 内部用 Arrow 键移动，不用 Tab 逐项遍历
- 这样键盘用户不必按 N 次 Tab 才能到达主内容

---

## 三、Arrow 键导航

### 3.1 侧边导航（垂直菜单）

| 按键 | 行为 |
|------|------|
| ArrowDown | 焦点移到下一个可见菜单项 |
| ArrowUp | 焦点移到上一个可见菜单项 |
| ArrowRight | 展开当前项的子菜单，焦点移到第一个子项 |
| ArrowLeft | 收起当前子菜单，焦点回到父级菜单项 |
| Home | 焦点移到第一个菜单项 |
| End | 焦点移到最后一个可见菜单项 |

### 3.2 顶部导航（水平菜单）

| 按键 | 行为 |
|------|------|
| ArrowRight | 焦点移到右侧下一个菜单项 |
| ArrowLeft | 焦点移到左侧上一个菜单项 |
| ArrowDown | 展开当前项的下拉菜单，焦点移到第一项 |
| ArrowUp | 下拉菜单内向上移动 |
| Escape | 收起下拉菜单，焦点回到触发项 |

### 3.3 循环规则

- 到达最后一项后 ArrowDown **不循环**回第一项（防止迷失）
- 到达第一项后 ArrowUp 同样不循环

---

## 四、Enter 与 Space 激活

| 按键 | 行为 |
|------|------|
| Enter | 激活当前聚焦的菜单项（导航到对应页面） |
| Space | 展开/收起有子菜单的项（不导航） |

### 区分规则

- 叶子节点（无子菜单）：Enter 导航，Space 也导航
- 父节点（有子菜单）：Enter 导航到该分组首页，Space 仅展开/收起子菜单

---

## 五、焦点视觉指示

| 状态 | 视觉表现 |
|------|---------|
| 聚焦（focus-visible） | 菜单项外围出现 `2px solid var(--primary-600)` 轮廓，offset `2px` |
| 聚焦 + 激活 | 轮廓 + 激活态背景色（参见 visual.md） |
| 仅激活（鼠标操作） | 无轮廓，仅激活态背景色 |

- 使用 `:focus-visible` 而非 `:focus`，避免鼠标点击也出现轮廓
- 轮廓不能被父容器 `overflow:hidden` 裁切

---

## 六、ARIA 属性要求

| 元素 | 属性 | 值 |
|------|------|-----|
| 导航容器 | `role` | `navigation` |
| 菜单列表 | `role` | `menubar`（顶部）/ `menu`（侧边） |
| 菜单项 | `role` | `menuitem` |
| 有子菜单的项 | `aria-expanded` | `true` / `false` |
| 有子菜单的项 | `aria-haspopup` | `true` |
| 当前页对应项 | `aria-current` | `page` |
| 禁用项 | `aria-disabled` | `true` |

---

## 七、自检清单

- [ ] Tab 进入导航聚焦到当前激活项
- [ ] Tab 再按一次离开导航到主内容区
- [ ] ArrowDown/Up 在同级菜单项间移动
- [ ] ArrowRight 展开子菜单
- [ ] ArrowLeft 收起子菜单回到父级
- [ ] Enter 激活菜单项（导航）
- [ ] 焦点项有明显的 focus-visible 轮廓
- [ ] 鼠标点击不出现焦点轮廓
- [ ] ARIA 属性正确（aria-expanded/aria-current）
