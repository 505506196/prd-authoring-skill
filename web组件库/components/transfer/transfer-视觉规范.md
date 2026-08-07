---
name: 穿梭框 Transfer（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows}.md
---

# 穿梭框 Transfer（新风格）

> 左右两个列表面板 + 中间穿梭按钮；支持搜索 / 全选 / 分页 / 树形。

---

## 一、容器

```
┌─────────────────┐  [ > ]  ┌─────────────────┐
│  待选 · 240 项    │          │  已选 · 32 项     │
│  [搜索]           │  [ < ]  │  [搜索]           │
│  ──────────      │          │  ──────────      │
│  ☐ 项            │          │  ☐ 项            │
│  ☐ 项            │          │  ☐ 项            │
└─────────────────┘          └─────────────────┘
```

| 元素 | 规格 |
|------|------|
| 面板宽度 | 240px / 320px / 400px（可配置）|
| 面板高度 | 320px（默认）|
| 面板背景 | `#FFF` |
| 面板圆角 | 8px |
| 面板边框 | 1px `--border` |
| 面板阴影 | `--shadow-card` |
| 中间按钮间距 | 16px |

---

## 二、面板头

| 元素 | 规格 |
|------|------|
| 高度 | 44px |
| padding | 0 12px |
| 底部分隔 | 1px `--border-soft` |
| 标题 | 14 / 22 Semibold，`--text-900` |
| 计数 | 12 / 18 Regular，`--text-500`，`N 项` |
| 全选 Checkbox | Default 尺寸，左对齐 |
| 清空按钮 | Text Primary SM，右对齐 |

---

## 三、搜索

面板头下方可选搜索框：

| 属性 | 值 |
|------|-----|
| Search SM 变体 | 高 32px |
| padding | 8px 12px |

---

## 四、列表项

| 属性 | 值 |
|------|-----|
| 高度 | 36px |
| 水平 padding | 12px |
| 圆角 | 8px |
| 字号 | 14 / 22 Regular |
| Checkbox + 文字间距 | 8px |
| 默认文字 | `--text-900` |
| Hover 背景 | `--primary-50` |
| 选中背景 | `--primary-50` + 左侧 2px `--primary-600` 指示条（可选）|

---

## 五、穿梭按钮

| 属性 | 值 |
|------|-----|
| 按钮尺寸 | 32×32 |
| 图标 | `chevron-right` / `chevron-left` 16px |
| 背景 | `#FFF` |
| 边框 | 1px `--border` |
| 圆角 | 4px |
| 按钮间上下间距 | 8px |

### 5.1 状态

| 状态 | 背景 | 边框 |
|------|------|------|
| 默认 | `#FFF` | 1px `--border` |
| 可用 | `--primary-50` | 1px `--primary-300` |
| Hover | `--primary-100` | 1px `--primary-600` |
| 禁用 | `#F1F5F9` | 1px `--border-soft` |

---

## 六、底部分页

大数据量时面板底部显示 Pagination SM 变体。

---

## 七、空态

当面板为空时，居中显示 `暂无数据`，14/22 `--text-500`。

---

## 八、CSS 变量

```css
:root[data-theme="new-style"] {
  --trans-panel-w: 240px;
  --trans-panel-h: 320px;
  --trans-panel-radius: 8px;
  --trans-panel-shadow: var(--shadow-card);

  --trans-head-h: 44px;
  --trans-item-h: 36px;
  --trans-item-radius: 8px;

  --trans-btn-size: 32px;
  --trans-btn-radius: 4px;
  --trans-btn-gap: 16px;
  --trans-btn-vgap: 8px;
}
```
