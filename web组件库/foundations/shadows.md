---
name: 阴影规范（新风格）
category: foundations
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
---

# 阴影规范（新风格）

> 新风格使用 Slate 色 `rgba(15,23,42,*)` + 主色 `rgba(21,92,203,*)` 双层软阴影替代旧的 `rgba(0,0,0,0.1)` 单层硬阴影，整体更通透。Hover 叠加主色调蓝彰显交互反馈。

---

## 一、阴影 Token 体系

| Level | Token | 值 | 用途 |
|-------|-------|-----|------|
| 1 Card | `--shadow-card` | `0 1px 2px rgba(15,23,42,.04), 0 8px 24px rgba(15,23,42,.06)` | 卡片默认、输入 Focus 容器、Tag 块 |
| 2 Elevated | `--shadow-elevated` | `0 2px 4px rgba(15,23,42,.05), 0 16px 40px rgba(15,23,42,.08)` | 弹窗、抽屉、Notification、重要提示卡 |
| 3 Dropdown | `--shadow-dropdown` | `0 4px 12px rgba(15,23,42,.08), 0 12px 32px rgba(15,23,42,.08)` | Select 下拉、DatePicker 面板、Tooltip 白色变体、搜索建议 |
| 4 Hover | `--shadow-hover` | `0 4px 8px rgba(21,92,203,.08), 0 16px 32px rgba(21,92,203,.10)` | 卡片 hover、Feature Card hover |
| 5 Focus Ring | `--shadow-focus-ring` | `0 0 0 4px rgba(21,92,203,.15)` | 输入框 focus、按钮 focus、可聚焦元素 |
| 6 Brand Emphasis | `--shadow-btn-primary` | `0 2px 4px rgba(21,92,203,.20), 0 4px 10px rgba(21,92,203,.12)` | Logo / AI 标识等品牌强调，不用于默认按钮 |
| 7 Brand Hover | `--shadow-btn-hover` | `0 4px 10px rgba(21,92,203,.30), 0 8px 20px rgba(21,92,203,.16)` | 可交互品牌入口 hover，不用于普通按钮 |
| 8 Top Bar | `--shadow-topbar` | `0 1px 0 rgba(15,23,42,.04)` | 顶部导航底边（极轻） |
| 9 Toast | `--shadow-toast` | `0 4px 12px rgba(15,23,42,.10), 0 12px 32px rgba(15,23,42,.12)` | Toast 消息提示 |

---

## 二、与旧规范对照

| 旧 Level | 旧值 | 新 Level | 新值 |
|---------|------|---------|------|
| Level 1 Card | `0px 2px 5px rgba(0,0,0,.1)` | 1 Card | `0 1px 2px + 0 8px 24px` 双层软阴影 |
| Level 2 Container | `0px 4px 10px rgba(0,0,0,.1)` | 2 Elevated | `0 2px 4px + 0 16px 40px` |
| Level 3 Dropdown | `0px 8px 20px rgba(0,0,0,.1)` | 3 Dropdown | `0 4px 12px + 0 12px 32px` |
| Level 4 Modal | `0px 16px 40px rgba(0,0,0,.1)` | 2 Elevated | 同上 |
| — | — | 4 Hover | 主色调蓝（新增） |
| — | — | 5 Focus Ring | 主色 15% 外环（新增） |

---

## 三、应用规则

| 场景 | 推荐 Level |
|------|-----------|
| 普通卡片默认态 | 1 Card |
| 卡片 hover 抬升 | 4 Hover |
| 卡片选中（如入口 Feature Card）| 1 Card + 2px solid `--primary-600` 外描边 |
| Select / Dropdown 展开面板 | 3 Dropdown |
| Tooltip（深色变体） | 3 Dropdown 但弱化至 `rgba(15,23,42,.15)` 单层 |
| Tooltip（浅色变体） | 3 Dropdown |
| Dialog 容器 | 2 Elevated |
| Drawer 容器 | 2 Elevated |
| Popconfirm | 3 Dropdown |
| 输入框 focus | 5 Focus Ring |
| 实色主按钮 | 无默认阴影，hover 只变色 |
| Toast 通知 | 9 Toast |

---

## 四、动效衔接

卡片 hover 必须同时做三件事：

```css
.card:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-hover);
  border-color: var(--primary-100);
  transition: all .2s cubic-bezier(.4,0,.2,1);
}
```

---

## 五、禁用规则

1. 不允许使用 `rgba(0,0,0,*)` 系阴影（统一替换为 `rgba(15,23,42,*)`）
2. 不允许使用 Level 1 Card 以外的单层阴影（所有高级阴影必须双层以上）
3. 单个组件实例上 `box-shadow` 最多叠加 2 个 token（不得拼 3 个）
4. 不允许 `box-shadow: inset` 做装饰性内阴影
5. 选中态必须用"描边 + Focus Ring"表达，不允许只靠阴影

---

## 六、RGB 通道变量（换肤必须）

> **阴影中涉及主色的 `rgba()` 无法直接引用 `--primary-600`（CSS 语言限制），必须通过拆解 RGB 通道变量间接引用。换肤时只需修改通道变量，所有主色阴影自动跟随。**

### 6.1 问题

```css
/* ❌ CSS 不支持：rgba() 内不能放 var(--primary-600) */
--shadow-focus-ring: 0 0 0 4px rgba(var(--primary-600), .15);
```

### 6.2 解法：拆 RGB 通道

```css
:root[data-theme="new-style"] {
  /* 通道变量 — 换肤只改这两行 */
  --primary-rgb: 36, 99, 235;       /* #155CCB 的 RGB 拆解 */
  --slate-rgb:   15, 23, 42;        /* #0F172A 的 RGB 拆解 */
}
```

### 6.3 强制规则

1. **所有涉及主色的阴影必须使用 `rgba(var(--primary-rgb), *)` 写法**，禁止直接写 `rgba(21,92,203,*)`
2. **所有涉及中性色的阴影必须使用 `rgba(var(--slate-rgb), *)` 写法**，禁止直接写 `rgba(15,23,42,*)`
3. 本库当前只发布 `new-style` 一套主题；如新增主题，必须作为独立发布物完整验证。
4. 新增阴影 Token 时，必须使用通道变量，禁止硬编码 RGB 数值

### 6.4 当前主题通道

```css
/* 默认蓝色主题 */
:root[data-theme="new-style"] {
  --primary-rgb: 21, 92, 203;    /* #155CCB */
}
```

---

## 七、CSS 变量汇总（使用通道变量）

```css
:root[data-theme="new-style"] {
  /* RGB 通道变量 */
  --primary-rgb: 21, 92, 203;
  --slate-rgb:   15, 23, 42;

  /* 中性色阴影（使用 --slate-rgb） */
  --shadow-card:          0 1px 2px rgba(var(--slate-rgb),.04), 0 8px 24px rgba(var(--slate-rgb),.06);
  --shadow-elevated:      0 2px 4px rgba(var(--slate-rgb),.05), 0 16px 40px rgba(var(--slate-rgb),.08);
  --shadow-dropdown:      0 4px 12px rgba(var(--slate-rgb),.08), 0 12px 32px rgba(var(--slate-rgb),.08);
  --shadow-topbar:        0 1px 0 rgba(var(--slate-rgb),.04);
  --shadow-toast:         0 4px 12px rgba(var(--slate-rgb),.10), 0 12px 32px rgba(var(--slate-rgb),.12);

  /* 主色阴影（使用 --primary-rgb） */
  --shadow-hover:         0 4px 8px rgba(var(--primary-rgb),.08), 0 16px 32px rgba(var(--primary-rgb),.10);
  --shadow-focus-ring:    0 0 0 4px rgba(var(--primary-rgb),.15);
  --shadow-btn-primary:   0 2px 4px rgba(var(--primary-rgb),.20), 0 4px 10px rgba(var(--primary-rgb),.12);
  --shadow-btn-hover:     0 4px 10px rgba(var(--primary-rgb),.30), 0 8px 20px rgba(var(--primary-rgb),.16);
}
```
