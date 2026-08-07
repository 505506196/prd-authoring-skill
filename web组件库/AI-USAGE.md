# AI 页面生成入口

## 快速接入

```html
<link rel="stylesheet" href="{library}/dist/shekao-ui.css">
<script src="{library}/dist/shekao-ui.js"></script>
```

## 生成顺序

1. 从 PRD 提取页面、流程、角色、数据状态和边界。
2. 从本库选择布局骨架与已有组件。
3. 先生成语义 HTML，使用组件库 class 和 `data-*` 行为。
4. 页面 `<style>` 只写布局、业务组合和特殊可视化。
5. 用 `SK.dialog`、`SK.drawer`、`SK.message` 及声明式属性处理通用交互。
6. 检查默认、hover、active、focus、disabled、loading、empty 和 error 状态。

## 页面 CSS 允许范围

允许：页面网格、容器宽度、业务区块排布、图表容器、业务缩略图。

禁止：重新定义 `.btn`、`.input`、`.select`、`.tag`、`.table`、`.dialog`、`.drawer` 等基础组件；硬编码主色、阴影和圆角；默认给后台页面加网格。

## 常用能力

- 按钮：`.btn` + `.btn--primary|secondary|outline|danger|ghost|text`
- 表单：`.field`、`.input`、`.select`、`.checkbox`、`.radio`、`.switch`
- 容器：`.sk-card` + `.sk-card--compact|spacious|flat|interactive`
- 数据：`.tbl`、`.tag`、`.pagination`、`.empty`
- 反馈：`.alert`、`.dialog`、`.drawer`、`.notification`、`SK.message()`
- 导航：`.topbar`、`.nav-sb`、`.breadcrumb`、`.tabs-*`、`.steps`

如找不到合适的组件，先判断它是通用能力还是业务能力：通用能力补入本库后使用；业务专属能力允许在项目内实现。

## 通用组件与业务组件

优先纳入组件库：与具体业务名词无关、预计两个以上项目复用、状态和接口可稳定定义、只依赖公共 Token 的能力。

保留在项目内：与试卷、场景、学员分配、业务角色等领域规则强绑定的结构。

判断不清时先作为项目组件，不要过早抽象。同类能力在第二个项目出现后，再评估是否晋升到本库。

## 组件晋升流程

```text
项目首次出现 → 项目业务组件
                  ↓ 第二个项目出现同类需求
评估业务无关性 → 抽象 API/状态 → 加入 components/
                  → 更新 preview + dist → 发布新版本
```

## 背景选择

- 管理后台：默认 `body`，纯色 `--bg-page`。
- 品牌/登录/展示：仅在明确需要时给 `body` 增加 `sk-grid-bg`。

## 交付前

```bash
bash {library}/scripts/check-library.sh
```
