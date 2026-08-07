---
name: 选择器 Select（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows,spacing}.md
---

# 选择器 Select（新风格）

> 触发框样式同 Input（6px 圆角，44px 高）；下拉面板 8px 圆角 + Dropdown 阴影；选中项主色背景 + 勾选图标。

---

## 一、触发框 Trigger

与 Input 完全一致（见 input.md）：

| 尺寸 | 高度 | 圆角 |
|------|------|------|
| SM | 32px | 4px |
| Default | 44px | 6px |
| LG | 52px | 8px |

右侧箭头：`chevron-down` 16px，展开时旋转 180°。

---

## 二、下拉面板 Dropdown

| 属性 | 值 |
|------|-----|
| 背景 | `#FFF` |
| 圆角 | 8px (md) |
| 边框 | 1px `--border` |
| 阴影 | `--shadow-dropdown` |
| padding | 6px |
| 与触发框间距 | 4px |
| 最小宽度 | 跟随触发框 |
| 最大高度 | 320px（溢出滚动）|
| 动画 | `opacity 0→1` + `translateY(-4px→0)` 180ms |

---

## 三、选项 Option

| 状态 | 背景 | 文字 | 备注 |
|------|------|------|------|
| 默认 | 透明 | `--text-700` | — |
| Hover | `--primary-50` | `--text-900` | — |
| 选中 | `--primary-50` | `--primary-600` | 右侧 `check` 图标 |
| 禁用 | 透明 | `--text-400` | `cursor: not-allowed` |

| 属性 | 值 |
|------|-----|
| 高度 | 36px |
| 水平 padding | 12px |
| 圆角 | 8px |
| 字号 | 14 / 22 Regular |
| 选中图标 | 16px `check`，`--primary-600` |

---

## 四、多选 Multi-Select

| 属性 | 值 |
|------|-----|
| 已选项在触发框内显示 | Tag Light Primary SM |
| Tag 间距 | 4px |
| 超出行数 | 折叠为"+N"胶囊 |
| 清除全部 | 右侧 `x-circle` 16px |

---

## 五、可搜索 Searchable

- 触发框聚焦后顶部出现搜索输入条（高 32，同 SM 输入样式）
- 无匹配时显示空态："未找到匹配项"（12 / 18 Regular，`--text-500`）

---

## 六、分组 Grouped

| 元素 | 规格 |
|------|------|
| 分组标题 | 12 / 18 Semibold，`--text-400`，`text-transform: uppercase`，`padding: 6px 12px` |
| 分组间距 | 4px + 1px `--border-soft` 分隔 |

---

## 七、CSS 变量

```css
:root[data-theme="new-style"] {
  --select-trigger-h-sm: 32px;
  --select-trigger-h-md: 44px;
  --select-trigger-radius: 6px;

  --select-dropdown-bg: #FFFFFF;
  --select-dropdown-radius: 8px;
  --select-dropdown-padding: 6px;
  --select-dropdown-shadow: var(--shadow-dropdown);
  --select-dropdown-gap: 4px;
  --select-dropdown-max-h: 320px;

  --select-option-h: 36px;
  --select-option-px: 12px;
  --select-option-radius: 8px;
  --select-option-bg-hover: var(--primary-50);
  --select-option-bg-selected: var(--primary-50);
  --select-option-text-selected: var(--primary-600);
}
```

---

## 八、与旧规范差异

| 维度 | 旧 | 新 |
|------|----|----|
| 触发框圆角 | 4px | 4px |
| 面板圆角 | 4px | 8px |
| 面板阴影 | `0px 8px 20px rgba(0,0,0,.1)` | 双层 Slate 软阴影 |
| 选项选中 | 仅文字变色 | `--primary-50` 背景 + 主色文字 + 勾选图标 |
