# PRD 输出 Skill

从需求（或需求诊断产物）出发，经六阶段流水线产出可交付的 PRD——概要文档、可交互原型、评审、详细 PRD、研发评审一条龙。原型严格遵循团队 web 组件库。

> **推荐安装方式**：解压后，在 Claude Code 对话中说「帮我安装这个 skill」，Claude 会自动读取 `INSTALL_GUIDE.md` 完成完整安装流程（含组件库部署、身份登记和埋点）。

## 这个 skill 做什么

六个阶段，每阶段停在闸口等你确认才继续：

| 阶段 | 名称 | 产物 |
|---|---|---|
| 1 | 概要需求文档 | 业务流程 + 功能模块 + 用户场景 |
| 2 | 原型生成 | 可交互 HTML 原型（遵循组件库） |
| 3 | 用户试用与修改 | 你点击体验，提意见，迭代原型 |
| 4 | 服务用户视角评审 | 独立 subagent 代入用户角色找问题 |
| 5 | 详细 PRD | 字段级/状态级/规则级完整需求 |
| 6 | 研发需求评审 | 可行性/工量/边界/依赖/风险评审意见 |

## 安装

解压后在 Claude Code 里说「帮我安装这个 skill」，或手动：
```bash
cd prd-authoring-skill
bash install.sh
```
安装后**重启 Claude Code**。

## 使用

在 Claude Code 中输入：
```
/prd-authoring
```
或说「帮我输出这个需求的 PRD」「做个原型」「原型评审」。

**两种入口**：
- 接需求诊断产物：若已用需求诊断 skill 跑过，检测到 `outputs/<产品>/04-诊断报告.md` 会自动带入
- 直接给需求：贴一段需求/想法即可开始

首次使用会引导登记姓名+部门（一次性，用于团队使用统计）。

## 原型与组件库

- 原型严格遵循团队 web 组件库（主色 #155CCB，Primary≤1/页，表格行内 Text 等视觉红线）
- 组件库安装时部署到 `~/.claude/prd-authoring-assets/web组件库/`
- 原型引用 `dist/shekao-ui.css+js`，可在浏览器真实点击体验
- 为方便传阅，原型目录会自带 `assets/` 副本，整个 `prototype/` 可打包发送

## 目录结构

```
prd-authoring-skill/
├── install.sh                    # 一键安装（部署skill+组件库+tracker）
├── INSTALL_GUIDE.md              # 给 Claude 的安装指令
├── README.md
├── skills/prd-authoring/
│   ├── SKILL.md                  # 主控（六阶段流水线）
│   └── references/               # 6个阶段细则 + 变更协议
├── web组件库/                     # 打包进来，安装时部署
└── setup-feishu-tracker/files/   # 飞书使用追踪脚本
```

## 使用统计

skill 运行时会静默上报「谁、用了、走到哪个阶段」到飞书多维表格。
- 默认上报到维护者（高斯航/社考产品部）的统计表
- 埋点失败不影响正常使用
- 如需改到自己的表：`echo '{"webhook_url":"<你的URL>"}' > ~/.claude/feishu-tracker/config.json`

## 与需求诊断 skill 的关系

- **需求诊断**（requirement-diagnosis）：把粗糙需求澄清到「可进入 PRD」
- **PRD 输出**（本 skill）：接过来，做成可交付的 PRD + 原型 + 评审

两者可独立使用，也可串联：诊断 → PRD。

## 版本

- skill v0.1.0（首版：六阶段 PRD 流水线 + 组件库原型 + 双轮评审 + 飞书追踪）
