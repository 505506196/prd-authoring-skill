---
name: 气泡确认 Popconfirm（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows,spacing}.md
---

# 气泡确认 Popconfirm（新风格）

> 轻量级二次确认气泡，适用于表格行内删除等场景。比 Dialog 更轻，比 Tooltip 更有操作性。

---

## 一、容器

| 属性 | 值 |
|------|-----|
| 背景 | `#FFF` |
| 圆角 | 4px |
| 阴影 | `--shadow-dropdown` |
| 边框 | 1px `--border` |
| padding | 12px 16px |
| 最小宽度 | 240px |
| 最大宽度 | 320px |
| 与触发元素间距 | 8px |
| 小箭头 | 8×8 CSS 三角，指向触发点 |

---

## 二、结构

```
┌──────────────────────────────┐
│ [⚠]  确认删除此条记录？        │
│      此操作不可撤销             │
│                    [取消][删除]│
└──────────────────────────────┘
```

| 元素 | 规格 |
|------|------|
| 图标 | 20×20，类型色 |
| 标题 | 14 / 22 Semibold，`--text-900` |
| 描述（可选）| 12 / 18 Regular，`--text-500` |
| 按钮组 | 右对齐，`[Outline SM 取消]` + `[Danger SM 确认]` |
| 图标与文字间距 | 10px |

---

## 三、类型

| 类型 | 图标 | 图标色 | 确认按钮 |
|------|------|--------|---------|
| 询问（默认）| `help-circle` | `--primary-600` | Primary SM |
| 警告 | `alert-triangle` | `--warning-500` | Warning SM |
| 危险 | `alert-circle` | `--danger-500` | Danger SM |

---

## 四、触发方式

| 方式 | 行为 |
|------|------|
| click（默认）| 点击触发元素打开 |
| hover | Hover 触发（不常用）|
| 手动 | 通过 API 控制 |

---

## 五、CSS 变量

```css
:root[data-theme="new-style"] {
  --pop-bg: #FFFFFF;
  --pop-radius: 4px;
  --pop-border: 1px solid var(--border);
  --pop-shadow: var(--shadow-dropdown);
  --pop-padding: 12px 16px;
  --pop-min-w: 240px;
  --pop-max-w: 320px;
  --pop-gap: 8px;
  --pop-icon-gap: 10px;
  --pop-button-gap: 8px;
}
```
