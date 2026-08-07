---
name: 圆角规范（融合版）
category: foundations
status: draft
style: base
source: 智能评卷新风格 Token 结构 + 社考复刻组件库紧凑圆角阶梯（2026-07-07 融合）
---

# 圆角规范（融合版）

> 社考风格优化版**紧凑圆角**阶梯（Token 命名沿用 `--r-*`）。按元素层级递进：微结构 2px → SM 小控件 4px → **默认控件（按钮/输入）6px** → 面板/Dropdown 8px → 卡片 12px → 大容器 16px，胶囊元素 999px。
>
> 与旧「新风格大圆角」（按钮 14 / 卡片 18）区别：整体收紧，视觉更克制、更贴近社考后台观感。

---

## 一、圆角 Token 体系

| Token | 值 | CSS 变量 | 用途 |
|-------|-----|----------|------|
| xs | 2px | `--r-xs` | Badge、微结构、表格单元局部状态 |
| sm | 4px | `--r-sm` | SM 小控件、小 Tag |
| control | 6px | `--r-control` | **默认输入 / 按钮 / Select / Search** |
| md | 8px | `--r-md` | Alert、图标 Tile、Dropdown 面板、Toast |
| lg | 12px | `--r-lg` | 卡片、弹窗、抽屉（桌面端）、Section 容器 |
| xl | 16px | `--r-xl` | Hero 大卡片、登录容器、统计大块 |
| pill | 999px | `--r-pill` | 胶囊按钮、Avatar chip、可交互 Tag、Badge、Switch、Progress |

**语义别名（组件引用建议用别名）：**

| 别名 | = | 值 | 用途 |
|------|---|-----|------|
| `--r-cell` | `--r-xs` | 2px | 微结构 / 表格局部状态 |
| `--r-input` | `--r-control` | 6px | 默认输入 / Select / Search 触发框 |
| `--r-btn` | `--r-control` | 6px | 默认按钮 |
| `--r-card` | `--r-lg` | 12px | 卡片 / 面板 / 对话框 |
| `--r-hero` | `--r-xl` | 16px | Hero / 大模态 |
| `--r-tag` | `--r-sm` | 4px | 静态状态 Tag |

> 注：默认输入 / 按钮走 `--r-control`(6px)；SM 小尺寸控件用 `--r-sm`(4px)；面板 / Dropdown 用 `--r-md`(8px)；卡片用 `--r-lg`(12px)。

---

## 二、应用规则（按组件层级）

| 组件 | 圆角 Token | 值 |
|------|----------|-----|
| 静态状态 Tag | sm | 4px |
| Checkable Tag / Badge（胶囊型） | pill | 999px |
| 表格单元 | xs | 2px |
| Checkbox | xs | 2px（方形）|
| 输入框 Input / Select / DatePicker / TimePicker 触发框（默认）| control | 6px |
| 按钮（默认，除胶囊按钮） | control | 6px |
| SM 小尺寸控件（按钮 / 输入）| sm | 4px |
| 搜索框 Search | control | 6px |
| 侧栏菜单项 | control | 6px |
| Switch | pill | 999px |
| 图标 Tile（彩色底 icon 容器） | md | 8px |
| Alert / Dropdown 面板 / Toast | md | 8px |
| Tooltip | sm | 4px |
| 卡片 Card / Feature Card / 弹窗 Dialog | lg | 12px |
| 抽屉 Drawer（桌面，仅内侧角） | lg | 12px |
| Section / 大容器 | lg | 12px |
| Hero 容器 / 登录容器 / 统计大数字面板 | xl | 16px |
| Avatar / 用户 chip / Progress Bar 轨道 | pill | 999px |

---

## 三、禁用规则

1. 静态状态 Tag 必须使用 `--r-tag`（4px）；可交互 Tag / Badge 才使用 `--r-pill`。
2. 所有带 `--r-pill` 的元素需有足够横向 padding（≥ 12px）才能展现胶囊形
3. 禁止 `border-radius: 0`，除非业务必要（长图切片、嵌入 iframe）
4. 嵌套容器圆角递减（如卡片 12 → 内部 Tile 8 → 状态 Tag 4）。

---

## 四、CSS 变量汇总

```css
:root[data-theme="new-style"] {
  --r-xs:      2px;
  --r-sm:      4px;
  --r-control: 6px;
  --r-md:      8px;
  --r-lg:      12px;
  --r-xl:      16px;
  --r-pill:    999px;

  /* 语义别名 */
  --r-cell:  var(--r-xs);
  --r-input: var(--r-control);
  --r-btn:   var(--r-control);
  --r-card:  var(--r-lg);
  --r-hero:  var(--r-xl);
  --r-tag:   var(--r-sm);
}
```
