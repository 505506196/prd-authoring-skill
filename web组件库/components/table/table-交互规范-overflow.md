---
name: 表格交互规范 — 横向滚动与操作列吸附（容器维度）
category: interaction
scene: overflow
status: stable
component: table
paired-with: ../visual.md
sedimented-from: 考务管理系统 V2.0（2026-05-28）
applies-to: 所有 B 端业务表格（列数 ≥ 6 或带操作列）
---

# 表格交互规范 — 横向滚动与操作列吸附

> **本文件解决「容器维度」问题**：列多时表格如何横向滚动 + 操作列如何吸附 + 阴影如何按需出现。
>
> 单元格内长文案的断行 / 截断 / tooltip 规范在同目录 [`truncate.md`](./truncate.md)。两个文件正交，按需各自读取。
>
> 解决三类高频问题：
> 1. 列多挤压换行，单元格被压扁；
> 2. 操作列被挤出视口，用户必须横向滚动才能看到操作；
> 3. 操作列吸附后，无论是否需要滚动都强行带阴影，干扰阅读。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **不挤压** | 任意列数下单元格都不强制换行，宁可出现横向滚动条 |
| **总能看见操作** | 操作列吸附在右侧，横向滚动时跟随视口 |
| **该有阴影才有阴影** | 仅在"内容溢出 + 未滚到最右"时显示左侧阴影；不溢出或已滚到底，阴影消失 |
| **零侵入** | 业务视图只需写两个 class，无需引入组件、无需手动注册监听 |
| **动态生效** | 路由切换、Tab 切换、行数变化、窗口缩放，状态自动更新 |

---

## 二、三件套（核心契约）

### 2.1 容器类 `.table-scroll`

包裹 `<table>` 的 `<div>`，承担两件事：
- 横向溢出时出现滚动条；
- 标记自身的溢出/滚动状态（`is-overflowing` / `is-scrolled-end`），驱动子元素样式。

### 2.2 吸附列类 `.sticky-col`

加在需要吸附的 `<th>` 和 `<td>` 上（通常是最右侧的"操作"列）。`position:sticky;right:0` 实现吸附，背景显式声明三套（默认行/偶行/表头），避免 sticky 透明穿透。

### 2.3 状态类 `is-overflowing` / `is-scrolled-end`

由 `tableScroll.ts` 在运行时挂到 `.table-scroll` 上，**不要手动加**。CSS 用这两个 class 的组合决定阴影是否出现。

---

## 三、CSS 实现（已落在 `src/styles/components.css`）

```css
/* 横向滚动容器：内容溢出才出现滚动条 */
.table-scroll {
  width: 100%;
  overflow-x: auto;
  -webkit-overflow-scrolling: touch;
}
.table-scroll table { min-width: 960px; }
.table-scroll td,
.table-scroll th { white-space: nowrap; }

/* 吸附列：背景必须显式声明三套，避免 sticky 透明穿透 */
.table-scroll .sticky-col {
  position: sticky;
  right: 0;
  background: #FFFFFF;
  z-index: 2;
}
.table-scroll thead .sticky-col {
  background: #F1F5F9;   /* 与表头一致 */
  z-index: 3;
}
.table-scroll tr:nth-child(even) .sticky-col {
  background: #FAFBFC;   /* 与斑马纹一致 */
}

/* 阴影：仅在「容器溢出 且 未滚到最右」时出现 */
.table-scroll.is-overflowing:not(.is-scrolled-end) .sticky-col {
  box-shadow: -2px 0 4px rgba(0, 0, 0, 0.04);
}
```

> **为什么阴影要带条件？**
> 列数少时不需要吸附阴影，强行加阴影会让表格右侧出现一道无意义的灰边；滚到最右时所有列都已可见，阴影同样无意义。两个条件共同决定"现在还需要提示用户继续滚动"。

---

## 四、JS 实现（`src/lib/tableScroll.ts`）

```ts
// 全局给 .table-scroll 容器加溢出 / 滚动状态类
const HANDLED = new WeakSet<HTMLElement>()

function update(el: HTMLElement) {
  const overflow = el.scrollWidth - el.clientWidth > 1
  el.classList.toggle('is-overflowing', overflow)
  if (overflow) {
    const atEnd = el.scrollLeft + el.clientWidth >= el.scrollWidth - 1
    el.classList.toggle('is-scrolled-end', atEnd)
  } else {
    el.classList.remove('is-scrolled-end')
  }
}

function attach(el: HTMLElement) {
  if (HANDLED.has(el)) return
  HANDLED.add(el)
  const ro = new ResizeObserver(() => update(el))
  ro.observe(el)
  if (el.firstElementChild) ro.observe(el.firstElementChild)   // 行数变化
  el.addEventListener('scroll', () => update(el), { passive: true })
  requestAnimationFrame(() => update(el))                      // 初次同步
}

function scan() {
  document.querySelectorAll<HTMLElement>('.table-scroll').forEach(attach)
}

export function setupTableScroll() {
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', scan)
  } else {
    scan()
  }
  // 路由切换、Tab 切换等新增 .table-scroll 也要接管
  const mo = new MutationObserver(() => scan())
  mo.observe(document.body, { childList: true, subtree: true })
}
```

### 关键设计点

| 设计 | 解决的问题 |
|------|-----------|
| `WeakSet` 去重 | 同一元素重复 `attach` 会注册多份监听，造成内存泄漏 |
| `ResizeObserver` 监听容器 | 窗口缩放、侧边栏收起/展开导致容器变宽 |
| `ResizeObserver` 监听 `firstElementChild`（即 `<table>`） | 数据行增减、分页切换导致内容宽度变化 |
| `scroll` 监听 + passive | 用户横向滚动时实时更新 `is-scrolled-end` |
| `requestAnimationFrame` 初次同步 | 等待 CSS 注入完成，避免拿到的是 0 宽度 |
| `MutationObserver` 全局兜底 | Vue Router/v-if 动态新增的 `.table-scroll` 也能被接管 |
| 阈值 `> 1` / `>= scrollWidth - 1` | 规避亚像素误差导致的状态抖动 |

### 入口注册

`src/main.ts` 顶层调用一次即可：

```ts
import { setupTableScroll } from './lib/tableScroll'
setupTableScroll()
```

---

## 五、视图使用模板

### 5.1 标准模板（带操作列）

```vue
<div class="card">
  <div class="table-scroll">
    <table>
      <thead>
        <tr>
          <th>姓名</th>
          <th>身份证号</th>
          <th>所属考点</th>
          <th>报考职位</th>
          <th>面试场次</th>
          <th class="sticky-col">操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="row in rows" :key="row.id">
          <td>{{ row.name }}</td>
          <td>{{ row.idNo }}</td>
          <td>{{ row.center }}</td>
          <td>{{ row.position }}</td>
          <td>{{ row.session }}</td>
          <td class="sticky-col">
            <button class="btn-link">编辑</button>
            <span class="table-action-divider"></span>
            <button class="btn-link btn-link-danger">删除</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
  <Pagination ... />
</div>
```

### 5.2 不需要操作列的纯展示表格

```vue
<div class="table-scroll">
  <table>
    <thead><tr><th>...</th></tr></thead>
    <tbody>...</tbody>
  </table>
</div>
```

不写 `.sticky-col` 即可，状态类仍会挂上但没有任何视觉副作用。

### 5.3 规则速记

| 场景 | 写法 |
|------|------|
| 表格容器 | 包一层 `<div class="table-scroll">` |
| 操作列 | `<th class="sticky-col">` + 同列每个 `<td class="sticky-col">` |
| 操作按钮 | 文字按钮 `.btn-link`，按钮间用 `.table-action-divider` 分隔 |
| 危险操作 | 加 `.btn-link-danger` 副类（红色文字按钮） |
| 状态类 | **永远不要手动写** `is-overflowing` / `is-scrolled-end` |

---

## 六、矩阵型表格扩展（双向 sticky）

适用于"分配场次 × 面试室"等二维勾选场景。表头行 + 行首列同时吸附，形成 L 形冻结区。

```css
.assign-matrix-wrap {
  overflow: auto;
  border: 1px solid #E6E8EB;
  border-radius: 4px;
  max-height: 420px;        /* 同时启用纵向滚动 */
}

.assign-matrix thead th {
  position: sticky; top: 0;  z-index: 2;  background: #F5F9FE;
}
.assign-matrix tbody th {
  position: sticky; left: 0; z-index: 1;  background: #F5F9FE;
  min-width: 140px;
}
.assign-matrix thead th:first-child {
  /* 左上角格子，必须高一层 z-index */
  left: 0; z-index: 3;
}
```

### 关键约束

| 约束 | 说明 |
|------|------|
| **左上角 z-index = 3** | 否则横向滚动时被纵向 sticky 表头盖住 |
| **行表头与该行单元格必须共享背景** | 斑马纹要在 `tbody th` 和 `tbody td` 上同时生效，否则视觉上断成两段 |
| **滚动条美化** | `::-webkit-scrollbar` 设 6px，hover 变深，避免默认大滚动条遮挡内容 |
| **禁掉行 hover** | `tbody tr:hover { background: transparent }` —— 矩阵不需要整行变色 |

矩阵型表格**不复用** `.table-scroll` + `tableScroll.ts` 这套机制（因为矩阵的视觉提示是边框 + 圆角容器，不是阴影）。两套并存、各自独立。

---

## 七、与组件规范库 `table.md` 的关系

| 维度 | 本规范 | `table.md` |
|------|--------|-----------|
| 定位 | 工程落地（HOW） | 视觉/Token（WHAT） |
| 涵盖 | 容器、滚动、吸附、监听 | 颜色、字号、间距、行高、变体矩阵 |
| 来源 | 业务页面真实痛点 | MasterGo 设计稿 + DSL |
| 是否复用 | 所有用 `<table>` 的业务页面 | 表格组件本身的样式定义 |

**冲突时以 `table.md` 为准**（视觉值），本规范不覆盖任何颜色/字号/间距值，只规定容器结构和动态行为。

---

## 八、自检清单（交付前必查）

- [ ] 表格外层有 `<div class="table-scroll">`
- [ ] 操作列的 `<th>` 和所有 `<td>` 都有 `.sticky-col`
- [ ] 操作列没有手动写 `is-overflowing` / `is-scrolled-end`
- [ ] `main.ts` 顶层调用了 `setupTableScroll()`，且只调用一次
- [ ] 浏览器实测：列少时无阴影、列多时滚动有阴影、滚到最右阴影消失
- [ ] 浏览器实测：路由切换到新页面后，新表格依然有阴影状态
- [ ] 浏览器实测：删除/新增数据行后，状态自动更新
- [ ] 操作按钮使用 `.btn-link`，按钮间有 `.table-action-divider`，危险操作加 `.btn-link-danger`
- [ ] sticky 列的背景在默认行 / 偶数行 / 表头三种场景都正确（非透明）

---

## 九、不适用场景

- **超过 1000 行的虚拟滚动表格**：本规范基于原生 `<table>` 渲染，大数据需另接虚拟滚动库
- **可拖拽列宽的表格**：`white-space:nowrap` 与拖拽列宽冲突，需关闭 nowrap 并自行处理截断
- **可固定左列的表格**：当前只规定右侧吸附（操作列场景）；如需左固定列，参考 `table.md` 第十二节"固定列"自行扩展，并在 `tableScroll.ts` 增加 `is-scrolled-start` 状态类

---

## 十、附录：当前覆盖范围

考务管理系统 V2.0 已应用本规范的视图（共 14 处 `.table-scroll` 实例）：

```
src/views/Supervisors.vue       考务人员
src/views/Sessions.vue          场次编排
src/views/ScoreRules.vue        评分规则（2 处）
src/views/Positions.vue         职位管理
src/views/DrawStats.vue         抽签统计（3 处）
src/views/Candidates.vue        考生管理
src/views/Progress.vue          进度监控
src/views/ScoreMgmt.vue         成绩管理（3 处）
src/views/InterviewProgress.vue 面试进度
```

矩阵型扩展（`.assign-matrix`）应用于：

```
src/views/Positions.vue         职位×场次×面试室分配矩阵
```
