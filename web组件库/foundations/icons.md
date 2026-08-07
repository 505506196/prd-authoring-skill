---
name: 图标系统（新风格）
category: foundations
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
---

# 图标系统（新风格）

> 线性图标统一 `stroke-width: 1.8`；命名与语义对齐 lucide / heroicons 集，旧规范中的填充双色图标仅用于"图标 Tile"场景。

---

## 一、设计原则

| 原则 | 说明 |
|------|------|
| 统一线性 | 全系统默认线性单色图标，描边 1.8px |
| 拟物仅在 Tile | 只在彩色图标底块（Icon Tile）场景用柔和双色块（浅色底 + 深色描边）|
| 禁用 emoji | 不使用表情符号、✓✕★▲▼◆■ 等 Unicode 字符充当图标 |
| 禁用旧几何 | 旧规范里的 `◆ ■ ▶ ●` 等 Unicode 必须替换为 SVG |
| 复用唯一源 | 所有 SVG 从项目内 `icons-preview.html` 精确复制，不允许手绘 |

---

## 二、规格

### 2.1 线性图标

| 尺寸 | 安全区 | 描边 | 用途 |
|------|--------|------|------|
| 16 × 16px | 14 × 14 | 1.6 | 输入框前缀、Tag 内图标、小按钮 |
| 20 × 20px | 18 × 18 | 1.8 | 默认场景、按钮、菜单项 |
| 24 × 24px | 22 × 22 | 1.8 | 页面标题、Card Header、侧栏一级 |
| 32 × 32px | 28 × 28 | 2.0 | 大卡片、空状态插画主元素 |

### 2.2 图标 Tile（彩色底）

| 变体 | 尺寸 | 圆角 | 底色 | 图标色 |
|------|------|------|------|------|
| 入口页 Tile | 56 × 56 | 14px (md) | `--primary-100` / `--accent-green-100` | `--primary-600` / `--accent-green-600` |
| 子模块 Tile | 44 × 44 | 14px (md) | 同上 | 同上 |
| 激活态 | — | — | `--primary-600` / `--accent-green-600`（深色反转） | `#FFFFFF` |

---

## 三、图标颜色映射

| 用途 | 默认 | Hover | Active | Disabled |
|------|------|-------|--------|----------|
| 主操作图标 | `--text-700` | `--primary-600` | `--primary-700` | `--text-400` |
| 主题色图标 | `--primary-600` | `--primary-500` | `--primary-700` | `--primary-300` |
| 成功图标 | `--accent-green-600` | `--accent-green-500` | `--accent-green-700` | `--accent-green-300` |
| 警告图标 | `--warning-500` | `--warning-400` | `--warning-600` | `--warning-300` |
| 危险图标 | `--danger-500` | `--danger-400` | `--danger-600` | `--danger-300` |
| 反白图标（深色按钮内） | `--text-white` | `--text-white` | `--text-white` | `rgba(255,255,255,.5)` |

---

## 四、常用图标清单

### 4.1 状态 / 操作

```
clipboard-check / user / users / shield-check / id-card / clock
chart-bar / trending-up / trending-down / check / x-mark
plus / minus / edit / trash / copy / download / upload
search / filter / settings / bell / more-horizontal / more-vertical
```

### 4.2 导航

```
chevron-right / chevron-left / chevron-up / chevron-down
arrow-right / arrow-left / arrow-up / arrow-down
external-link / home / menu / grid
```

### 4.3 业务（面试 / 评卷场景）

```
book-open / file-text / pen / pen-tool / check-circle
award / badge / graduation-cap / stopwatch / megaphone
```

---

## 五、图标与文字的对齐

| 场景 | 规则 |
|------|------|
| 图标 + 文字（水平） | 图标垂直居中对齐文字 x-height，间距 8px |
| 图标作为按钮前缀 | 间距 8px，图标尺寸与文字行高对齐 |
| 图标在导航激活项 | 激活时图标色切到主色，不放大 |

---

## 六、禁用规则

1. 禁止手绘 SVG path 数据
2. 禁止从 Ant Design / Feather / Element Plus 等外部库复制 SVG
3. 禁止用 emoji `✅❌⚠️⭐` 等图形字符代替图标
4. 禁止修改 icons-preview.html 中已有 SVG 的路径数据（只读）
5. 禁止给图标添加 `filter: drop-shadow`（会破坏极简风）
6. 禁止在同一按钮 / 菜单项同时放两个同类别图标（如"主图标 + 箭头"外另加装饰性图标）

---

## 七、Icon Tile 使用指南

> Icon Tile 是新风格的核心视觉元素，用于入口卡、任务卡、模块首页的主操作。

```
┌──────────────────────────┐
│  ┌──┐                    │
│  │🗹│ 考生入口            │  ← 56×56 Tile + 大标题
│  └──┘                    │
│                          │
│  进入考生签到抽签流程       │
│                          │
│  [考生入口 · CANDIDATE]  ←  胶囊标签        [→]
└──────────────────────────┘
```

| 要素 | 规格 |
|------|------|
| Tile 尺寸 | 56×56（入口）/ 44×44（子模块）|
| Tile 圆角 | 14px (md) |
| Tile 底色 | Primary/Accent 100 系 |
| 图标尺寸 | 24~28px |
| 右上角箭头 | chevron-right 20px，默认 `--text-500`，hover 切主色 |
| 卡片 hover | Tile 底色加深一档（100 → 50 反转），卡片 translateY(-2px) |
| 激活态 | Tile 底色反转为 600 色，图标变白 |

---

## 八、图标兜底映射

若业务中暂缺 SVG，临时可用以下兜底（最终必须替换为 SVG）：

| 语义 | 临时文字兜底 | 最终图标名 |
|------|------------|-----------|
| 添加 | — | `plus` |
| 删除 | — | `trash` |
| 关闭 | — | `x-mark` |
| 展开 | — | `chevron-down` |
| 收起 | — | `chevron-up` |
| 进入 | — | `chevron-right` |
| 返回 | — | `arrow-left` |

**注意**：兜底文字字符**禁止**出现在交付物中，仅作为占位，最终必须替换为从 icons-preview.html 提取的 SVG。
