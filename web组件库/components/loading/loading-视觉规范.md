---
name: 加载中 Loading（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows}.md
---

# 加载中 Loading（新风格）

> Spinner + Skeleton + Progress 三形态。Spinner 采用主色圆环旋转；Skeleton 使用浅灰渐变；Progress 使用主色渐变填充。

---

## 一、Spinner 圆环加载

| 尺寸 | 直径 | 线宽 |
|------|------|------|
| SM | 16px | 2px |
| Default | 24px | 2.5px |
| LG | 32px | 3px |
| XL | 48px | 4px |

| 属性 | 值 |
|------|-----|
| 圆环背景 | `--primary-100` |
| 旋转段 | `--primary-600` |
| 动画 | `rotate` 0.9s linear infinite |
| 形态 | 3/4 圆 |

### 1.1 浮层 Spin 容器

| 属性 | 值 |
|------|-----|
| 遮罩 | `rgba(255,255,255,.72)` |
| 背景模糊 | `blur(4px)` |
| 居中 | flex center |
| 距底部文案 | 12px 下方 |
| 文案 | 14 / 22 Regular，`--text-700` |

---

## 二、Skeleton 骨架屏

| 属性 | 值 |
|------|-----|
| 基础色 | `--border-soft` |
| 高亮色 | `#F1F5F9` |
| 动画 | shimmer 1.4s linear infinite（渐变横向移动）|
| 圆角 | 按元素原形继承（按钮 8px、卡片 12px、文字 2px）|

### 2.1 常用骨架块

| 元素 | 尺寸 |
|------|------|
| 文字行 | 高 14px，宽度 100% / 75% / 50% 三变体 |
| 标题 | 高 24px，宽 40% |
| 头像 | 40×40 圆形 |
| 按钮 | 40×96，圆角 8px |
| 卡片占位 | 高 160，圆角 12px |

---

## 三、Progress 进度条

| 属性 | 值 |
|------|-----|
| 轨道高 | 8px |
| 圆角 | 999px |
| 轨道背景 | `--border-soft` |
| 填充 | `linear-gradient(90deg, #155CCB, #4A8AEF)` |
| 100% 完成 | `--accent-green-600` 实色 |
| 过渡 | `width .3s cubic-bezier(.4,0,.2,1)` |

### 3.1 变体

| 变体 | 说明 |
|------|------|
| Line | 水平线（默认）|
| Circle | 环形（尺寸 56/72/96）|
| Dashboard | 半环仪表盘 |
| Steps | 分段式（如 4 段）|

### 3.2 Circle

| 属性 | 值 |
|------|-----|
| 轨道 | `--border-soft`，线宽 8px |
| 填充 | 主色渐变 |
| 中间文字 | 18 / 28 Semibold，`--text-900` |

---

## 四、文字 Loading（内联）

| 形态 | 规则 |
|------|------|
| 文字 + 3 点 | `加载中…` 最后 3 个点循环淡入 |
| 按钮 Loading | Spinner SM 16px 替换图标位置，禁用按钮 |

---

## 五、CSS 变量

```css
:root[data-theme="new-style"] {
  --spin-size-sm: 16px;
  --spin-size-md: 24px;
  --spin-size-lg: 32px;
  --spin-size-xl: 48px;
  --spin-track: var(--primary-100);
  --spin-arc: var(--primary-600);
  --spin-duration: 0.9s;

  --skeleton-base: var(--border-soft);
  --skeleton-highlight: #F1F5F9;
  --skeleton-duration: 1.4s;

  --prog-track-h: 8px;
  --prog-radius: 999px;
  --prog-track-bg: var(--border-soft);
  --prog-fill: linear-gradient(90deg, #155CCB, #4A8AEF);
  --prog-fill-done: var(--accent-green-600);
}
```
