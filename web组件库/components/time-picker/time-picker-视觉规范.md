---
name: 时间选择器 TimePicker（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows}.md
---

# 时间选择器 TimePicker（新风格）

> 触发框同 Input；面板三列滚动 hh / mm / ss，选中项主色高亮；支持秒粒度开关与 12/24 小时制。

---

## 一、触发框

同 Input 规范：

| 属性 | 值 |
|------|-----|
| 前缀图标 | `clock` 16px，`--text-500` |
| placeholder | `选择时间` |
| 后缀 | `x-circle` 清除 |

---

## 二、面板

| 属性 | 值 |
|------|-----|
| 宽度 | 216px（hh:mm:ss）/ 144px（hh:mm）|
| 圆角 | 8px |
| 阴影 | `--shadow-dropdown` |
| padding | 8px |
| 背景 | `#FFF` |

### 2.1 列

| 属性 | 值 |
|------|-----|
| 列宽 | 64px |
| 列间分隔 | 无（1px `--border-soft` 垂直可选）|
| 项高 | 32px |
| 项圆角 | 8px |
| 项字号 | 14 / 22 Regular，`tabular-nums` |
| 默认项 | `--text-700` |
| Hover | `--primary-50` 底 + `--primary-600` |
| 选中 | `--primary-600` 底 + `#FFF` Semibold |

### 2.2 滚动

- 每列独立滚动；选中项保持在列中间位置
- 滑动阻尼 `scroll-snap-type: y mandatory`

### 2.3 底部

| 元素 | 规格 |
|------|------|
| 分隔线 | 1px `--border-soft` |
| 快捷按钮 | 此刻（Text Primary SM，左侧）|
| 确认按钮 | Primary SM，右侧 |
| padding | 10px 16px |

---

## 三、12 / 24 小时制

12 小时制时右侧增加第四列 AM / PM 切换，宽 56px。

---

## 四、范围选择 Time Range

| 布局 | 左右两个独立 TimePicker，中间 `—` 连字符 |
| 约束 | 结束时间必须大于起始时间 |

---

## 五、禁用规则

| 场景 | 行为 |
|------|------|
| 最小/最大时间 | 超出部分灰 |
| 禁用秒 | 隐藏秒列 |

---

## 六、CSS 变量

```css
:root[data-theme="new-style"] {
  --tp-panel-w: 216px;
  --tp-panel-radius: 8px;
  --tp-panel-padding: 8px;
  --tp-panel-shadow: var(--shadow-dropdown);

  --tp-col-w: 64px;
  --tp-item-h: 32px;
  --tp-item-radius: 8px;
  --tp-item-font: 14px/22px 400;
  --tp-item-bg-hover: var(--primary-50);
  --tp-item-bg-selected: var(--primary-600);
  --tp-item-text-selected: #FFFFFF;
}
```
