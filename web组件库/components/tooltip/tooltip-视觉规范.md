---
name: 文字提示 Tooltip（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows}.md
---

# 文字提示 Tooltip（新风格）

> 悬浮显示的纯文字提示。支持深色（默认）和浅色变体；圆角 8px（特例，比常规 sm 小一档以保持轻量）。

---

## 一、深色变体（默认）

| 属性 | 值 |
|------|-----|
| 背景 | `rgba(15,23,42,.92)` |
| 文字 | `#FFFFFF` |
| 字号 | 12 / 18 Medium |
| 圆角 | 8px |
| padding | 6px 10px |
| 阴影 | `0 4px 12px rgba(15,23,42,.15)` |
| 最大宽度 | 240px |

---

## 二、浅色变体

| 属性 | 值 |
|------|-----|
| 背景 | `#FFFFFF` |
| 文字 | `--text-900` |
| 边框 | 1px `--border` |
| 阴影 | `--shadow-dropdown` |
| 圆角 | 8px |
| padding | 6px 10px |

---

## 三、小箭头

6×6 CSS 三角，与 Tooltip 同色，指向触发元素中心。

---

## 四、定位

| 方位 | 默认偏移 |
|------|---------|
| top / bottom / left / right | 与触发元素间距 8px |
| 自动翻转 | 视口不足时自动切换方位 |

---

## 五、交互

| 交互 | 值 |
|------|-----|
| 触发 | mouseenter（默认）/ focus / click |
| 延迟显示 | 300ms |
| 延迟隐藏 | 100ms |
| 动画 | `opacity 0→1`，150ms |
| 禁用复用 | 同一目标不重复触发 |

---

## 六、使用规则

- 只放纯文字，不允许按钮 / 链接（交互类气泡用 Popconfirm / Popover）
- 不应遮挡关键内容
- 移动端不使用（无 hover）

---

## 七、CSS 变量

```css
:root[data-theme="new-style"] {
  --tip-dark-bg: rgba(15,23,42,.92);
  --tip-dark-text: #FFFFFF;
  --tip-light-bg: #FFFFFF;
  --tip-light-text: var(--text-900);
  --tip-light-border: 1px solid var(--border);

  --tip-radius: 8px;
  --tip-padding: 6px 10px;
  --tip-font: 12px/18px 500;
  --tip-max-w: 240px;
  --tip-gap: 8px;
  --tip-delay-in: 300ms;
  --tip-delay-out: 100ms;
}
```
