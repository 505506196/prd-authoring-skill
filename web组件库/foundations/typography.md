---
name: 字体规范（新风格）
category: foundations
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
---

# 字体规范（新风格）

> 字体族由 AlibabaPuHuiTi 切换为 PingFang SC 主导，强调中文黑体重磅；标题字重加重到 700+，部分副标题支持主色渐变处理。

---

## 一、字体族 Font Family

| 优先级 | 字体 | 用途 |
|--------|------|------|
| 1 | PingFang SC | 主要中文字体 |
| 2 | -apple-system | Apple 系统字体 |
| 3 | HarmonyOS Sans | 鸿蒙字体 |
| 4 | Microsoft YaHei | Windows 中文字体 |
| 5 | Noto Sans SC | 跨平台中文备用 |
| 6 | Inter | 西文主字体 |
| 7 | Helvetica Neue | 西文备用 |

```css
--font-family-primary: "PingFang SC", -apple-system, "HarmonyOS Sans",
                       "Microsoft YaHei", "Noto Sans SC", Inter,
                       "Helvetica Neue", Arial, sans-serif;
--font-family-mono: "SF Mono", Menlo, Consolas, "JetBrains Mono", monospace;
```

---

## 二、字重 Font Weight

| 字重 | 值 | CSS 变量 | 用途 |
|------|-----|----------|------|
| Regular | 400 | `--fw-regular` | 正文、辅助 |
| Medium | 500 | `--fw-medium` | Tag、菜单项、按钮 |
| Semibold | 600 | `--fw-semibold` | 卡片标题、弹窗标题、强调 |
| Bold | 700 | `--fw-bold` | 页面 H1 / H2、数据强调 |
| Extrabold | 800 | `--fw-extrabold` | 登录页 Hero / 入口大标题 |

---

## 三、字号体系（Type Scale）

> 正文区采用**清爽均步 12 / 14 / 16**（社考取向，去掉旧的 13 / 15 奇数档）：Body-Strong 16、Body 14、Caption / Tiny 12（同字号，靠字重 400 / 500 与用途区分）。标题区保持 18 / 22 / 28 / 40。

| Token | 字号/行高/字重 | CSS 变量 | 典型用途 |
|-------|-------------|----------|---------|
| `Display/XL` | 40 / 52 / 800 | `--font-display-xl` | 登录页大标题、入口 Hero 标题 |
| `Display/L` | 28 / 40 / 700 | `--font-display-l` | 模块首页 H1 |
| `H2` | 22 / 32 / 700 | `--font-h2` | 页面二级标题 |
| `H3` | 18 / 28 / 600 | `--font-h3` | 卡片标题、弹窗标题 |
| `Body-Strong` | 16 / 24 / 600 | `--font-body-strong` | 强调正文 |
| `Body-LG` | 16 / 24 / 400 | `--font-body-lg` | 大号正文、登录页说明 |
| `Body` | 14 / 22 / 400 | `--font-body` | 默认正文、表格 |
| `Caption` | 12 / 18 / 400 | `--font-caption` | 面包屑、辅助说明 |
| `Tiny` | 12 / 18 / 500 | `--font-tiny` | Badge、Tag、标签 |

**控件文字（Semibold，用于按钮 / 输入 / Select 等交互控件）：**

| Token | 字号/行高/字重 | CSS 变量 | 用途 |
|-------|-------------|----------|------|
| `Control-LG` | 16 / 24 / 600 | `--font-control-lg` | LG 按钮 / 大输入 |
| `Control` | 14 / 22 / 600 | `--font-control` | 默认按钮 / 输入 |
| `Control-SM` | 12 / 18 / 600 | `--font-control-sm` | SM 按钮 / 小控件 |

---

## 四、字间距 / 装饰 / 大小写

| 场景 | 值 |
|------|-----|
| 字间距（默认） | `normal` |
| 字间距（分组标题 / 小写标签） | `0.08em` |
| 文本装饰 | `none`；链接 hover 添加 `underline` |
| 大小写 | 中文 `none`；英文分组标签用 `uppercase` |

---

## 五、标题渐变强调

登录页与入口页大标题的"第二行"使用主色渐变文字：

```css
.gradient-title {
  background: linear-gradient(90deg, #155CCB 0%, #4A8AEF 100%);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}
```

---

## 六、页面层级字重规范

| 层级 | 字重 | 适用元素 |
|------|------|---------|
| L0 Hero | Extrabold 800 | 登录页、入口 Hero 标题 |
| L1 强调 | Bold 700 | 页面主标题、模块 H1/H2 |
| L1 次强调 | Semibold 600 | 卡片 / 弹窗 / 表单分组标题 |
| L2 正文 | Regular 400 | 正文、表格数据、表单标签 |
| L3 强调数据 | Bold 700 | 统计数字、关键指标 |
| 按钮 / 菜单 | Semibold 600 | 按钮文字、导航激活项 |
| Tag / Badge | Medium 500 | 胶囊标签、状态徽章 |

### 6.1 组件字重映射

| 组件 | 字号 | 字重 |
|------|------|------|
| 顶部导航 Logo | 16/24 | Semibold |
| 页面标题 | 28/40 | Bold |
| 弹窗标题 | 18/28 | Semibold |
| 卡片标题 | 18/28 | Semibold |
| 表格表头 | 12/18 | Semibold |
| 表格内容 | 14/22 | Regular |
| 按钮文字 | 16/24 | Semibold |
| 标签 Tag | 12/18 | Medium |
| 面包屑 | 12/18 | Regular |
| 统计数字 | 28/40 或 40/52 | Bold / Extrabold |

---

## 七、数字字体

金额、分数、统计数字需启用等宽数字：

```css
font-variant-numeric: tabular-nums;
```

---

## 八、CSS 变量汇总

```css
:root[data-theme="new-style"] {
  --font-family-primary: "PingFang SC", -apple-system, "HarmonyOS Sans",
                         "Microsoft YaHei", "Noto Sans SC", Inter,
                         "Helvetica Neue", Arial, sans-serif;
  --font-family-mono:    "SF Mono", Menlo, Consolas, "JetBrains Mono", monospace;

  --fw-regular:   400;
  --fw-medium:    500;
  --fw-semibold:  600;
  --fw-bold:      700;
  --fw-extrabold: 800;

  --font-display-xl:    800 40px/52px var(--font-family-primary);
  --font-display-l:     700 28px/40px var(--font-family-primary);
  --font-h2:            700 22px/32px var(--font-family-primary);
  --font-h3:            600 18px/28px var(--font-family-primary);
  --font-body-strong:   600 16px/24px var(--font-family-primary);
  --font-body-lg:       400 16px/24px var(--font-family-primary);
  --font-body:          400 14px/22px var(--font-family-primary);
  --font-caption:       400 12px/18px var(--font-family-primary);
  --font-tiny:          500 12px/18px var(--font-family-primary);

  /* 控件文字（LG / 默认 / SM，Semibold） */
  --font-control-lg:    600 16px/24px var(--font-family-primary);
  --font-control:       600 14px/22px var(--font-family-primary);
  --font-control-sm:    600 12px/18px var(--font-family-primary);
}
```
