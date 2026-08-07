# 智能评卷 AI 组件库协作规则

## 必读顺序

1. `AI-USAGE.md`
2. `design-tokens.json`
3. 任务相关的 `components/<name>/`
4. 需要视觉对照时打开 `preview.html`

## 真源

- 视觉基准只有 `preview.html`。
- 主题名只有 `new-style`；`dist` 默认激活，无需页面额外设置。
- Token 真源是 `design-tokens.json`，CSS 变量与 foundations 必须与之一致。
- 项目实际使用 `dist/shekao-ui.css` 和 `dist/shekao-ui.js`。

## 生成页面约束

- 先引用 dist，再写页面布局。
- 页面中不得复制或覆盖通用组件样式。
- 禁止新建与现有语义重复的颜色、圆角、阴影和间距 Token。
- 缺少组件时先分类：业务无关、可被两个以上项目复用的能力补入组件库；与领域规则强绑定的能力保留在项目内。
- 判断不清时先作为项目组件；第二个项目出现同类需求后，再抽象 API/状态并晋升到 `components/`。
- 禁止在项目中重新实现本库已有的通用组件。
- 图标使用 `shekao-ui.js` 注入的 SVG sprite，图标按钮必须有 `aria-label` 或可见文字。
- 可交互元素必须有 hover、active、focus-visible 和 disabled/loading（如适用）。
- 主交互的动效时长使用 150–300ms，并尊重 `prefers-reduced-motion`。

## 视觉红线

- 主色 `#155CCB`，不得使用旧色 `#2378FA`、`#0056D4`。
- 管理后台默认使用纯色 `--bg-page`；禁止默认启用网格。
- 主按钮为实色三态，不得使用渐变和光晕。
- 渐变只允许用于 Logo、AI 标识、图表或明确的品牌装饰。
- 静态状态 Tag 为 4px 圆角加同族描边；可交互 Tag 可使用胶囊。
- 阴影使用 Slate 双层阴影，不得使用单层纯黑硬阴影。
- 同一页不得混用其他设计系统的组件色和圆角。

## 修改流程

1. 先修改 Token/组件规范。
2. 同步 `dist`。
3. 更新 `preview.html` 和验证页。
4. 运行 `bash scripts/check-library.sh`。
5. 用至少一个真实后台项目回归。
