---
name: 色彩系统（融合版）
category: foundations
status: draft
style: base
source: 智能评卷新风格 Token 结构 + 社考复刻组件库配色（2026-07-07 融合）
---

# 色彩系统（融合版）

> 组件结构沿用「智能评卷新风格」，**配色替换为社考复刻组件库**：主色 Royal Blue `#155CCB`、成功草绿 `#09B766`、错误橙红 `#EA4335`，中性色继续用 Slate 体系。
>
> Token **命名保持新风格分层**（`--primary-600` / `--accent-green-600` / `--danger-500`），仅色值换成社考。旧新风格值（`#2463EB` / `#10B981` / `#EF4444`）已全部弃用。

---

## 一、主色 Primary（社考蓝 · hue 217°）

| 层级 | 用途 | 色值 | CSS 变量 |
|------|------|------|----------|
| 700 | 点击态 | `#1050B8` | `--primary-700` |
| 600 | 主题色（默认） | `#155CCB` | `--primary-600` |
| 500 | 次级强调、进度条 | `#1E6AE0` | `--primary-500` |
| 400 | Hover / 淡化强调 | `#4A8AEF` | `--primary-400` |
| 300 | 按钮禁用、特殊描边 | `#85B2FC` | `--primary-300` |
| 200 | 文字禁用态 | `#BAD3FE` | `--primary-200` |
| 100 | 图标底块、Tag 底 | `#DCE9FF` | `--primary-100` |
| 50 | 卡片 Hover、表头斑马纹 | `#EEF4FF` | `--primary-50` |

### 1.1 主色渐变（品牌装饰专用）

| 用途 | 渐变定义 |
|------|---------|
| Logo / AI 标识 | `linear-gradient(135deg, #155CCB 0%, #1E6AE0 100%)` |
| 品牌标题强调 | `linear-gradient(90deg, #1050B8 0%, #155CCB 100%)` |
| 进度条填充 | `linear-gradient(90deg, #155CCB, #4A8AEF)` |

---

## 二、辅色 Accent-Green（成功 · 社考草绿）

> 按**角色**映射社考成功色阶（非按号），主色 600 = 社考 `--success`(#09B766)。

| 层级 | 用途 | 色值 | CSS 变量 |
|------|------|------|----------|
| 600 | 成功常规 / 考官主题 | `#09B766` | `--accent-green-600` |
| 500 | 成功悬浮 | `#36C884` | `--accent-green-500` |
| 700 | 成功点击 | `#089A57` | `--accent-green-700` |
| 300 | 成功禁用 | `#6DE0A9` | `--accent-green-300` |
| 200 | 成功边框 | `#A5F0CA` | `--accent-green-200` |
| 100 | 成功浅色背景 | `#D2F8E5` | `--accent-green-100` |
| 800 | 胶囊 success 文字色 | `#077C46` | `--accent-green-800` |

---

## 三、警告色 Warning（与社考一致，未变）

| 层级 | 用途 | 色值 | CSS 变量 |
|------|------|------|----------|
| 500 | 常规 | `#F59E0B` | `--warning-500` |
| 400 | 悬浮 | `#FBBF24` | `--warning-400` |
| 600 | 点击 | `#D97706` | `--warning-600` |
| 300 | 禁用 | `#FCD34D` | `--warning-300` |
| 200 | 特殊场景 | `#FDE68A` | `--warning-200` |
| 100 | 浅色背景 | `#FEF3C7` | `--warning-100` |
| 800 | 胶囊 warning 文字色 | `#92400E` | `--warning-800` |

---

## 四、错误色 Danger（社考橙红）

| 层级 | 用途 | 色值 | CSS 变量 |
|------|------|------|----------|
| 500 | 常规 | `#EA4335` | `--danger-500` |
| 400 | 悬浮 | `#F46858` | `--danger-400` |
| 600 | 点击 | `#D03224` | `--danger-600` |
| 300 | 禁用 | `#F89589` | `--danger-300` |
| 200 | 浅色悬浮 / 边框 | `#FCC4BC` | `--danger-200` |
| 100 | 浅色背景 | `#FEE3DF` | `--danger-100` |
| 800 | 胶囊 danger 文字色 | `#AE2519` | `--danger-800` |

---

## 五、信息色 Info（对齐主色蓝系）

| 层级 | 用途 | 色值 | CSS 变量 |
|------|------|------|----------|
| 600 | 常规 | `#155CCB` | `--info-600` |
| 500 | 强调 | `#1E6AE0` | `--info-500` |
| 400 | 悬浮 | `#4A8AEF` | `--info-400` |
| 100 | 浅色背景 | `#EEF4FF` | `--info-100` |

---

## 六、中性色 Slate（文本 / 边框 / 填充，与社考、新风格一致）

### 6.1 文本 Text

| 层级 | 用途 | 色值 | CSS 变量 |
|------|------|------|----------|
| 900 | 一级标题 | `#0F172A` | `--text-900` |
| 700 | 正文、按钮文字 | `#334155` | `--text-700` |
| 500 | 次要说明、表头 | `#64748B` | `--text-500` |
| 400 | 占位符、禁用 | `#94A3B8` | `--text-400` |
| 300 | 超弱说明、水印 | `#CBD5E1` | `--text-300` |
| white | 深色背景反白文字 | `#FFFFFF` | `--text-white` |

### 6.2 边框 Border

| 层级 | 用途 | 色值 | CSS 变量 |
|------|------|------|----------|
| strong | 重边框、Divider 粗线 | `#CBD5E1` | `--border-strong` |
| default | 标准描边、卡片边 | `#E2E8F0` | `--border` |
| soft | 超淡描边、表格行底 | `#EEF2F7` | `--border-soft` |

### 6.3 填充 / 背景 Fill

| 用途 | 色值 | CSS 变量 |
|------|------|----------|
| 页面底色 | `#F8FAFC` | `--bg-page` |
| 白色表面 / 卡片 | `#FFFFFF` | `--surface` |
| 次级表面（输入框背景、代码块） | `#F1F5F9` | `--surface-muted` |
| 表头背景、斑马纹 | `#F1F5F9` | `--table-head-bg` |
| Hover 浅色填充 | `#F1F5F9` | `--fill-hover` |
| Active 浅色填充 | `#E2E8F0` | `--fill-active` |

> 说明：管理后台默认只使用 `#F8FAFC`。极淡 32px 网格是可选品牌背景，仅在页面显式添加 `.sk-grid-bg` 时启用。
>
> ```css
> background:
>   linear-gradient(rgba(199,212,234,.15) 1px, transparent 1px) 0 0 / 32px 32px,
>   linear-gradient(90deg, rgba(199,212,234,.15) 1px, transparent 1px) 0 0 / 32px 32px,
>   var(--bg-page);
> ```

---

## 七、半透明 Overlay

| 用途 | 值 | CSS 变量 |
|------|-----|----------|
| 遮罩层（Dialog / Drawer） | `rgba(15,23,42,.45)` | `--overlay` |
| 浅色玻璃态底（Sidebar） | `rgba(255,255,255,.72)` | `--glass-surface` |
| 深色玻璃态底（Preview Toolbar） | `rgba(15,23,42,.88)` | `--glass-dark` |
| AppBar 右侧胶囊底 | `rgba(255,255,255,.14)` | `--glass-chip` |
| Focus ring（社考蓝）| `rgba(21,92,203,.15)` | `--focus-ring` |

---

## 八、与新风格原版色值映射（Migration Map）

| 新风格原值 | 融合版（社考） | 语义 |
|------|------|------|
| `#2463EB` | `#155CCB` | Primary 主色 |
| `#3B82F6` | `#1E6AE0` | Primary 500 |
| `#1D4ED8` | `#1050B8` | Primary 点击 |
| `#10B981` | `#09B766` | Success 主 |
| `#34D399` | `#36C884` | Success 悬浮 |
| `#047857` | `#077C46` | Success 文字 |
| `#EF4444` | `#EA4335` | Danger 主 |
| `#DC2626` | `#D03224` | Danger 点击 |
| `#B91C1C` | `#AE2519` | Danger 文字 |
| rgba(36,99,235,*) | rgba(21,92,203,*) | 蓝色光晕 / focus ring |
| 中性色 / 警告色 | 不变 | Slate + Amber 两版一致 |

---

## 九、CSS 变量汇总

```css
:root[data-theme="new-style"] {
  /* Primary — 社考蓝 */
  --primary-700: #1050B8;
  --primary-600: #155CCB;
  --primary-500: #1E6AE0;
  --primary-400: #4A8AEF;
  --primary-300: #85B2FC;
  --primary-200: #BAD3FE;
  --primary-100: #DCE9FF;
  --primary-50:  #EEF4FF;

  /* Accent Green — 社考草绿（角色映射）*/
  --accent-green-800: #077C46;
  --accent-green-700: #089A57;
  --accent-green-600: #09B766;
  --accent-green-500: #36C884;
  --accent-green-300: #6DE0A9;
  --accent-green-200: #A5F0CA;
  --accent-green-100: #D2F8E5;

  /* Warning — 未变 */
  --warning-800: #92400E;
  --warning-600: #D97706;
  --warning-500: #F59E0B;
  --warning-400: #FBBF24;
  --warning-300: #FCD34D;
  --warning-200: #FDE68A;
  --warning-100: #FEF3C7;

  /* Danger — 社考橙红 */
  --danger-800: #AE2519;
  --danger-600: #D03224;
  --danger-500: #EA4335;
  --danger-400: #F46858;
  --danger-300: #F89589;
  --danger-200: #FCC4BC;
  --danger-100: #FEE3DF;

  /* Info — 对齐主色蓝 */
  --info-600: #155CCB;
  --info-500: #1E6AE0;
  --info-400: #4A8AEF;
  --info-100: #EEF4FF;

  /* Text */
  --text-900: #0F172A;
  --text-700: #334155;
  --text-500: #64748B;
  --text-400: #94A3B8;
  --text-300: #CBD5E1;
  --text-white: #FFFFFF;

  /* Border */
  --border-strong: #CBD5E1;
  --border:        #E2E8F0;
  --border-soft:   #EEF2F7;

  /* Surface & Fill — 纯社考中性 */
  --bg-page:       #F8FAFC;
  --surface:       #FFFFFF;
  --surface-muted: #F1F5F9;
  --table-head-bg: #F1F5F9;
  --fill-hover:    #F1F5F9;
  --fill-active:   #E2E8F0;

  /* Overlay */
  --overlay:       rgba(15,23,42,.45);
  --glass-surface: rgba(255,255,255,.72);
  --glass-dark:    rgba(15,23,42,.88);
  --glass-chip:    rgba(255,255,255,.14);
  --focus-ring:    rgba(21,92,203,.15);
}
```

---

## 十、使用原则

1. **功能色不可自造**：success/warning/danger 的 500/100/800 三色必须成对使用
2. **文本对比度**：正文 ≥ 4.5:1，副文本 ≥ 3:1；Slate 系已满足
3. **不混用弃用值**：不得出现 `#2463EB` / `#10B981` / `#EF4444` 等新风格原值，也不得出现社考旧 flat 命名 `--primary`（融合版统一用分层命名）
4. **禁止近似替换**：必须使用表中精确值
