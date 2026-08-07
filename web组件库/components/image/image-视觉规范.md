---
name: 图片 Image（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows}.md
---

# 图片 Image（新风格）

> 统一圆角；带占位 / 加载 / 错误三态；可选懒加载 + 渐显；不强制裁切比例但推荐 `object-fit: cover`。

---

## 一、尺寸与圆角

图片本身尺寸由业务决定。圆角按容器层级选择：

| 场景 | 圆角 |
|------|------|
| 头像（圆形）| 999px |
| 缩略图 / 图标 | 4px |
| 卡片大图 | 8px |
| 英雄区大图 | 12px |
| 表格内小图 | 2px |

---

## 二、加载态（Skeleton）

| 属性 | 值 |
|------|-----|
| 背景 | `--border-soft` |
| 渐变高亮 | `#F1F5F9` shimmer 1.4s |
| 与 loading.md Skeleton 一致 |

---

## 三、错误态

| 元素 | 规格 |
|------|------|
| 背景 | `--surface-muted` |
| 边框 | 1px dashed `--border-strong` |
| 图标 | `image-off` 24px，`--text-400`，居中 |
| 文案 | `图片加载失败`，12/18 Regular，`--text-500`，距图标 8px |

---

## 四、渐显动画

图片从骨架切到真实图：
```css
img.loaded {
  animation: fade-in .3s ease;
}
@keyframes fade-in {
  from { opacity: 0; transform: scale(.98); }
  to   { opacity: 1; transform: scale(1); }
}
```

---

## 五、头像 Avatar 变体

| 尺寸 | 直径 | 字号（首字母）|
|------|------|--------------|
| XS | 20px | 10px Semibold |
| SM | 24px | 12px Semibold |
| Default | 32px | 14px Semibold |
| LG | 40px | 16px Semibold |
| XL | 56px | 20px Semibold |

| 属性 | 值 |
|------|-----|
| 形状 | 圆形（`--r-pill`）|
| 边框 | 2px `#FFF`（群组叠加场景） |
| 背景（无图）| `--primary-100` + `--primary-600` 首字母 |
| 群组叠加 | 左右错位 -8px，zIndex 递减 |

---

## 六、CSS 变量

```css
:root[data-theme="new-style"] {
  --img-radius-sm: 2px;
  --img-radius-md: 4px;
  --img-radius-lg: 8px;
  --img-radius-xl: 12px;
  --img-radius-full: 999px;

  --img-placeholder-bg: var(--border-soft);
  --img-placeholder-highlight: #F1F5F9;

  --img-error-bg: var(--surface-muted);
  --img-error-border: 1px dashed var(--border-strong);
  --img-error-icon: var(--text-400);
  --img-error-text: var(--text-500);

  --avatar-xs: 20px;
  --avatar-sm: 24px;
  --avatar-md: 32px;
  --avatar-lg: 40px;
  --avatar-xl: 56px;
}
```
