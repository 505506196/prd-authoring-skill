---
name: 导航 Navigation（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows,layout}.md
---

# 导航 Navigation（新风格）

> 两种核心形态：① 管理后台的**实底白 Sidebar**；② 业务模块的**主色实底 AppBar**。

---

## 一、Sidebar（管理后台）

### 1.1 容器

| 属性 | 值 |
|------|-----|
| 宽度（展开）| 240px |
| 宽度（折叠）| 64px |
| 背景 | `--surface`（实底白）|
| 右侧边 | 1px `--border` |
| 过渡 | `width .25s ease` |

### 1.2 菜单分组标题

| 属性 | 值 |
|------|-----|
| 字号 | 12 / 18 Semibold |
| 颜色 | `--text-400` |
| letter-spacing | 0.08em |
| text-transform | uppercase |
| padding | 12px 16px 8px |

### 1.3 一级菜单项

| 状态 | 背景 | 文字 | 图标 | 指示条 |
|------|------|------|------|--------|
| 默认 | 透明 | `--text-700` | `--text-500` | 无 |
| Hover | `--fill-hover` | `--text-900` | `--text-700` | 无 |
| 激活 | `--primary-50` | `--primary-600` | `--primary-600` | 左侧 3px |

| 属性 | 值 |
|------|-----|
| 高度 | 40px |
| 水平 padding | 12px 16px |
| 圆角 | 4px |
| 字号 | 14 / 22 Semibold |
| 图标大小 | 20px |
| 图标与文字间距 | 10px |
| 折叠箭头 | `chevron-down` 16px，展开 180° |
| 左侧激活指示条 | 3px × 20px，圆角 2px，主色 |

### 1.4 二级菜单项

| 属性 | 值 |
|------|-----|
| 高度 | 36px |
| 左 padding | 44px |
| 字号 | 12 / 18 Regular |
| 默认文字 | `--text-500` |
| Hover | `--fill-hover` |
| 激活 | `--primary-50` + `--primary-600` + Semibold |

### 1.5 折叠模式

| 属性 | 值 |
|------|-----|
| 菜单项 | 只显示 20px 图标，水平居中 |
| Hover | 右侧浮出 Tooltip 显示完整文字（使用 tooltip.md）|
| 分组标题 | 隐藏 |
| 折叠按钮 | 底部 32×32 圆角 4px，`panel-right-close` 图标 |

---

## 二、AppBar（业务模块蓝条）

### 2.1 容器

| 属性 | 值 |
|------|-----|
| 高度 | 64px |
| 背景 | `--primary-600`（实色）|
| 文字色 | `#FFFFFF` |
| 内 padding | 0 32px |

### 2.2 返回按钮

| 属性 | 值 |
|------|-----|
| 尺寸 | 40×40 |
| 背景 | `rgba(255,255,255,.14)` |
| 圆角 | 999px |
| 图标 | `arrow-left` 20px，白色 |
| Hover 背景 | `rgba(255,255,255,.24)` |

### 2.3 标题 / 面包屑

| 元素 | 规格 |
|------|------|
| 主标题 | 18 / 28 Semibold，白色 |
| 次标题 | 12 / 18 Regular，`rgba(255,255,255,.7)` |
| 返回按钮与标题间距 | 12px |

### 2.4 右侧胶囊操作

| 属性 | 值 |
|------|-----|
| 容器背景 | `rgba(255,255,255,.14)` |
| 圆角 | 999px |
| 高度 | 36px |
| 水平 padding | 14px |
| 字号 | 12 / 18 Medium |
| 文字 | 白色 |
| 图标 + 文字间距 | 6px |
| Hover | 背景 `rgba(255,255,255,.24)` |

常见胶囊：`🕐 09:45`、`已抽 42 人`、`👤 张三 退出`。

---

## 三、Topbar（普通后台顶栏）

| 属性 | 值 |
|------|-----|
| 高度 | 64px |
| 背景 | `rgba(255,255,255,.85)` + blur(12px) |
| 底部边 | 1px `--border` |
| 阴影 | `--shadow-topbar` |
| Logo 容器 | 40×40 圆角 4px，`linear-gradient(135deg,#155CCB,#1E6AE0)` |
| Logo 图标 | 白色 20px |
| 标题 | 16 / 24 Semibold，`--text-900` |
| 搜索框 | Default 44px，宽 360~480px |
| 右侧用户 chip | Avatar + 姓名 + chevron，`rgba(21,92,203,.08)` 底，999px 圆角 |

---

## 四、CSS 变量

```css
:root[data-theme="new-style"] {
  --nav-sidebar-w: 240px;
  --nav-sidebar-w-collapsed: 64px;
  --nav-sidebar-bg: var(--surface);

  --nav-l1-h: 40px;
  --nav-l1-radius: 4px;
  --nav-l1-px: 12px;
  --nav-l1-py: 0;
  --nav-l1-text: var(--text-700);
  --nav-l1-text-active: var(--primary-600);
  --nav-l1-bg-hover: var(--fill-hover);
  --nav-l1-bg-active: var(--primary-50);
  --nav-l1-indicator: 3px;

  --nav-l2-h: 36px;
  --nav-l2-pl: 44px;
  --nav-l2-text: var(--text-500);

  --nav-appbar-h: 64px;
  --nav-appbar-bg: var(--primary-600);
  --nav-appbar-chip-bg: rgba(255,255,255,.14);
  --nav-appbar-chip-radius: 999px;
}
```

---

## 五、与旧规范差异

| 维度 | 旧 | 新 |
|------|----|----|
| Sidebar 背景 | 白/深蓝 | 实底白 + 右边框 |
| 激活指示条 | 4px 实色 | 3px 圆角主色 |
| 菜单项圆角 | 4px | 4px |
| AppBar | 无蓝条变体 | 新增主色实底 AppBar |
| 右上操作 | 普通按钮 | 半透明白色胶囊 |
