---
name: 抽屉 Drawer（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows,spacing}.md
---

# 抽屉 Drawer（新风格）

> 从视口一侧滑入；仅朝向视口内的两个角使用 12px 圆角；遮罩同 Dialog。

---

## 一、方位与尺寸

| 方位 | 宽/高 | 圆角 |
|------|------|------|
| Right（默认）| 宽 480px | 左上 + 左下 各 12px |
| Left | 宽 480px | 右上 + 右下 各 12px |
| Top | 高 320px | 左下 + 右下 各 12px |
| Bottom | 高 320px | 左上 + 右上 各 12px |

尺寸档：
| 档位 | 宽/高 |
|------|------|
| SM | 360px |
| Default | 480px |
| LG | 640px |
| XL | 800px |
| Full | 100% |

---

## 二、结构

与 Dialog 一致：Header / Body / Footer 三段式。

| 属性 | 值 |
|------|-----|
| 背景 | `#FFF` |
| 阴影 | `--shadow-elevated`（靠视口内侧方向投影）|
| Header | 20px 24px，同 Dialog |
| Body | 24px，滚动区 |
| Footer | 20px 24px，右对齐按钮组 |
| 动画 | `transform: translateX(100%)→0`，220ms cubic-bezier(.2,0,0,1) |
| 遮罩 | 同 Dialog |

---

## 三、变体

| 变体 | 说明 |
|------|------|
| Default | 三段式 |
| No-Header | 无头部分隔线，用于轻量表单 |
| Tabbed | Body 顶部嵌 Tabs（用于多子页编辑）|
| Multi-Step | 带 Steps 顶部导航 |

---

## 四、交互

| 交互 | 行为 |
|------|------|
| 点击遮罩 | 关闭（可禁用）|
| 按 Esc | 关闭 |
| 多级 Drawer | 第二级从同侧再叠 40px 错位 |

---

## 五、CSS 变量

```css
:root[data-theme="new-style"] {
  --drawer-w-sm: 360px;
  --drawer-w-md: 480px;
  --drawer-w-lg: 640px;
  --drawer-w-xl: 800px;
  --drawer-radius: 12px;
  --drawer-shadow: var(--shadow-elevated);
  --drawer-overlay: rgba(15,23,42,.45);
  --drawer-transition: transform 220ms cubic-bezier(.2,0,0,1);

  --drawer-header-px: 24px;
  --drawer-header-py: 20px;
  --drawer-body-p: 24px;
  --drawer-footer-px: 24px;
  --drawer-footer-py: 20px;
  --drawer-footer-gap: 8px;
}
```
