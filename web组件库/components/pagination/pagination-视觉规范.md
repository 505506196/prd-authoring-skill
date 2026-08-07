---
name: 分页 Pagination（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius}.md
---

# 分页 Pagination（新风格）

> 页码使用 32×32 或 40×40 胶囊/圆角按钮；当前页主色填充；支持跳页输入 + 每页数量选择。

---

## 一、尺寸

| 尺寸 | 按钮 | 字号 |
|------|------|------|
| SM | 32×32 | 12 / 18 Regular |
| Default | 36×36 | 14 / 22 Regular |
| LG | 40×40 | 14 / 22 Semibold |

---

## 二、按钮样式

### 2.1 页码按钮

| 状态 | 背景 | 文字 | 边框 | 圆角 |
|------|------|------|------|------|
| 默认 | `#FFF` | `--text-700` | 1px `--border` | 4px |
| Hover | `--primary-50` | `--primary-600` | 1px `--primary-300` | 4px |
| 当前页 | `--primary-600` | `#FFF` | 无 | 4px |
| 禁用 | `#F1F5F9` | `--text-400` | 1px `--border-soft` | 4px |

### 2.2 上/下页按钮

图标：`chevron-left` / `chevron-right` 16px；其他样式同页码按钮。

### 2.3 省略号

`…` 文字形式（14px `--text-400`），仅展示，不可点击。点击时切换为"快速跳 5 页"按钮（hover 变体）。

---

## 三、每页数量 Size Changer

使用 Select SM 变体（见 select.md），触发框形如 `10 条 / 页`。宽度 100~120px。

---

## 四、跳页输入 Quick Jumper

| 元素 | 规格 |
|------|------|
| 文字 | `前往` 14 / 22 `--text-500` |
| 输入框 | Input SM 32×56 宽，圆角 4px |
| 文字 | `页` 14 / 22 `--text-500` |
| 间距 | 文字与输入 4px |

---

## 五、数据统计

左侧展示：`共 254 条` / `第 21-40 条 / 共 254 条`。12 / 18 Regular，`--text-500`。

---

## 六、布局

```
共 254 条           [< 1 2 3 … 10 >]   [10 条/页 ▾]   前往 [__] 页
```

| 元素间距 | 值 |
|---------|-----|
| 左/中/右 三段布局 | `justify-content: space-between` |
| 同一组按钮/元素间 | 8px |

---

## 七、CSS 变量

```css
:root[data-theme="new-style"] {
  --pg-size-sm: 32px;
  --pg-size-md: 36px;
  --pg-size-lg: 40px;
  --pg-radius: 4px;
  --pg-gap: 8px;

  --pg-btn-bg: #FFFFFF;
  --pg-btn-border: var(--border);
  --pg-btn-text: var(--text-700);
  --pg-btn-bg-hover: var(--primary-50);
  --pg-btn-text-hover: var(--primary-600);
  --pg-btn-border-hover: var(--primary-300);
  --pg-btn-bg-active: var(--primary-600);
  --pg-btn-text-active: #FFFFFF;
  --pg-btn-bg-disabled: #F1F5F9;
  --pg-btn-text-disabled: var(--text-400);

  --pg-stat-text: var(--text-500);
  --pg-stat-font: 12px/18px 400;
}
```

---

## 八、与旧规范差异

| 维度 | 旧 | 新 |
|------|----|----|
| 按钮圆角 | 4px | 4px |
| 当前页 | `--color-primary` 填充 | `--primary-600` 填充 |
| Hover | 蓝边框 | 主色浅底 + 主色文字 + 主色边框 |
| 按钮尺寸 | 32×32 | 32/36/40 三档 |
