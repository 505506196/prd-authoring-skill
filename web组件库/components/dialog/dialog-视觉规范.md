---
name: 弹窗 Dialog（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows,spacing}.md
---

# 弹窗 Dialog（新风格）

> 容器圆角走紧凑 12px；遮罩带背景模糊；头部支持 20×20 色图标 Tile + 标题；底部按钮右对齐 Outline + Primary 组合。

---

## 一、规格

| 属性 | 值 |
|------|-----|
| 容器圆角 | 12px (lg) |
| 容器背景 | `#FFF` |
| 容器阴影 | `--shadow-elevated` |
| 容器动画 | `opacity 0→1` + `scale(.96)→1`，180ms |
| 遮罩 | `rgba(15,23,42,.45)` + `backdrop-filter: blur(4px)` |
| 宽度 | 默认 480px；尺寸档见下表 |
| 水平居中 | `margin: auto`，垂直 `top: 12vh` |

### 尺寸档

| 尺寸 | 宽度 |
|------|------|
| SM | 400px |
| Default | 480px |
| MD | 640px |
| LG | 800px |
| XL | 960px |

---

## 二、结构

```
┌──────────────────────────────────┐
│  [◼]  标题                    ✕  │  ← Header 20px 28px
│  副标题（可选）                    │
├──────────────────────────────────┤
│                                  │
│           Body 内容                │  ← 28px 20px
│                                  │
├──────────────────────────────────┤
│                [取消]  [确认]     │  ← Footer 20px 28px，右对齐
└──────────────────────────────────┘
```

### 2.1 Header

| 元素 | 规格 |
|------|------|
| Padding | 20px 28px |
| 图标 Tile（可选）| 20×20，2px 圆角，主题色浅底 |
| 标题 | 18 / 28 Semibold，`--text-900` |
| 副标题 | 12 / 18 Regular，`--text-500` |
| 关闭按钮 | 32×32 圆角 8px，Hover `--fill-hover` |
| 底部分隔 | 1px `--border-soft` |

### 2.2 Body

| 属性 | 值 |
|------|-----|
| padding | 20px 28px |
| 最大高度 | 60vh（超出滚动）|
| 字号 | 14 / 22 Regular，`--text-700` |

### 2.3 Footer

| 属性 | 值 |
|------|-----|
| padding | 20px 28px |
| 对齐 | 右对齐 |
| 按钮间距 | 8px |
| 分隔 | 1px `--border-soft`（顶部）|
| 按钮组合 | `[Outline 取消]` + `[Primary 确认]` |
| 危险操作 | `[Outline 取消]` + `[Danger 确认]` |

---

## 三、变体

| 变体 | 说明 |
|------|------|
| Default | 三段式（标准）|
| Confirm | 居中 icon + 标题 + 文字 + 底部按钮组 |
| Minimal | 无 Header 分隔线，用于表单弹窗 |
| Fullscreen | 占满视口，圆角 0，顶部 16px 关闭按钮 |

### 3.1 Confirm 专用

| 元素 | 规格 |
|------|------|
| 图标（居中）| 40×40，类型对应主题色 |
| 标题（居中）| 18 / 28 Semibold |
| 描述（居中）| 14 / 22 Regular，`--text-500` |
| 底部对齐 | 居中 |

| 图标类型 | 颜色 |
|---------|------|
| 询问（默认）| `--primary-600` |
| 成功 | `--accent-green-600` |
| 警告 | `--warning-500` |
| 危险 | `--danger-500` |

---

## 四、交互

| 交互 | 行为 |
|------|------|
| 点击遮罩 | 关闭（Confirm 变体禁用）|
| 按 Esc | 关闭 |
| 点击确认 | 可传入 loading 态，期间禁用确认按钮 |
| 嵌套弹窗 | 允许 2 级，遮罩透明度叠加至 0.6 |
| body 锁定滚动 | 弹窗打开时 `overflow: hidden` |

---

## 五、CSS 变量

```css
:root[data-theme="new-style"] {
  --dialog-w-sm: 400px;
  --dialog-w-md: 480px;
  --dialog-w-lg: 640px;
  --dialog-w-xl: 800px;
  --dialog-radius: 12px;
  --dialog-shadow: var(--shadow-elevated);
  --dialog-overlay: rgba(15,23,42,.45);
  --dialog-overlay-blur: blur(4px);

  --dialog-header-px: 28px;
  --dialog-header-py: 20px;
  --dialog-body-px: 28px;
  --dialog-body-py: 20px;
  --dialog-footer-px: 28px;
  --dialog-footer-py: 20px;
  --dialog-footer-gap: 8px;

  --dialog-title: 18px/28px 600;
  --dialog-subtitle: 12px/18px 400;
  --dialog-close-size: 32px;
  --dialog-close-radius: 8px;
}
```
