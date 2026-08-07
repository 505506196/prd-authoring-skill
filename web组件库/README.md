# 智能评卷 AI 组件库 · 社考风格

> 当前版本：v2.0.0（2026-07-15）  
> 视觉基准：`preview.html`（由“preview(5)-配色融合版”升级）  
> 产物基准：`dist/shekao-ui.css` + `dist/shekao-ui.js`

本库保留智能评卷的组件结构，使用社考的克制配色与后台视觉。默认为 PC Web 管理端：纯色页面底、白色顶栏/侧栏、实色操作按钮、紧凑圆角和 Slate 中性色。

## 唯一真源与优先级

1. `design-tokens.json`：设计 Token 的机器可读真源。
2. `foundations/`：Token 的人类可读说明。
3. `components/`：组件视觉和交互规范。
4. `dist/`：项目实际引用的运行时产物。
5. `preview.html`：组件视觉与状态回归页。

冲突时先修正 `design-tokens.json` 和规范，再同步 `dist` 与 `preview.html`，禁止只在业务页面中覆盖。

## 视觉基线

- 主色：`#155CCB`，Hover `#1E6AE0`，Active `#1050B8`。
- 成功：`#09B766`；警告：`#F59E0B`；错误：`#EA4335`。
- 页面底：`#F8FAFC`；默认不使用网格。
- 网格只能在品牌/登录/展示页上通过 `.sk-grid-bg` 显式启用。
- 按钮/输入默认圆角 6px；卡片 12px；静态状态 Tag 4px。
- 可交互 Tag、计数 Badge、Switch 等小信号元素可使用胶囊形。
- 主按钮使用实色三态；渐变仅用于 Logo、AI 标识或品牌装饰。
- 字体：PingFang SC 优先，系统中文无衬线降级。

## 项目接入

```html
<link rel="stylesheet" href="{component-library}/dist/shekao-ui.css">
...
<script src="{component-library}/dist/shekao-ui.js"></script>
```

- 页面级 CSS 只写布局和业务排布。
- 不得重新定义 `.btn`、`.input`、`.tag`、`.dialog` 等通用组件。
- 缺少通用能力时先回补组件库，再使用到页面。
- 业务图表、内容插图和特殊可视化可使用项目级色板，但不得覆盖组件语义色。
- 外发单文件时可内联 dist；日常维护必须保留引用版作为源文件。

Claude/Codex 生成页面时先读 `AI-USAGE.md`，不需要每次遍历全部组件文档。

## 目录

```text
components/           组件视觉与交互规范
foundations/          色彩、字体、间距、圆角、阴影、图标、布局
dist/                 项目直接引用的 CSS/JS 和验证页
scripts/check-library.sh  一致性检查
design-tokens.json    研发/工具链消费的 Token JSON
preview.html          当前唯一视觉基准
archive/              历史参考，不参与生成
```

## 修改后检查

```bash
bash scripts/check-library.sh
```

修改 Token 或组件后，必须同时检查 `preview.html` 和 `dist/验证页.html`。
