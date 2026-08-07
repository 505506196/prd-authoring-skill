---
name: 图片预览 Image Preview（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows}.md
---

# 图片预览 Image Preview（新风格）

> 全屏遮罩 + 中心展示 + 底部操作工具栏；支持缩放 / 旋转 / 下载 / 翻页。

---

## 一、遮罩

| 属性 | 值 |
|------|-----|
| 背景 | `rgba(15,23,42,.85)` |
| 背景模糊 | `blur(8px)` |
| zIndex | 1400（dialog 级别）|

---

## 二、图片容器

| 属性 | 值 |
|------|-----|
| 居中 | flex center |
| 最大宽/高 | 视口 90% |
| 初始缩放 | `object-fit: contain` |
| 过渡 | `transform .2s` |

---

## 三、关闭按钮

| 属性 | 值 |
|------|-----|
| 位置 | 右上角 `top: 24px; right: 24px` |
| 尺寸 | 40×40 |
| 形状 | 圆形 `--r-pill` |
| 背景 | `rgba(255,255,255,.14)` |
| Hover | `rgba(255,255,255,.28)` |
| 图标 | `x-mark` 20px 白色 |

---

## 四、底部工具栏

```
┌───────────────────────────────────────────┐
│  [← 1/5 →]  [🔍-]  [100%]  [🔍+]  [↻]  [⬇]│
└───────────────────────────────────────────┘
```

| 属性 | 值 |
|------|-----|
| 位置 | `bottom: 40px`，居中 |
| 背景 | `rgba(15,23,42,.88)` |
| 圆角 | 8px |
| padding | 8px 12px |
| 高度 | 48px |
| 按钮间距 | 4px |
| 按钮背景 | 透明 |
| 按钮 Hover | `rgba(255,255,255,.12)` |
| 按钮圆角 | 4px |
| 按钮尺寸 | 32×32 |
| 图标 | 16px，白色 |
| 分隔 | 12px 高 1px `rgba(255,255,255,.2)` |

### 4.1 按钮清单

| 按钮 | 图标 | 功能 |
|------|------|------|
| 上一张 | `chevron-left` | 切到上一张 |
| 页码 | 文字 | `当前 / 总数` |
| 下一张 | `chevron-right` | 切到下一张 |
| 缩小 | `zoom-out` | 每次 -10% |
| 比例文字 | 文字 | `100%` 点击重置 |
| 放大 | `zoom-in` | 每次 +10% |
| 旋转 | `rotate-cw` | 每次 90° |
| 下载 | `download` | 触发下载 |

---

## 五、键盘

| 快捷键 | 行为 |
|--------|------|
| Esc | 关闭 |
| ← / → | 翻页 |
| +/- | 缩放 |
| 0 | 重置缩放 |
| R | 旋转 |

---

## 六、CSS 变量

```css
:root[data-theme="new-style"] {
  --iv-overlay: rgba(15,23,42,.85);
  --iv-overlay-blur: blur(8px);

  --iv-close-size: 40px;
  --iv-close-bg: rgba(255,255,255,.14);
  --iv-close-bg-hover: rgba(255,255,255,.28);

  --iv-toolbar-bg: rgba(15,23,42,.88);
  --iv-toolbar-radius: 8px;
  --iv-toolbar-h: 48px;
  --iv-toolbar-btn-size: 32px;
  --iv-toolbar-btn-radius: 4px;
  --iv-toolbar-btn-bg-hover: rgba(255,255,255,.12);
}
```
