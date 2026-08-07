---
name: 间距系统（新风格）
category: foundations
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
---

# 间距系统（新风格）

> 8px 栅格基数保持不变，新增 56 / 72 两档用于 Hero 场景；保留旧规范的 4~48 档。整体以"大面积留白 + 呼吸感"为目标，比旧规范更宽松。

---

## 一、间距 Token 体系（8px 栅格）

| Token | 值 | CSS 变量 | 典型用途 |
|-------|-----|----------|---------|
| xxs | 4px | `--sp-xxs` | 图标和文字贴合、微距修正 |
| xs | 8px | `--sp-xs` | 按钮组间距、密集布局、Tag 内 padding |
| sm | 12px | `--sp-sm` | 表单行间距、卡片内小分组、按钮内 padding |
| md | 16px | `--sp-md` | 卡片内容 padding、列表项间距、表单分组间距 |
| lg | 20px | `--sp-lg` | 卡片 padding 下限、模块内分段 |
| xl | 24px | `--sp-xl` | 卡片 padding 上限、弹窗 padding（body） |
| 2xl | 32px | `--sp-2xl` | 页面左右 padding、章节间距 |
| 3xl | 40px | `--sp-3xl` | 大章节间距、Hero 内部分段 |
| 4xl | 56px | `--sp-4xl` | 登录页 / 入口页上下留白 |
| 5xl | 72px | `--sp-5xl` | Hero 超大留白 |

---

## 二、场景约定

| 场景 | 间距值 |
|------|--------|
| 页面左右 padding（内容区） | 32px (2xl) |
| 页面顶部内 padding | 24px (xl) |
| 卡片内 padding | 20~24px (lg~xl) |
| 弹窗内 padding（body） | 28px 水平 + 20px 垂直 |
| 弹窗 header / footer padding | 20px 28px |
| 抽屉内 padding | 24px (xl) |
| 按钮内 padding（水平） | sm 14px / md 18px / lg 22px |
| 按钮组间距 | 8px (xs) |
| 表单 Label 与输入的间距 | 8px (xs) |
| 表单行与行 | 16px (md) |
| 表格行高 | 48px（内部不用 spacing token，用固定行高） |
| 列表项上下 padding | 12px (sm) |
| 侧栏菜单项上下 padding | 10px（特例，非 token） |
| Section 上下间距 | 32px (2xl) |
| Feature Card 网格间距 | 24px (xl) |
| Hero 内部上下间距 | 40~56px (3xl~4xl) |
| Toast 与视口距离（顶 / 右） | 88px / 32px |

---

## 三、与旧规范对照

| 旧 Token | 旧值 | 新 Token | 新值 |
|---------|------|---------|------|
| `--spacing-xxs` | 4px | `--sp-xxs` | 4px |
| `--spacing-xs` | 8px | `--sp-xs` | 8px |
| `--spacing-sm` | 12px | `--sp-sm` | 12px |
| `--spacing-md` | 16px | `--sp-md` | 16px |
| `--spacing-lg` | 20px | `--sp-lg` | 20px |
| `--spacing-xl` | 24px | `--sp-xl` | 24px |
| `--spacing-2xl` | 32px | `--sp-2xl` | 32px |
| `--spacing-3xl` | 48px | `--sp-3xl` | 40px（下调 8px） |
| — | — | `--sp-4xl` | 56px（新增） |
| — | — | `--sp-5xl` | 72px（新增） |

**关键变化**：旧 `--spacing-3xl = 48px` 改为 `--sp-3xl = 40px`，并补 56/72 两档，使得 Hero 场景可以拉出更大的呼吸感。

---

## 四、亲密性原则

| 元素关系 | 间距范围 |
|---------|---------|
| 强关联（标题与副标题、图标与文字） | 4~8px |
| 中等关联（表单 label 与输入） | 8~12px |
| 弱关联（同组不同项） | 16~20px |
| 分组之间 | 24~32px |
| 大章节之间 | 40~56px |
| Hero 内部段落 | 56~72px |

> 组内间距必须**严格小于**组外间距，差值至少 8px。

---

## 五、禁用规则

1. 禁止出现非 token 值：`7px` / `11px` / `13px` / `15px` / `18px` / `26px` / `38px` 等
2. 唯一允许的非 token 值：侧栏菜单项的 `10px` 垂直 padding（已记录）
3. 不允许用负 margin 修正间距，除非明确的"重叠效果"需求
4. 不允许用 `gap` 和 `margin` 对同一元素同时加间距
5. 列表 / 卡片网格必须使用 `gap`，不允许 `margin` 每一项

---

## 六、CSS 变量汇总

```css
:root[data-theme="new-style"] {
  --sp-xxs: 4px;
  --sp-xs:  8px;
  --sp-sm:  12px;
  --sp-md:  16px;
  --sp-lg:  20px;
  --sp-xl:  24px;
  --sp-2xl: 32px;
  --sp-3xl: 40px;
  --sp-4xl: 56px;
  --sp-5xl: 72px;
}
```
