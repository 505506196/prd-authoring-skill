---
name: 全局消息 Message / Toast（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows}.md
---

# 全局消息 Message（Toast）（新风格）

> 白底 + 左侧 4px 主题色条 + 图标 + 文字；右侧滑入；轻量、非阻断。

---

## 一、容器

| 属性 | 值 |
|------|-----|
| 位置 | `top: 88px; right: 32px` |
| 宽度 | 自适应 240~360px |
| 背景 | `#FFF` |
| 圆角 | 8px |
| 阴影 | `--shadow-toast` |
| 左边条 | 4px，类型色 |
| padding | 14px 16px |
| 图标与文字间距 | 12px |
| 动画 | `translateX(24px) + fade` 进入；淡出 300ms |
| 自动关闭 | 默认 3s（可配置 1.5~10s）|

---

## 二、类型

| 类型 | 左条 | 图标 | 文字 |
|------|------|------|------|
| Info | `--primary-600` | `info-circle` 主色 | `--text-900` |
| Success | `--accent-green-600` | `check-circle` 绿色 | `--text-900` |
| Warning | `--warning-500` | `alert-triangle` 橙色 | `--text-900` |
| Danger | `--danger-500` | `alert-circle` 红色 | `--text-900` |
| Loading | `--primary-600` | `spinner` 旋转 | `--text-900` |

---

## 三、结构

```
┃ 🛈  操作已完成                              ✕
```

- 可选关闭按钮 `x-mark` 14px，`--text-400`，距右 14px
- 文字 14 / 22 Regular

---

## 四、堆叠

| 规则 | 值 |
|------|-----|
| 单屏最大数量 | 5 |
| 堆叠方向 | 从上到下 |
| 堆叠间距 | 12px |
| 超过 5 条 | 最早一条自动关闭 |

---

## 五、CSS 变量

```css
:root[data-theme="new-style"] {
  --msg-top: 88px;
  --msg-right: 32px;
  --msg-min-w: 240px;
  --msg-max-w: 360px;
  --msg-radius: 8px;
  --msg-bar-w: 4px;
  --msg-padding: 14px 16px;
  --msg-icon-gap: 12px;
  --msg-shadow: var(--shadow-toast);
  --msg-stack-gap: 12px;
  --msg-duration: 3000ms;
  --msg-enter: translateX(24px) opacity(0);
}
```
