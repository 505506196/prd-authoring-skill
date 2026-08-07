---
name: 多选框交互规范 — 三态联动 / 全选反选 / 键盘
category: interaction
scene: group-control
status: stable
component: checkbox
paired-with: ../../checkbox.md
applies-to: 所有 Checkbox / Checkbox Group / 表头全选 / 树形多选
---

# 多选框交互规范 — Indeterminate 三态 / 全选反选 / 键盘 Space

> **本文件解决「全选 checkbox 与子项不同步」「半选状态没有正确联动」「键盘 Space 不能切换」三类问题。**
>
> 视觉规范见 [`../../checkbox.md`](../../checkbox.md)。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **三态精确同步** | 全选 / 半选 / 未选与子项严格一一对应 |
| **联动方向双向** | 父项点击同步所有子项，子项变化反向汇总到父项 |
| **键盘 Space 切换** | 不依赖鼠标也能完成多选 |
| **禁用项不参与统计** | 全选 / 反选 / 半选计算时跳过禁用项 |

---

## 二、三态规则

### 2.1 状态判定

| 状态 | 判定条件 |
|------|---------|
| **未选 (unchecked)** | 所有可用子项均未选中 |
| **半选 (indeterminate)** | 至少 1 个子项选中 + 至少 1 个子项未选中（不含禁用项）|
| **全选 (checked)** | 所有可用子项均选中 |

> **关键：** 禁用项**不计入**全选 / 半选判定的分母与分子。"全选"指"所有非禁用项都被选中"。

### 2.2 状态切换

| 父项当前状态 | 点击后 | 子项变化 |
|------------|--------|---------|
| 未选 → | 全选 | 所有非禁用子项全部选中 |
| 半选 → | 全选（默认）| 所有非禁用子项全部选中 |
| 全选 → | 未选 | 所有非禁用子项全部取消 |

> **半选→全选 vs 半选→未选：** 默认行为是"半选→全选"，符合"用户希望快速选完"的直觉。如业务需"半选→未选"，必须在 props 中显式声明 `indeterminateClickBehavior="uncheck"`。

### 2.3 半选只读

- 半选状态**不允许**通过点击直接进入（只能由子项联动产生）
- 半选状态的视觉是 `--primary-600` 底 + 白色短横线（参见 checkbox.md 2.4）

---

## 三、Group 联动

### 3.1 父→子（点击全选）

```
点击全选 checkbox
  ├─ 当前 checked → 所有非禁用子项 checked = true
  └─ 当前 unchecked / indeterminate → 所有非禁用子项 checked = false
```

### 3.2 子→父（汇总）

```
子项变化
  └─ 重新计算父项状态：
       count(checked) === count(enabled) → 父项 = checked
       count(checked) === 0               → 父项 = unchecked
       0 < count(checked) < count(enabled) → 父项 = indeterminate
```

### 3.3 嵌套树形多选

- 每一层级都遵循"父汇总子 / 父联动子"原则
- 详见 [`../../tree/interaction/expand-select.md`](../../tree/interaction/expand-select.md)

---

## 四、键盘交互

### 4.1 单个 Checkbox

| 按键 | 行为 |
|------|------|
| Tab | 聚焦 |
| Space | 切换 checked / unchecked（**禁止切到 indeterminate**）|
| Enter | 不响应（与 button 区分）|

### 4.2 Checkbox Group

| 按键 | 行为 |
|------|------|
| Tab | 进入第一项，再 Tab 离开整组（不在组内循环）|
| Space | 切换当前聚焦项 |
| ArrowUp / ArrowDown | **不响应**（与 RadioGroup 区分；多选不需要"组内单选"语义）|

### 4.3 Focus Ring

- `:focus-visible` 显示 `0 0 0 4px rgba(21,92,203,.15)` 外环
- 鼠标点击不显示 Focus Ring

---

## 五、表头全选（表格场景）

### 5.1 与表格集成

| 元素 | 规则 |
|------|------|
| 全选 checkbox 位置 | 第一列表头，垂直水平居中 |
| 行内 checkbox 位置 | 每行第一列，垂直水平居中 |
| 半选触发 | 任一行选中即触发半选 |

### 5.2 翻页保留选中

| 场景 | 行为 |
|------|------|
| 跨页全选 | 全选只针对**当前页**，切页后状态独立 |
| "全选所有页"提示 | 当前页全选后，表格上方出现 Banner："已选当前页 N 条，[选中全部 M 条]" |
| 切换页码 | 已选项保留在内存中，回到该页时仍为选中 |

### 5.3 取消全选

- 跨页选择后，点击"取消全选"清空所有页选中
- 全选状态在所有页同步重置

---

## 六、与表单校验集成

| 规则 | 说明 |
|------|------|
| 必选验证 | "至少选 1 项"：`checkedValues.length >= 1` |
| 数量上限 | 业务方传入 max；超出时其余 checkbox 进入 disabled，hover 提示"最多选择 N 项" |
| 失焦验证 | Group 失焦时整体校验，不允许某项失焦时单独校验 |
| 错误态视觉 | Group 容器边框变为 `--danger-500`，下方显示错误文案 |

---

## 七、动画

| 状态切换 | 过渡 |
|---------|------|
| unchecked → checked | 背景 fade 100ms + 勾选 SVG `stroke-dashoffset` 200ms |
| checked → unchecked | 反向 200ms |
| → indeterminate | 横线 `scaleX(0→1)` 150ms |

> 切换动画总时长不超过 300ms（B 端节奏，参考通用规范 A5.3）。

---

## 八、自检清单

- [ ] 全选 checkbox 点击后所有非禁用子项全选 / 全消
- [ ] 子项变化后父项状态正确（unchecked / indeterminate / checked）
- [ ] 禁用子项不计入全选 / 半选判定
- [ ] 半选状态不能通过直接点击进入
- [ ] Tab 可聚焦，Space 可切换
- [ ] ArrowUp/Down 在 Group 内**不响应**
- [ ] Focus Ring 仅 `:focus-visible` 显示
- [ ] 表头全选只针对当前页（不跨页）
- [ ] 跨页全选场景下表格上方显示提示 Banner
- [ ] 数量上限触发时其他项 disabled + Tooltip 提示原因
- [ ] 切换动画在 300ms 内完成

---

## 九、不适用场景

- **单选语义但用 Checkbox 实现**：必须改用 Radio
- **状态开关**（如"启用 / 禁用"）：用 Switch 而非 Checkbox
- **表格行级展开 / 折叠**：用展开按钮而非 Checkbox
