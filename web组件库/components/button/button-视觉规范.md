---
name: 按钮 Button（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows,spacing}.md
---

# 按钮 Button（新风格）

> 主按钮用主色实色填充；默认圆角 6px（SM 4px / LG 8px），克制利落；CTA 变体保留尾部箭头；尺寸默认 40px。

---

## 一、按钮种类 Types

| 种类 | 说明 | 适用场景 |
|------|------|---------|
| Primary（填充主要） | 主色实色 | 表单提交、确认 |
| CTA（实色 + 箭头） | 主色实色填充 + 尾部箭头 | 登录 / 进入 / 关键流程推进 |
| Secondary（浅色填充） | `--primary-50` 底 + 主色文字 | 次要主操作、副 CTA |
| Outline（描边） | 白底 + 1px `--border-strong` | 取消、返回 |
| Danger（危险填充） | `--danger-500` 底 | 删除、重置 |
| Success（成功填充） | `--accent-green-600` 底 | 通过、完成 |
| Ghost（幽灵） | 透明底 + `--text-700` | 工具栏、弱操作 |
| Text（文字按钮） | 无背景、无边框 | 链接、更多操作、表格内联操作 |

---

## 二、尺寸 Sizes

| 尺寸 | 高度 | 水平 padding | 字号 | 圆角 |
|------|------|-------------|------|------|
| SM | 32px | 14px | 12 / 18 Semibold | 4px |
| Default | 40px | 18px | 14 / 22 Semibold | 6px |
| LG | 48px | 22px | 16 / 24 Semibold | 8px |

胶囊场景使用 `--r-pill`（999px）。

---

## 三、主题与状态矩阵

### 3.1 Primary

| 状态 | 背景 | 文字 | 备注 |
|------|------|------|------|
| 默认 | `--primary-600` | `#FFF` | 可选加 `--shadow-btn-primary` |
| Hover | `filter: brightness(1.05)` | `#FFF` | 叠加 `--shadow-btn-hover` |
| Active | `--primary-700` | `#FFF` | `transform: scale(.98)` |
| Disabled | `--primary-300` | `rgba(255,255,255,.8)` | `cursor: not-allowed` |

### 3.2 CTA（实色 + 尾部箭头）

| 状态 | 背景 |
|------|------|
| 默认 | `--primary-600` + `--shadow-btn-primary` |
| Hover | `--primary-500` + `--shadow-btn-hover` |
| Active | `--primary-700` |
| Disabled | `--primary-300` |

**尾部箭头**：默认渲染 `→` 对应 SVG `chevron-right`，尺寸与字号同色，距文字 8px。

### 3.3 Secondary

| 状态 | 背景 | 文字 |
|------|------|------|
| 默认 | `--primary-50` | `--primary-600` |
| Hover | `--primary-100` | `--primary-700` |
| Active | `--primary-100` | `--primary-700` |
| Disabled | `#F1F5F9` | `--text-400` |

### 3.4 Outline

| 状态 | 边框 | 背景 | 文字 |
|------|------|------|------|
| 默认 | 1px `--border-strong` | `#FFF` | `--text-700` |
| Hover | 1px `--primary-600` | `#FFF` | `--primary-600` |
| Active | 1px `--primary-700` | `--primary-50` | `--primary-700` |
| Disabled | 1px `--border` | `#FFF` | `--text-400` |

### 3.5 Danger / Success

沿用 Primary 矩阵，将 `--primary-*` 替换为：
- Danger：`--danger-500 / --danger-400 / --danger-600 / --danger-300`
- Success：`--accent-green-600 / --accent-green-500 / --accent-green-700 / --accent-green-300`

### 3.6 Ghost

| 状态 | 背景 | 文字 |
|------|------|------|
| 默认 | transparent | `--text-700` |
| Hover | `--fill-hover` | `--text-900` |
| Active | `--fill-active` | `--text-900` |
| Disabled | transparent | `--text-400` |

### 3.7 Text

| 状态 | 文字 |
|------|------|
| 默认 | `--primary-600` |
| Hover | `--primary-700` + 下划线 |
| Active | `--primary-700` |
| Disabled | `--text-400` |

---

## 四、Focus Ring

所有按钮在键盘聚焦时显示 focus ring：

```css
:focus-visible {
  outline: none;
  box-shadow: var(--shadow-focus-ring);
}
```

---

## 五、图标按钮

| 图标位置 | 规则 |
|----------|------|
| 前置图标 | 图标在文字左侧，间距 8px |
| 后置图标 | 图标在文字右侧，间距 8px（CTA 箭头即此类）|
| 纯图标 | 正方形：SM 32×32 / Default 40×40 / LG 48×48 |

图标尺寸：
- SM：16 × 16
- Default：20 × 20
- LG：24 × 24

---

## 六、按钮组

| 属性 | 值 |
|------|-----|
| 按钮间距 | 8px (xs) |
| 主操作位置 | 右侧 |
| 一组内主按钮数量 | ≤ 1 |
| 对齐（弹窗底部）| 右对齐 |
| 对齐（页面工具栏）| 左对齐 |

---

## 七、交互动效

```css
button {
  transition: all .2s cubic-bezier(.4,0,.2,1);
}
button:active {
  transform: scale(.98);
  transition-duration: .1s;
}
```

---

## 八、CSS 变量汇总

```css
:root[data-theme="new-style"] {
  --btn-h-sm: 32px;
  --btn-h-md: 40px;
  --btn-h-lg: 48px;

  --btn-px-sm: 14px;
  --btn-px-md: 18px;
  --btn-px-lg: 22px;

  --btn-radius: var(--r-control); /* 6px */
  --btn-pill-radius: 999px;
  --btn-icon-gap: 8px;
  --btn-group-gap: 8px;

  --btn-primary-bg:       var(--primary-600);
  --btn-primary-bg-hover: var(--primary-500);
  --btn-primary-bg-active: var(--primary-700);
  --btn-primary-bg-disabled: var(--primary-300);

  --btn-cta-bg:           var(--primary-600);
  --btn-cta-bg-hover:     var(--primary-500);
  --btn-cta-bg-active:    var(--primary-700);
  --btn-cta-shadow:       var(--shadow-btn-primary);
  --btn-cta-shadow-hover: var(--shadow-btn-hover);

  --btn-secondary-bg:       var(--primary-50);
  --btn-secondary-bg-hover: var(--primary-100);
  --btn-secondary-text:     var(--primary-600);

  --btn-outline-border: var(--border-strong);
  --btn-outline-text:   var(--text-700);

  --btn-danger-bg:  var(--danger-500);
  --btn-success-bg: var(--accent-green-600);

  --btn-ghost-bg-hover: var(--fill-hover);
  --btn-text-color:     var(--primary-600);
}
```

---

## 九、与旧规范的主要差异

| 维度 | 旧 | 新 |
|------|----|----|
| 默认高度 | 32px | 40px |
| 圆角 | 4px | 4px（克制利落） |
| 填充主色 | `#2378FA` 实色 | `#155CCB` 实色（含 CTA） |
| 次要按钮 | 白底 + 灰边 | `--primary-50` 底 + 主色文字 |
| Hover 反馈 | `brightness` | `brightness` + 主色外阴影 |
| Active 反馈 | 颜色加深 | 颜色加深 + `scale(.98)` |
| 箭头暗示 | 无 | CTA 尾部固定箭头 |

---

## 十、使用指南

| 场景 | 推荐 |
|------|------|
| 登录 / 进入面试 | CTA（实色 + 箭头）+ LG 尺寸 |
| 表单确认 | Primary + Default |
| 表单取消 | Outline + Default |
| 删除数据 | Danger + SM |
| 批量操作 | Secondary + Default |
| 表格行内操作 | Text + SM |
| 顶栏图标操作 | Ghost + 纯图标（32×32）|
