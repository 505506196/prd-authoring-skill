---
name: 徽章 Badge（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius}.md
---

# 徽章 Badge（新风格）

> 用于表格状态列或数字角标。比 Tag 更小、无图标；默认胶囊化；业务状态 5 色固定。

---

## 一、变体

| 变体 | 说明 |
|------|------|
| Status Pill | 表格状态列最常见形式 |
| Count Dot | 纯圆点红点（未读提示）|
| Count Number | 数字角标，带容器 |
| Ribbon | 卡片角标（非胶囊）|

---

## 二、Status Pill

| 状态 | 背景 | 文字 | 语义 |
|------|------|------|------|
| 进行中 | `--accent-green-100` | `--accent-green-800` | 运行中任务 |
| 未开始 | `--warning-100` | `--warning-800` | 待进入 |
| 暂停中 | `#FFEDD5` | `#9A3412` | 暂停 |
| 已结束 | `--border` | `--text-700` | 完成态 |
| 失败 | `--danger-100` | `--danger-800` | 异常终止 |

| 属性 | 值 |
|------|-----|
| 高度 | 22px |
| 字号 | 12 / 18 Medium |
| 水平 padding | 10px |
| 圆角 | 999px |

---

## 三、Count Dot

| 属性 | 值 |
|------|-----|
| 尺寸 | 8 × 8 |
| 形状 | 圆形 |
| 颜色 | `--danger-500` |
| 位置 | 附着在右上角，定位 `top: -4px; right: -4px` |
| 边框 | 2px solid `#FFF`（避免与图标叠色）|

---

## 四、Count Number

| 属性 | 值 |
|------|-----|
| 高度 | 18px |
| 最小宽度 | 18px |
| 水平 padding | 4px |
| 字号 | 11 / 14 Bold（特例，比 Tiny 更小一档）|
| 背景 | `--danger-500` |
| 文字 | `#FFF` |
| 圆角 | 999px |
| 溢出 | 超过 99 显示 `99+` |

---

## 五、Ribbon（卡片角标）

| 属性 | 值 |
|------|-----|
| 位置 | 卡片右上角 |
| 背景 | `--primary-600`（主色）/ 按变体切换 |
| 文字 | `#FFF` |
| 字号 | 12 / 18 Medium |
| 圆角 | 仅左下 + 右上各 4px（锯齿效果可选）|
| padding | 4px 12px |

---

## 六、使用指南

| 场景 | 推荐变体 |
|------|---------|
| 任务列表状态列 | Status Pill |
| 未读消息角标 | Count Dot / Count Number |
| 卡片"NEW / HOT" | Ribbon |
| 侧栏导航未读 | Count Dot |

---

## 七、CSS 变量

```css
:root[data-theme="new-style"] {
  --badge-pill-h: 22px;
  --badge-pill-px: 10px;
  --badge-pill-radius: 999px;

  --badge-dot-size: 8px;

  --badge-count-h: 18px;
  --badge-count-min-w: 18px;
  --badge-count-px: 4px;
  --badge-count-bg: var(--danger-500);
  --badge-count-text: #FFFFFF;
}
```
