---
name: 按钮使用规范 — 种类选型 / 尺寸选型 / 组合模式
category: usage
status: draft
component: button
paired-with: ../../button.md
sedimented-from: 智慧化面试 V2.0（考务/评分/报到签到/流程控制）+ BPS 业务受理（管理端 345 按钮 / 学员端 PC 45 按钮）+ 深圳考试院报名系统，2026-03-11 至 2026-06-11 三个月产线归纳
---

# 按钮使用规范

> **本文件解决「该用 Primary 还是 Outline」「该用 SM 还是 MD」「一组按钮怎么排」三类问题。**
>
> 视觉值（高度、圆角、颜色）见 [`../../button.md`](../../button.md)；交互行为（loading / disabled / 键盘）见 [`../interaction/loading-state.md`](../interaction/loading-state.md)。本文件只回答**何时用、用哪种、怎么组合**。

---

## 一、产线分布快照（数据驱动）

近 3 个月（2026-03-11 至 2026-06-11）扫描 BPS 管理端 345 个按钮 + 学员端 PC 45 个按钮 + 智慧化面试 V2.0 共 700+ 按钮的实际使用：

| 种类 | 占比 | 高频文案 |
|------|------|---------|
| **Text（文字按钮）** | 29% | 详情 / 编辑 / 删除 / 下载 / 上移下移 |
| **Outline（描边）** | 24% | 重置 / 关闭 / 取消 / 返回 / 重新识别 |
| **Primary（实色填充）** | 24% | 查询 / 保存 / 确定 / + 新增X / 统计 |
| **Danger（危险实色）** | 4% | 批量销毁 / 标记销毁 / 标记无效 / 结束面试 |
| Success / Warning / Secondary | <3% | 通过 / 暂存 / 打印 |
| **CTA-Gradient（渐变）** | <1% | 立即开通（仅登录 / 召唤页）|

| 尺寸 | 占比 | 主要场景 |
|------|------|---------|
| **MD 默认（40px）** | 64% | 几乎所有页面级、弹窗级操作 |
| **SM 小尺寸（32px）** | 34% | 表格行内 / 紧凑工具栏 / Tag 旁辅助 |
| **LG 大尺寸（48px）** | 2% | 流程入口页（证书发放 / 身份证识别）|

> **结论：** 一个新页面 90% 的按钮该是 Primary / Outline / Text 三种之一，MD 尺寸为主。Danger / LG / CTA-Gradient 都是稀缺资源，单页面用一个就到顶。

---

## 二、按种类的使用场景

### 2.1 Primary（实色填充主色）

> **何时用：** 该页面 / 弹窗的**核心动作**，最多 1 个。

**适用场景：**
- 表单确认 / 保存 / 提交（"保存"、"确定"、"提交"）
- 列表页右上角的"+ 新增 XX"主入口
- 查询面板的"查询"按钮
- Dialog 底部的确认按钮

**反例：**
- ❌ 一个页面同时出现 3 个 Primary 按钮（视觉权重失效）
- ❌ 用 Primary 做"取消"、"返回"等次操作
- ❌ 表格行内每行都用 Primary（应改 Text）

**典型案例：**
```html
<!-- BPS 列表页右上角 -->
<BaseButton type="primary" @click="openAdd">+ 新增模板</BaseButton>

<!-- 智慧化面试考务管理 -->
<button class="btn btn-primary" onclick="openModal('modalCreateTask')">+ 新增任务</button>
```

### 2.2 Outline（描边白底）

> **何时用：** **次操作**，与 Primary 配对出现。

**适用场景：**
- Dialog Footer 的"取消" / "关闭"
- 查询面板的"重置" / "清空"
- 详情页"返回上级" / "返回列表"
- 工具栏的次要操作（"导出"、"打印")
- 流程入口页的非主操作（与 Primary LG 同档）

**反例：**
- ❌ 单独存在的 Outline（没有 Primary 配对，应升级为 Primary 或降级为 Text）
- ❌ 表格行内用 Outline（视觉过重，应改 Text）

**对偶模式（出现频率最高）：**
```
[查询] + [重置]      ← 查询表单
[确定] + [取消]      ← Dialog
[保存] + [取消]      ← 表单
[识别身份证] + [重新识别]  ← 流程入口
```

### 2.3 Text（无背景文字按钮）

> **何时用：** 行内 / 弱操作，需要克制视觉权重。

**适用场景：**
- 表格行内操作（"编辑"、"删除"、"详情"、"下载"）
- 列表 Tag 旁的辅助按钮（"上移"、"下移"、"移除"）
- 段落内的内联跳转（"查看更多"、"了解详情"）
- 顶栏 / 卡片角落的次级链接

**关键技巧：表格内的"删除"应该用 `text + 红色文字`，而不是 `danger 实色`**：

```html
<!-- 推荐：克制的红色文字（产线主流） -->
<BaseButton type="text" size="sm" @click="del" style="color: var(--danger-500)">删除</BaseButton>

<!-- 不推荐：表格内塞 danger 实色（视觉太重，1 行 5 个按钮全是色块） -->
<BaseButton type="danger" size="sm" @click="del">删除</BaseButton>
```

**多个 Text 按钮同行用分隔符隔开：**
```html
<button class="btn-link">编辑</button>
<span class="table-action-divider"></span>
<button class="btn-link btn-link-danger">删除</button>
```

### 2.4 Danger（危险实色）

> **何时用：** **页面级 / 工具栏级**的不可逆批量操作，且需要强调风险。**慎用，1 页面 ≤ 2 个**。

**适用场景：**
- 工具栏批量操作："批量销毁"、"批量重置资格审核"、"批量删除"
- 页面顶部的中止性操作："结束面试"、"结束会话"、"撤销发布"
- Dialog 内的最终确认按钮（"确定删除"、"确定销毁"）

**反例：**
- ❌ 表格行内每行的"删除" 按钮用 Danger 实色（应用 Text + 红色文字，见 2.3）
- ❌ 用 Danger 做普通负面操作（如"取消"，应用 Outline）
- ❌ 一个 Dialog Footer 同时出现 Outline 取消 + Danger 确定 + Primary 保存（混乱）

**典型案例：**
```html
<BaseButton type="danger" :disabled="!hasSelection" @click="batchDestroy">批量销毁</BaseButton>
<BaseButton type="danger" size="sm" @click="endSession">结束会话</BaseButton>
```

### 2.5 CTA（主色实色 + 尾箭头）

> **何时用：** 极强召唤场景，**全项目使用次数应在个位数**（产线实测 BPS 全栈 345 个按钮里仅 1 次）。

**仅适用：**
- 登录页的"登录" / "立即进入"
- 营销页的"立即开通" / "免费试用"
- 关键流程入口的 Hero 区按钮

**反例：**
- ❌ B 端管理后台普通"保存"用 CTA-Gradient（破坏一致性）
- ❌ 同一页面同时出现 2 个 CTA-Gradient（彻底失效）

### 2.6 Secondary（浅色填充）

> **何时用：** 副 CTA，介于 Primary 与 Outline 之间。**产线占比 <1%，可考虑省略不用**。

**适用场景：**
- 详情页的功能入口（"打印审核通知单"、"查看材料"）
- 卡片底部的"了解更多" / "立即查看"

**判断原则：** 如果 Outline 能覆盖，优先用 Outline。Secondary 仅在"需要比 Outline 更强引导但又不能抢 Primary"时使用。

### 2.7 Success / Warning / Ghost

> **使用率极低（<3%），仅在特定语义场景出现。**

| 种类 | 适用 | 反例 |
|------|------|------|
| **Success** | 流程结果确认（"通过审核"、"完成"）；Tag 配色不应混用此色 | 不要用于普通"确定"（用 Primary）|
| **Warning** | 需要用户注意但非危险的中间态（"暂存"、"待复核"）| 不要用于错误（用 Danger）|
| **Ghost** | 顶栏图标按钮 / 工具栏图标按钮 | 不要用于带文字的次操作（用 Outline）|

---

## 三、按尺寸的使用场景

### 3.1 MD 默认（40px / 默认档）

> **占比 64%**。除非有明确理由用 SM 或 LG，否则一律 MD。

- 页面级所有主次操作（"+ 新增"、"查询"、"重置"、"导出"）
- Dialog / Drawer 的 Footer 按钮组
- 表单的"保存" / "取消"
- 顶部工具栏的批量操作
- 详情页的功能入口按钮组

### 3.2 SM 小尺寸（32px）

> **占比 34%**。在"必须紧凑"的环境用。

**适用场景：**
- **表格行内操作**（强制 SM；行高 48px 装不下 MD）
- 紧凑型工具栏（多按钮并列、空间受限）
- Card 内嵌的辅助按钮
- 移动端非主操作

**反例：**
- ❌ Dialog Footer 用 SM（看上去"小气"，应 MD）
- ❌ 普通页面顶部的主操作用 SM（应 MD）

### 3.3 LG 大尺寸（48px）

> **占比 2%**。极稀缺，仅在"独立流程入口页"出现。

**适用场景（产线实测仅这几类）：**
- 证书申领发放等独立流程页的核心操作（"识别身份证"、"确认发放"、"补拍材料"）
- 身份证 / 二维码扫描等需要醒目操作引导的场景
- 登录页 / 注册页的"登录"按钮（配 CTA-Gradient）

**关键准则：** **LG 必须**满足以下任一条件：
1. 这是页面**唯一焦点操作**（用户进页面就是为了点这个按钮）
2. 操作伴随**硬件交互**（扫码 / 拍照 / 读卡）
3. 是**身份切换 / 权限变更**的关键节点（登录 / 切换角色）

**反例：**
- ❌ 列表页的"+ 新增"用 LG（应 MD）
- ❌ Dialog 内的"确定"用 LG（应 MD）

---

## 四、组合模式（高频共现）

### 4.1 查询表单：Primary + Outline

```
[关键字输入框] [日期] [状态]      [查询] [重置]
                                    ↑       ↑
                                  primary  outline
```

- 出现频率：**几乎所有列表页都有**（产线实测覆盖率 95%+）
- 主按钮始终是"查询" / "搜索"
- 次按钮始终是"重置" / "清空"，<span style="text-decoration:line-through">不</span>叫"清空筛选"
- 间距：8px
- 对齐：右对齐

### 4.2 Dialog Footer：Outline + Primary（右对齐）

```
                        [取消]   [确定]
                          ↑        ↑
                       outline  primary
```

- 主按钮在**右侧**
- 危险确认场景：右侧用 Danger 替换 Primary
- Footer padding：20px 28px（按 dialog.md）

### 4.3 表格行内操作：Text + 分隔符

```
| 列1 | 列2 | 编辑 | 详情 | 删除（红色文字） |
                ↑              ↑
              text-sm     text-sm + danger 文字色
```

- 全部用 Text（不用 Outline 不用 Danger 实色）
- 操作多于 3 个：折叠到"更多 ›"下拉菜单
- 删除项必须**最右**且用红色文字
- 操作之间用 `<span class="table-action-divider"></span>` 分隔

### 4.4 页面顶部右上角主入口：Primary（带 + 图标）

```
[页面标题]                                  [+ 新增 XX]
                                                ↑
                                            primary md
```

- 文案统一格式："+ 新增 + 对象名"（不要"创建" / "添加"，词汇规范遵循 [[ui_spec_bps_global_2026_06]]）
- 全站统一用"新增"

### 4.5 批量操作工具栏：选中后 disabled→active

```
☑ 选中 N 项    [批量审核]  [批量打印]  [批量销毁]
                  ↑           ↑           ↑
              primary       outline      danger
              :disabled="!hasSelection"
```

- 未选中时按钮 disabled（hover Tooltip 提示"请先勾选记录"）
- 危险批量操作必须配二次确认 Dialog

### 4.6 流程入口页：Primary LG + Outline LG

```
            [识别身份证]   [手动输入]   [补拍材料]
                ↑              ↑            ↑
            primary lg     outline lg    outline lg
```

- 全部 LG 尺寸（强引导）
- 仅在"独立流程页"使用，不在列表 / 弹窗中使用
- 同一页可有 1 个 Primary LG + 多个 Outline LG

### 4.7 详情页右侧操作面板：Secondary + Outline 系列

```
| ┌────────────┐
| │ 详情内容   │   [打印通知单]  ← secondary 全宽
| │            │   [查看材料]    ← outline 全宽
| │            │   [审核通过]    ← primary 全宽
| │            │   [驳回]        ← danger 全宽
| └────────────┘
```

- 全部 100% 宽度
- 垂直堆叠
- 危险操作放最下方（避免误点）

### 4.8 登录 / 注册：CTA-Gradient LG

```
                ┌──────────────────┐
                │    登 录 →       │  ← CTA-Gradient + LG
                └──────────────────┘
```

- 仅这个场景；其他场景一律不用 CTA

---

## 五、按钮组排列规则

### 5.1 弹窗 / 表单 Footer

| 维度 | 规则 |
|------|------|
| 间距 | 8px（按 button.md `--btn-group-gap`）|
| 主操作位置 | **右侧** |
| 一组内主按钮数量 | ≤ 1 |
| 默认聚焦 | 主按钮（除危险操作）|
| 危险操作默认聚焦 | "取消"按钮（防误回车）|

### 5.2 页面顶部 PageHeader / 工具栏

| 维度 | 规则 |
|------|------|
| 间距 | 8px |
| 容器布局 | `display: flex; justify-content: space-between` |
| 标题位置 | **左侧** |
| 主操作位置 | **右侧**（与弹窗 Footer 一致）|
| 顺序（多按钮）| 次操作 → 主操作（从左到右）|
| 批量操作工具栏 | 已选数量 / 提示在左，操作按钮组在右 |

> **修正记录（2026-06-11）：** 此处旧规范曾误写"主操作在左（与弹窗相反）"。扫描产线代码（BPS 管理端 / 智慧化面试 V2.0 考务管理 / 0421 版考务管理）发现实际 `.page-header` 全部使用 `justify-content: space-between` 布局，标题在左、主操作在右。业内主流（Ant Design / Element Plus / Material 3 / Apple HIG）也均为「主操作在右」。已据实修正。

**典型代码：**
```html
<div class="page-header">  <!-- justify-content: space-between -->
  <h2>面试任务管理</h2>      <!-- 标题在左 -->
  <button class="btn btn-primary">+ 新增任务</button>  <!-- 主操作在右 -->
</div>
```

### 5.3 同行 ≥ 3 个操作

> **不允许 5 个并排按钮**，必须收纳。

- 4 个以上：把次要操作折叠到"更多 ›"下拉菜单
- 表格行：操作 ≤ 3 个全部展示；> 3 个用 `更多 ›`

---

## 六、文案规范（避免词汇分裂）

| 操作语义 | 推荐文案 | 禁止文案 |
|---------|---------|---------|
| 创建 | **新增 XX** | 创建 / 添加 / 新建（不允许混用）|
| 修改 | **编辑** | 修改 / 更改 |
| 删除 | **删除** | 移除 / 清除（业务允许"移除"用于解绑场景）|
| 提交保存 | **保存**（表单态）/ **确定**（弹窗态）| 提交 / OK |
| 退出 | **取消**（弹窗）/ **关闭**（详情）/ **返回**（流程）| 退出 / 离开 |
| 搜索 | **查询** | 搜索（搜索框组件除外）|
| 重置 | **重置** | 清空 / 还原 |

---

## 七、反例集合（实战踩坑）

### 反例 1：表格行内全是 Danger 实色

```html
<!-- ❌ 错误：每行都堆 danger 红色块 -->
<td>
  <BaseButton type="primary" size="sm">编辑</BaseButton>
  <BaseButton type="danger" size="sm">删除</BaseButton>
</td>
```

视觉上 100 行表格 = 100 个红色块，注意力被严重分散。**正解：** Text + 红色文字。

### 反例 2：Dialog Footer 用 LG

```html
<!-- ❌ 错误：弹窗内用 LG 显得"挤" -->
<div class="dialog-footer">
  <BaseButton type="outline" size="lg">取消</BaseButton>
  <BaseButton type="primary" size="lg">确定</BaseButton>
</div>
```

LG 仅在独立流程页使用。**正解：** MD（默认尺寸）。

### 反例 3：CTA-Gradient 滥用

```html
<!-- ❌ 错误：管理后台普通保存用 CTA -->
<BaseButton type="cta-gradient" @click="save">保存</BaseButton>
```

破坏一致性，且失去 CTA 的"召唤"语义。**正解：** Primary。

### 反例 4：缺少配对的 Outline

```html
<!-- ❌ 错误：只有"查询"没有"重置" -->
<BaseButton type="primary" @click="search">查询</BaseButton>
```

用户无法快速清空筛选条件。**正解：** 加上"重置" Outline。

### 反例 5：用 Primary 做次操作

```html
<!-- ❌ 错误：取消、确定都用 Primary -->
<BaseButton type="primary">取消</BaseButton>
<BaseButton type="primary">确定</BaseButton>
```

主次不分，用户不知道"主操作"在哪。**正解：** 取消用 Outline。

### 反例 6：5 个按钮平铺

```html
<!-- ❌ 错误：表格行 5 个操作并排 -->
<td>
  <button>编辑</button> <button>详情</button> <button>导出</button>
  <button>打印</button> <button>删除</button>
</td>
```

视觉负担大，列宽撑爆。**正解：** 保留 2-3 个高频，其余折叠到"更多 ›"。

---

## 八、决策树（写代码前 30 秒判断）

```
新加一个按钮？
  │
  ├─ 它是这个页面 / 弹窗的核心动作吗？
  │   ├─ 是 → Primary MD（已有 Primary？降级为 Outline）
  │   └─ 否 ↓
  │
  ├─ 它是核心动作的"配对"（取消 / 重置 / 返回）吗？
  │   ├─ 是 → Outline MD
  │   └─ 否 ↓
  │
  ├─ 它在表格 / 列表行内吗？
  │   ├─ 是 → Text SM（删除项加红色文字）
  │   └─ 否 ↓
  │
  ├─ 它是不可逆的批量危险操作吗？
  │   ├─ 是 → Danger MD（配二次确认 Dialog）
  │   └─ 否 ↓
  │
  ├─ 它在独立流程页（扫码 / 识别 / 流程入口）吗？
  │   ├─ 是 → Primary LG（次操作用 Outline LG）
  │   └─ 否 ↓
  │
  └─ 它是登录 / 营销召唤页的关键入口吗？
      ├─ 是 → CTA-Gradient LG（全项目 ≤ 5 处）
      └─ 否 → 默认 Outline MD
```

---

## 九、自检清单（提交前 60 秒）

- [ ] 单页面 Primary 按钮数量 ≤ 1（除非弹窗等子上下文）
- [ ] Primary 是否真的对应"该上下文最重要的操作"
- [ ] 表格行内操作全部 SM Text（无 Danger 实色 / 无 Outline）
- [ ] 删除按钮是否在最右且用红色文字
- [ ] Dialog Footer 与页面顶部 PageHeader 的主操作都在**右侧**（标题左、操作右）
- [ ] Danger 实色不超过 1 个（除非批量工具栏 + 单独栏）
- [ ] CTA-Gradient 全项目使用 ≤ 5 处
- [ ] LG 按钮所在页面满足"独立流程入口"三准则之一
- [ ] 同行按钮 ≤ 3 个（超出折叠"更多 ›"）
- [ ] 文案符合"新增 / 编辑 / 删除 / 保存 / 取消 / 重置 / 查询"统一词表

---

## 十、定义与维护责任

| 职责 | 角色 | 触发时机 |
|------|------|---------|
| **终审拍板** | 设计总监 | 跨项目争议（如"批量销毁该用 Danger 实色还是 Outline-Danger"）|
| **起草初稿** | UI 设计师 | 每月从产线归纳新模式 |
| **用例校验** | 资深前端 | 用例覆盖测试（如 SM 按钮在 32px 行高表格里实际占位是否合规）|
| **沉淀归档** | AI 协作 / 规范维护者 | 双地落点同步（项目目录 + ~/.claude/智能评卷组件库）|

**更新节奏：** 每月一次回顾近 30 天产线新页面，发现新模式纳入；超过 3 个项目复用的"局部约定"升级为通用模式。

---

## 十一、不适用场景

- **极简营销页 / 落地页**：本规范不约束（按品牌方需求）
- **数据可视化页面的工具按钮**：图表交互按钮另立规范
- **第三方组件库直接使用场景**：业务方需把外部按钮的视觉值映射到本规范
- **移动端 H5 / 小程序**：触摸热区下限 44px，本规范的 SM 32px 不适用，需另定 H5 版本
