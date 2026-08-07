---
name: 单选框 Radio（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius}.md
---

# 单选框 Radio（新风格）

> 圆形容器，选中态主色边框 + 主色内圆点。新增 Radio Card（大选项）变体，用于登录身份选择、流程分支等场景。

---

## 一、Radio（基础）

### 1.1 尺寸

| 尺寸 | 外圈 | 内点（选中）| 字号（标签）|
|------|------|------------|-------------|
| SM | 14 × 14 | 6px | 12 / 18 Regular |
| Default | 16 × 16 | 8px | 14 / 22 Regular |

### 1.2 状态

| 状态 | 外圈边框 | 背景 | 内点 |
|------|---------|------|------|
| 默认 | 1px `--border-strong` | `#FFF` | 无 |
| Hover | 1px `--primary-400` | `#FFF` | 无 |
| 已选 | 2px `--primary-600` | `#FFF` | `--primary-600` 圆 |
| Focus | 2px `--primary-600` + focus ring | — | — |
| 禁用 未选 | 1px `--border` | `#F1F5F9` | — |
| 禁用 已选 | 2px `--primary-300` | `#F1F5F9` | `--primary-300` |

### 1.3 标签对齐

- 容器与标签间距 8px
- 垂直居中对齐

---

## 二、Radio Group

| 排列 | 间距 |
|------|------|
| 横向 | 16px |
| 竖向 | 12px |

---

## 三、Radio Card（大卡片单选，新风格主打）

> 用于身份入口、流程分支、付费方案等"选一个"场景。

### 3.1 结构

```
┌──────────────────────────────────┐
│  [图标 Tile]  标题                │
│               说明文字             │
│               [胶囊标签]        [→]│  ← 右上角箭头 hover 显现
└──────────────────────────────────┘
```

### 3.2 规格

| 属性 | 值 |
|------|-----|
| padding | 20px |
| 圆角 | 12px (lg) |
| 背景 | `#FFF` |
| 边框（默认）| 1px `--border` |
| 阴影（默认）| `--shadow-card` |
| 图标 Tile | 44×44，按角色切主题色 |

### 3.3 状态

| 状态 | 边框 | 阴影 | 背景 | 其他 |
|------|------|------|------|------|
| 默认 | 1px `--border` | `--shadow-card` | `#FFF` | — |
| Hover | 1px `--primary-300` | `--shadow-hover` | `#FFF` | `translateY(-2px)` |
| 已选 | 2px `--primary-600` | `--shadow-hover` + focus-ring | `#FFF` | Tile 底色切换深色 |
| 禁用 | 1px `--border-soft` | 无 | `#F1F5F9` | 文字 `--text-400`，`cursor: not-allowed` |

### 3.4 内部元素

| 元素 | 规格 |
|------|------|
| 标题 | 18 / 28 Semibold，`--text-900` |
| 说明 | 14 / 22 Regular，`--text-500` |
| 胶囊标签 | 参考 Tag · Light SM |
| 右上角箭头 | 20px `chevron-right`，默认 `--text-400`，选中态 `--primary-600` |

---

## 四、CSS 变量

```css
:root[data-theme="new-style"] {
  --radio-size-sm: 14px;
  --radio-size-md: 16px;
  --radio-border: var(--border-strong);
  --radio-border-hover: var(--primary-400);
  --radio-border-checked: var(--primary-600);
  --radio-dot: var(--primary-600);
  --radio-label-gap: 8px;

  --radio-card-padding: 20px;
  --radio-card-radius: 12px;
  --radio-card-border: 1px solid var(--border);
  --radio-card-border-hover: 1px solid var(--primary-300);
  --radio-card-border-checked: 2px solid var(--primary-600);
  --radio-card-shadow: var(--shadow-card);
  --radio-card-shadow-hover: var(--shadow-hover);
}
```
