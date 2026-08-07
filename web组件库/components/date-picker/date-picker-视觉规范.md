---
name: 日期选择器 DatePicker（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows}.md
---

# 日期选择器 DatePicker（新风格）

> 触发框与 Input 统一；面板 8px 圆角；今日 / 选中 / 范围三态全部主色高亮；支持日 / 周 / 月 / 季 / 年粒度。

---

## 一、触发框 Trigger

同 Input 规范：

| 尺寸 | 高度 | 圆角 |
|------|------|------|
| SM | 32px | 4px |
| Default | 44px | 6px |
| LG | 52px | 8px |

- 前缀 `calendar` 16px，`--text-500`
- 后缀：有值时 `x-circle`（清除）；无值时不显示
- placeholder：`选择日期` / `开始日期 – 结束日期`（范围）

---

## 二、日期面板

| 属性 | 值 |
|------|-----|
| 宽度 | 320px（单面板）/ 640px（范围双面板）|
| 圆角 | 8px |
| 阴影 | `--shadow-dropdown` |
| 背景 | `#FFF` |
| padding | 16px |
| 与触发间距 | 4px |
| 动画 | `opacity + translateY`，180ms |

### 2.1 面板头

```
[<<]  [<]       2026 年 4 月       [>]  [>>]
```

| 元素 | 规格 |
|------|------|
| 年 / 月文字 | 16 / 24 Semibold，`--text-900`，可点击切换为年/月选择 |
| 切换按钮 | 32×32 圆角 8px，Hover `--fill-hover` |
| 图标 | `chevron-left` / `chevron-right` / `chevrons-left` / `chevrons-right` 16px |

### 2.2 星期行

| 属性 | 值 |
|------|-----|
| 字号 | 12 / 18 Semibold |
| 颜色 | `--text-500` |
| 高度 | 32px |

### 2.3 日期单元

| 属性 | 值 |
|------|-----|
| 尺寸 | 36×36 |
| 圆角 | 8px（范围两端为 `4px 0 0 4px` / `0 4px 4px 0`）|
| 字号 | 12 / 18 Regular |

| 状态 | 背景 | 文字 |
|------|------|------|
| 默认 | 透明 | `--text-900` |
| 非本月 | 透明 | `--text-400` |
| Hover | `--primary-50` | `--primary-600` |
| 今日 | `#FFF` | `--primary-600` + 1px `--primary-600` 描边 |
| 已选 | `--primary-600` | `#FFF` Semibold |
| 范围内 | `--primary-50` | `--primary-600` |
| 范围起止 | `--primary-600` | `#FFF` |
| 禁用 | 透明 | `--text-300` |

### 2.4 底部快捷

| 元素 | 规格 |
|------|------|
| 分隔线 | 1px `--border-soft` |
| padding | 12px 16px |
| 快捷按钮 | Text Primary SM，常见：今天 / 昨天 / 最近 7 天 / 最近 30 天 |
| 时间切换（支持时间的变体）| 右侧 `hh:mm` 小输入 |
| 确认按钮（范围模式）| Primary SM，右对齐 |

---

## 三、日期范围 Range

| 变体 | 说明 |
|------|------|
| 两个 Input | 左起始右结束，中间 `—` 分隔 |
| 合并面板 | 双月并排（左当前月 + 右下个月）|
| 独立分隔 | 两个独立 DatePicker，互相约束 |

---

## 四、其他粒度

| 粒度 | 面板 | 单元尺寸 |
|------|------|---------|
| 月 Month | 4×3 月格子 | 64×36 圆角 4px |
| 季 Quarter | 1×4 季格 | 128×40 圆角 4px |
| 年 Year | 3×4 年格 | 64×36 圆角 4px |
| 周 Week | 日面板但整行高亮 | — |

---

## 五、禁用规则

| 场景 | 行为 |
|------|------|
| 超出最大/最小日期 | 对应日期禁用 |
| 自定义禁用（周末）| 自定义回调返回布尔值 |
| 范围模式禁用中间选中 | 起止间接日期保持禁用 |

---

## 六、CSS 变量

```css
:root[data-theme="new-style"] {
  --dp-panel-w: 320px;
  --dp-panel-w-range: 640px;
  --dp-panel-radius: 8px;
  --dp-panel-padding: 16px;
  --dp-panel-shadow: var(--shadow-dropdown);

  --dp-cell-size: 36px;
  --dp-cell-radius: 8px;
  --dp-cell-font: 12px/18px 400;
  --dp-cell-bg-hover: var(--primary-50);
  --dp-cell-bg-selected: var(--primary-600);
  --dp-cell-text-selected: #FFFFFF;
  --dp-cell-bg-range: var(--primary-50);

  --dp-today-border: 1px solid var(--primary-600);
  --dp-today-text: var(--primary-600);
}
```
