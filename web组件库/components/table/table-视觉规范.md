---
name: 表格 Table（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,spacing}.md
---

# 表格 Table（新风格）

> 表头背景 `#F1F5F9`；行分隔线 `--border-soft`；行 hover 浅主色；外层容器 8px 圆角裁切。

---

## 一、整体容器

| 属性 | 值 |
|------|-----|
| 圆角 | 8px |
| 边框 | 1px `--border` |
| 背景 | `#FFF` |
| 溢出 | `overflow: hidden` |
| 阴影（浮动表格）| `--shadow-card` |

---

## 二、表头 Header

| 属性 | 值 |
|------|-----|
| 背景 | `#F1F5F9`（`--table-head-bg`）|
| 高度 | 44px |
| 字号 | 12 / 18 Semibold |
| 文字色 | `--text-500` |
| 水平 padding | 16px |
| 底部边框 | 1px `--border` |
| 排序图标 | 12px `arrow-up-down`，`--text-400`；激活色 `--primary-600` |

---

## 三、行 Row

| 属性 | 值 |
|------|-----|
| 高度 | 48px（紧凑 40px / 宽松 56px）|
| 水平 padding | 16px |
| 字号 | 14 / 22 Regular |
| 文字色 | `--text-900` |
| 行分隔 | `border-bottom: 1px solid --border-soft` |
| Hover 背景 | `--primary-50` |
| 选中背景 | `--primary-50` |
| Disabled 背景 | `#F1F5F9` |
| Disabled 文字 | `--text-400` |
| 斑马纹（可选）| 奇数行 `#F1F5F9` |

### 3.1 粘性列

| 位置 | 阴影 |
|------|------|
| 左侧固定列 | 右侧投 `2px 0 8px rgba(15,23,42,.06)` |
| 右侧固定列 | 左侧投 `-2px 0 8px rgba(15,23,42,.06)` |

---

## 四、单元格内元素

| 元素 | 规则 |
|------|------|
| 数字 / 金额 / 分数 | `tabular-nums` 等宽数字 + 右对齐 |
| Avatar | 24×24，与文字间距 8px |
| Tag / Badge | 使用 Tag SM / Badge Status Pill |
| 操作按钮 | Text Primary SM，按钮之间 `|` 分隔或 8px 间距 |
| 长文本 | `overflow: hidden; text-overflow: ellipsis; white-space: nowrap` |

---

## 五、选择 Checkbox 列

| 属性 | 值 |
|------|-----|
| 列宽 | 40px |
| 垂直居中 | 是 |
| Checkbox | Default 尺寸 |

---

## 六、展开行 Expand

| 属性 | 值 |
|------|-----|
| 展开图标 | `chevron-right` 16px，展开后旋转 90° |
| 子行背景 | `#F1F5F9` |
| 子行 padding | 12px 16px |

---

## 七、空态 / 加载

| 状态 | 呈现 |
|------|------|
| 空 | 居中空态插画 + "暂无数据"，最小高 240px |
| 加载 | 整行骨架屏 + 顶部 Progress Bar 主色 |
| 错误 | 居中 `alert-circle` + 重试按钮 |

---

## 八、分页

使用 Pagination 组件，默认附在表格下方 16px 外；粘性底栏场景嵌入表格 Footer 内。

---

## 九、CSS 变量

```css
:root[data-theme="new-style"] {
  --table-radius: 8px;
  --table-border: 1px solid var(--border);

  --table-head-bg: #F1F5F9;
  --table-head-h: 44px;
  --table-head-font: 12px/18px 600;
  --table-head-text: var(--text-500);

  --table-row-h: 48px;
  --table-row-h-compact: 40px;
  --table-row-h-loose: 56px;
  --table-row-font: 14px/22px 400;
  --table-row-text: var(--text-900);
  --table-row-px: 16px;
  --table-row-border: 1px solid var(--border-soft);

  --table-row-bg-hover: var(--primary-50);
  --table-row-bg-selected: var(--primary-50);
  --table-row-bg-zebra: #F1F5F9;
}
```

---

## 十、与旧规范差异

| 维度 | 旧 | 新 |
|------|----|----|
| 外框圆角 | 4px | 8px |
| 表头背景 | `#F2F3F5` | `#F1F5F9` |
| 表头字重 | Regular | Semibold |
| 行分隔 | `--border-light` | `--border-soft` 更淡 |
| 行 Hover | 灰 `--color-fill-bg` | 主色浅 `--primary-50` |
