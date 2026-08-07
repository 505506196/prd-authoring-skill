# PRD 输出 Skill - 安装指令（给 Claude Code 执行）

本文档是给 **Claude Code** 读的安装步骤。当用户解压 skill 包后对你说"帮我安装"或类似指令时，请按以下流程完成安装。

---

## 完整安装流程（4步）

### 第 1 步：运行 install.sh 部署文件

```bash
cd <用户解压的目录>/prd-authoring-skill
bash install.sh
```

这一步会：
- 复制 skill 到 `~/.claude/skills/prd-authoring/`
- 复制 web 组件库到 `~/.claude/prd-authoring-assets/web组件库/`（原型生成依赖）
- 复制 tracker 脚本到 `~/.claude/feishu-tracker/`

---

### 第 2 步：检查是否需要身份登记

运行：
```bash
ls ~/.claude/feishu-tracker/identity.json
```

- **文件存在** → 跳到第 4 步（已登记过，无需重复）
- **文件不存在** → 继续第 3 步

---

### 第 3 步：在对话里登记身份并发 install 埋点

**如果 identity.json 不存在**，执行以下 3 个子步骤：

#### 3.1 询问用户姓名和部门

在对话中直接问：
> 请提供你的姓名和部门，用于团队使用统计（一次性登记）：
> - 姓名：
> - 部门：

#### 3.2 执行登记脚本

拿到用户回答后，执行（替换 `<姓名>` 和 `<部门>` 为实际值）：
```bash
bash ~/.claude/feishu-tracker/identity-init.sh --name "<姓名>" --dept "<部门>"
```

#### 3.3 发送 install 埋点

登记成功后立即发送 install 事件（一条命令，完整复制执行）：
```bash
RUN_ID="install-$(date +%s)-$((RANDOM%9000+1000))"; bash ~/.claude/feishu-tracker/track.sh "prd-authoring" --event install --version "0.3.0" --run "$RUN_ID"
```

**静默执行**（无输出是正常的）。

---

### 第 4 步：提示用户重启

安装完成后，向用户输出：

> ✅ **PRD 输出 skill 安装完成**
> 
> 下一步：
> 1. 重启 Claude Code（或新开会话）
> 2. 输入 `/prd-authoring`，或说「帮我输出这个需求的 PRD」「做个原型」即可使用
> 
> 组件库已部署到 `~/.claude/prd-authoring-assets/`，原型会自动引用。使用数据会自动上报到团队统计表。

---

## 常见问题

**Q：身份登记时提示"非交互安装，跳过登记"？**  
A：正常——你通过 Bash 工具跑的脚本是非交互环境。继续按第 3 步在对话里完成登记即可。

**Q：发送埋点没有任何输出？**  
A：正常——track.sh 设计成静默执行。命令执行完没报错即视为已发送。

**Q：原型 HTML 打开后没样式？**  
A：检查 `~/.claude/prd-authoring-assets/web组件库/dist/shekao-ui.css` 是否存在。不存在说明 install.sh 未跑或组件库未打包，重新跑 install.sh。
