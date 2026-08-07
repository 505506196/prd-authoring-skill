---
name: 卡片 Card
category: components
status: stable
style: new-style
depends: foundations/{colors,radius,shadows,spacing}.md
---

# 卡片 Card

Card 是白色业务内容容器，用于列表外壳、统计块、表单分组和节点详情。页面不应重复定义 `.card` 的背景、边框、圆角和阴影。

## 基础用法

```html
<section class="sk-card">...</section>
```

## 变体

| class | 用途 |
|---|---|
| `.sk-card--compact` | 密集信息，16px padding |
| `.sk-card--spacious` | 分步表单/引导，24px padding |
| `.sk-card--flat` | 无阴影容器 |
| `.sk-card--interactive` | 可点击卡片，必须同时可键盘聚焦 |

## 规则

- 默认白底、1px `--border`、12px 圆角、双层 `--shadow-card`。
- 卡片内部使用语义组件，不用颜色块堆叠制造层级。
- 仅 `.sk-card--interactive` 允许 hover 抬升；纯展示卡片不作位移。
- 卡片是容器，不代替 Dialog、Alert、Table 和 Empty State。
