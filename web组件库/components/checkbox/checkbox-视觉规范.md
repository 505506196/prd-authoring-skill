---
name: 多选框 Checkbox（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius}.md
---

# 多选框 Checkbox（新风格）

> 方形容器 2px 圆角，选中态使用主色填充 + 白色勾选。

---

## 一、尺寸

| 尺寸 | 容器 | 勾选图标 | 字号（标签） |
|------|------|---------|-------------|
| SM | 14 × 14 | 10px | 12 / 18 Regular |
| Default | 16 × 16 | 12px | 14 / 22 Regular |

---

## 二、状态

### 2.1 未选

| 属性 | 值 |
|------|-----|
| 背景 | `#FFF` |
| 边框 | 1px `--border-strong` |
| 圆角 | 2px |

### 2.2 Hover

| 属性 | 值 |
|------|-----|
| 边框 | 1px `--primary-400` |
| 外层 | 无阴影（克制）|

### 2.3 已选

| 属性 | 值 |
|------|-----|
| 背景 | `--primary-600` |
| 边框 | 无 |
| 勾选色 | `#FFF` |

### 2.4 Indeterminate（半选）

| 属性 | 值 |
|------|-----|
| 背景 | `--primary-600` |
| 指示 | 白色短横线（2px 宽，8px 长，居中）|

### 2.5 Focus

| 属性 | 值 |
|------|-----|
| 外环 | `0 0 0 4px rgba(21,92,203,.15)` |

### 2.6 禁用

| 属性 | 未选 | 已选 |
|------|------|------|
| 背景 | `#F1F5F9` | `--primary-300` |
| 边框 | 1px `--border` | 无 |
| 勾选色 | — | `rgba(255,255,255,.85)` |

---

## 三、与标签对齐

| 属性 | 值 |
|------|-----|
| 容器与标签间距 | 8px |
| 垂直对齐 | 基线对齐（标签行高中心 = 容器中心）|
| 鼠标热区 | 覆盖容器 + 标签 |

---

## 四、Checkbox Group

| 属性 | 值 |
|------|-----|
| 横向间距 | 16px |
| 竖向间距 | 12px |
| 全选 Checkbox | 置顶分组，与其他项用 1px `--border-soft` 分隔 |

---

## 五、CSS 变量

```css
:root[data-theme="new-style"] {
  --cb-size-sm: 14px;
  --cb-size-md: 16px;
  --cb-radius: 2px;
  --cb-border: var(--border-strong);
  --cb-border-hover: var(--primary-400);
  --cb-bg-checked: var(--primary-600);
  --cb-tick: #FFFFFF;
  --cb-bg-disabled: #F1F5F9;
  --cb-bg-checked-disabled: var(--primary-300);
  --cb-label-gap: 8px;
}
```

---

## 六、与旧规范差异

| 维度 | 旧 | 新 |
|------|----|----|
| 圆角 | 2px | 2px |
| Focus 外环 | 无 | 主色 4px 外环 |
| 禁用-已选背景 | `#94C9FF` | `--primary-300` = `#85B2FC` |
