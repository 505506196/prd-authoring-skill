---
name: 选项卡 Tabs（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius}.md
---

# 选项卡 Tabs（新风格）

> 下划线指示条统一 3px 主色；新增胶囊 Segmented 变体；卡片 Tabs 带 8px 圆角。

---

## 一、变体

| 变体 | 说明 |
|------|------|
| Line（默认）| 文字 + 下方主色指示条 |
| Card | 上方圆角卡片，激活项主色填充 |
| Segmented | 胶囊切换，用于小区块内的视图切换 |
| Capsule | 浅色底 + 胶囊按钮，登录 / 身份场景 |

---

## 二、Line

| 属性 | 值 |
|------|-----|
| 容器底边 | 1px `--border` |
| 项间距 | 24px |
| 项 padding | 0 4px |
| 项高度 | 40px |
| 默认文字 | `--text-500`，14 / 22 Regular |
| Hover 文字 | `--text-900` |
| 激活文字 | `--primary-600`，Semibold |
| 激活指示条 | 3px `--primary-600`，底部，圆角 2px |
| 指示条动画 | `transform` 过渡 200ms |

---

## 三、Card

```
┌───────┐┌───────┐┌───────┐
│  概览 ││ 考生  ││ 考官  │
└───────┴┴───────┴┴───────┘
```

| 属性 | 值 |
|------|-----|
| 项背景（默认）| `#F1F5F9` |
| 项背景（激活）| `--primary-600` |
| 项文字（默认）| `--text-500` |
| 项文字（激活）| `#FFF` |
| 项高度 | 36px |
| 水平 padding | 16px |
| 圆角 | 8px（仅上两角）/ 胶囊整体包裹 |
| 项间距 | 2px |

---

## 四、Segmented

```
┌────────┬────────┬────────┐
│ 全部   │ 进行中 │ 已完成 │
└────────┴────────┴────────┘
```

| 属性 | 值 |
|------|-----|
| 容器背景 | `#F1F5F9` |
| 容器圆角 | 4px |
| 容器 padding | 2px |
| 项高度 | 32px |
| 项背景（默认）| 透明 |
| 项背景（激活）| `#FFF` |
| 项阴影（激活）| `0 1px 2px rgba(15,23,42,.08)` |
| 项文字（默认）| `--text-500` |
| 项文字（激活）| `--primary-600` |
| 项圆角 | 8px |

---

## 五、Capsule（登录场景）

| 属性 | 值 |
|------|-----|
| 容器背景 | `--primary-50` |
| 容器圆角 | 999px |
| 项高度 | 40px |
| 项水平 padding | 20px |
| 项文字（默认）| `--primary-600` |
| 项文字（激活）| `#FFF` |
| 项背景（激活）| `--primary-600`（实色）|
| 项圆角（激活）| 999px |

---

## 六、可关闭 / 可编辑

| 元素 | 规格 |
|------|------|
| 关闭图标 | `x-mark` 12px，距文字 4px |
| 关闭 hover | 背景 `#F1F5F9` 圆角 4px |
| 新建按钮 | `plus` 16px，与最后一个 tab 间距 8px |

---

## 七、滚动 / 溢出

| 元素 | 规格 |
|------|------|
| 左右滚动箭头 | 32×32 圆角 4px，`chevron-left/right` 16px |
| 渐变遮罩 | 容器两端 40px 渐变 `to left/right, #FFF, transparent` |

---

## 八、CSS 变量

```css
:root[data-theme="new-style"] {
  --tabs-line-h: 40px;
  --tabs-line-gap: 24px;
  --tabs-line-indicator: var(--primary-600);
  --tabs-line-indicator-h: 3px;

  --tabs-card-h: 36px;
  --tabs-card-radius: 8px;
  --tabs-card-bg: #F1F5F9;
  --tabs-card-bg-active: var(--primary-600);

  --tabs-seg-h: 32px;
  --tabs-seg-container-radius: 4px;
  --tabs-seg-item-radius: 8px;
  --tabs-seg-bg-active: #FFFFFF;
  --tabs-seg-shadow-active: 0 1px 2px rgba(15,23,42,.08);

  --tabs-capsule-h: 40px;
  --tabs-capsule-container-bg: var(--primary-50);
  --tabs-capsule-active-bg: var(--primary-600);
}
```
