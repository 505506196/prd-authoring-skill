---
name: 表格交互规范 — 单元格长文案断行/截断/Tooltip（单元格维度）
category: interaction
scene: truncate
status: draft
component: table
paired-with: ../visual.md
sedimented-from: 考务管理系统 V2.0（2026-05-28，规则草拟）
applies-to: 单列内容存在长文案的 B 端业务表格
---

# 表格交互规范 — 单元格长文案断行 / 截断 / Tooltip

> **本文件解决「单元格维度」问题**：当某一列存放说明类长文本（如"职位描述""备注""异常原因"），不应让它撑爆列宽或挤压其他列，但也不能丢失阅读完整内容的能力。
>
> 列多导致的容器横向滚动问题在同目录 [`overflow.md`](./overflow.md)。两个文件正交，可同时生效。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **不撑爆** | 长文案不能让该列无限拉宽，挤压其他列 |
| **不挤压其他列** | 长文案的存在不影响其他列宽度计算 |
| **保留阅读路径** | 用户必须能看到完整内容（hover / 点击展开） |
| **没截断不打扰** | 内容本身不超时，不出现省略号、不出现 tooltip |

---

## 二、三级策略阶梯（按内容长度自动升级）

| 阶梯 | 触发条件 | 表现 |
|------|---------|------|
| **L1 · 单行不断** | 内容宽度 ≤ 列最大宽度 | 同主表格默认行为，单行展示 |
| **L2 · 多行展示** | 内容超过列宽 | 文案在列内断行换行，整行高度自适应（最多 N 行，默认 N=2） |
| **L3 · 截断 + Tooltip** | 断行后仍超 N 行 | 末行末尾以 `…` 截断，**鼠标 hover 时弹 tooltip 展示全文** |

> **关键约束：tooltip 只在真正发生截断时出现。** 没截断的内容 hover 不应有任何 tooltip——避免毫无信息增量的打扰。

---

## 三、列级配置（声明式）

业务方在表头列上声明该列是"长文案列"，并指定最大行数：

| 声明 | 含义 | 默认值 |
|------|------|--------|
| `.col-truncate` | 该列采用断行 + 截断策略 | — |
| `data-max-lines="N"` | 断行后最多展示 N 行，超出截断 | `2` |
| `data-max-width="Wpx"` | 该列最大宽度（防撑爆） | 由场景定，建议 `240px` / `320px` / `400px` 三档 |

**示例：**

```html
<th class="col-truncate" data-max-lines="2" data-max-width="320">职位描述</th>
```

---

## 四、视觉规范

### 4.1 文字与行高

| 属性 | 值 | 来源 |
|------|-----|------|
| 字号 | 14px | `visual.md` 内容行字号 |
| 行高 | 22px | `typography.md` 14px 配 22px 行高 |
| 颜色 | `#1D2229` / `#334155` | `visual.md` 内容行文字色 |
| 文本对齐 | `text-align: left` | 长文案禁止居中（影响阅读） |

### 4.2 截断样式

```css
.col-truncate-cell {
  white-space: normal;           /* 覆盖主表格的 nowrap */
  display: -webkit-box;
  -webkit-line-clamp: var(--max-lines, 2);
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  word-break: break-word;        /* 长英文/URL 也能换行 */
  max-width: var(--max-width);
}
```

> **省略号的位置：** 始终在最后一行末尾，不允许出现"中间省略号"或"前置省略号"。

### 4.3 行高补偿

启用断行后，单元格高度由内容决定，**不再使用 `visual.md` 中的固定行高 48px**。但要保持上下内边距：

| 属性 | 值 |
|------|-----|
| 上下 padding | 13px（与 48px 行高的视觉中线保持一致） |
| 左右 padding | 16px（同主表格） |
| 最小高度 | 48px（短内容也保持节奏） |

---

## 五、Tooltip 行为规范

> 复用 `tooltip/visual.md` 的视觉，本节只定义**触发与内容规则**。

| 维度 | 规则 |
|------|------|
| **触发时机** | 鼠标进入单元格 **300ms 后**显示，避免快速划过时频繁弹出 |
| **触发条件（强制）** | **仅当单元格实际发生截断时触发**（运行时判断 `scrollHeight > clientHeight`），未截断不触发 |
| **位置** | 默认 `top`，空间不足时自动翻转为 `bottom` |
| **最大宽度** | `400px`（超过则在 tooltip 内自动换行，不再二次截断） |
| **内容** | 单元格的**完整原文**，保留换行符；不允许在 tooltip 内再次截断 |
| **隐藏时机** | 鼠标离开单元格立即隐藏（无延迟） |
| **键盘可访问** | 单元格 `tabindex="0"`，键盘 focus 时同样触发 tooltip |

---

## 六、视图使用模板

### 6.1 标准用法

```html
<table>
  <thead>
    <tr>
      <th>姓名</th>
      <th class="col-truncate" data-max-lines="2" data-max-width="320">职位描述</th>
      <th>报考时间</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>张三</td>
      <td class="col-truncate-cell">
        负责面试现场组织、考官分配、抽签流程监督。需协调三个面试室同步进行……
      </td>
      <td>2026-05-28</td>
    </tr>
  </tbody>
</table>
```

业务方只声明"这是长文案列"+"最多 N 行"+"最大宽度"。是否真的需要截断、是否真的需要 tooltip，**全部由底层判断**，业务代码不参与。

### 6.2 与 `overflow.md` 的协同

两个规范可叠加：

- 表格整体仍包 `<div class="table-scroll">`（来自 [`overflow.md`](./overflow.md)）
- 长文案列加 `.col-truncate` + 配置（本规范）
- 操作列保留 `.sticky-col` 吸附（来自 [`overflow.md`](./overflow.md)）

三者互不冲突。

---

## 七、自检清单

- [ ] 长文案列的 `<th>` 上有 `.col-truncate` + `data-max-lines` + `data-max-width`
- [ ] 数据行的 `<td>` 上有 `.col-truncate-cell`
- [ ] 浏览器实测：内容短时单行展示、不出现省略号、hover 无 tooltip
- [ ] 浏览器实测：内容中等时断行展示，控制在 N 行以内、不出现省略号、hover 无 tooltip
- [ ] 浏览器实测：内容超长时末行末尾省略号、hover 后 300ms 出现 tooltip 展示完整原文
- [ ] tooltip 最大宽度 400px，超出在 tooltip 内自然换行
- [ ] 键盘 Tab focus 到该单元格时同样能弹 tooltip
- [ ] 与 `.sticky-col` 操作列共存时，操作列阴影行为仍正确

---

## 八、不适用场景

- **整列都是 ID / 数字 / 短状态码**：直接用主表格默认 `nowrap`，不需要本规范
- **HTML 富文本 / 含图片的内容**：本规范只面向纯文本；富文本需另设展开/收起组件
- **单元格需要内联编辑**：编辑态优先级高于截断，进入编辑态时取消所有截断行为
- **超过 500 字的超长文本**：tooltip 不适合承载，应改用"查看详情"按钮 + 抽屉/弹窗

---

## 九、附录：max-width 三档建议

| 场景 | max-width | 适用列示例 |
|------|-----------|-----------|
| 短描述 | `240px` | 备注、状态说明、标签描述 |
| 中描述 | `320px` | 职位描述、考点说明、异常原因 |
| 长描述 | `400px` | 复杂规则说明、用户长留言 |

> 选择最贴近实际内容平均长度的一档，不要一律取 `400px` 否则视觉权重失衡。
