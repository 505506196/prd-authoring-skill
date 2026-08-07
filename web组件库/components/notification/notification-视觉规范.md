---
name: 通知 Notification（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows}.md
---

# 通知 Notification（新风格）

> 比 Message 更正式；支持标题 + 描述 + 操作；右上角堆叠；默认不自动关闭。

---

## 一、容器

| 属性 | 值 |
|------|-----|
| 位置 | `top: 88px; right: 32px` |
| 宽度 | 384px |
| 背景 | `#FFF` |
| 圆角 | 8px |
| 阴影 | `--shadow-elevated` |
| padding | 16px 20px |
| 图标 + 文字间距 | 16px |
| 默认关闭方式 | 手动 或 设置 timeout |

---

## 二、结构

```
┌────────────────────────────────────┐
│ [🛈]  标题                      ✕  │
│       描述文字行 1                  │
│       描述文字行 2                  │
│                     [查看] [忽略]   │
└────────────────────────────────────┘
```

| 元素 | 规格 |
|------|------|
| 图标容器（可选）| 32×32 圆角 4px，主题浅底 + 主题图标 |
| 标题 | 14 / 22 Semibold，`--text-900` |
| 描述 | 12 / 18 Regular，`--text-500` |
| 操作按钮 | Text Primary SM + Text Secondary SM，底部右对齐 |
| 关闭按钮 | 20×20，`x-mark` 14px，`--text-400` |

---

## 三、类型色板

| 类型 | 图标容器底色 | 图标色 |
|------|------------|--------|
| Info | `--primary-50` | `--primary-600` |
| Success | `--accent-green-100` | `--accent-green-600` |
| Warning | `--warning-100` | `--warning-500` |
| Danger | `--danger-100` | `--danger-500` |

---

## 四、动画

| 阶段 | 值 |
|------|-----|
| 进入 | `translateX(100%)→0` + `opacity 0→1`，300ms |
| 退出 | `translateX(24px)` + `opacity 1→0`，250ms |

---

## 五、CSS 变量

```css
:root[data-theme="new-style"] {
  --notif-top: 88px;
  --notif-right: 32px;
  --notif-w: 384px;
  --notif-radius: 8px;
  --notif-padding: 16px 20px;
  --notif-icon-size: 32px;
  --notif-icon-radius: 4px;
  --notif-icon-gap: 16px;
  --notif-shadow: var(--shadow-elevated);
}
```
