---
name: 输入框 Input（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows,spacing}.md
---

# 输入框 Input（新风格）

> 高度升到 44px；默认圆角 6px（SM 4 / LG 8）；登录场景专用 52px 大输入；Focus 态主色描边 + 外环光圈。

---

## 一、尺寸 Sizes

| 尺寸 | 高度 | 字号 | 圆角 | 水平 padding |
|------|------|------|------|--------------|
| SM | 32px | 12 / 18 Regular | 4px | 12px |
| Default | 44px | 14 / 22 Regular | 6px | 14px |
| LG（登录）| 52px | 16 / 24 Regular | 8px | 16px |

---

## 二、状态

| 状态 | 边框 | 背景 | 文字 | 说明 |
|------|------|------|------|------|
| 默认 | 1px `--border` | `#FFF` | `--text-900` | — |
| Hover | 1px `--primary-400` | `#FFF` | `--text-900` | — |
| Focus | 1px `--primary-600` | `#FFF` | `--text-900` | 叠加 `--shadow-focus-ring` |
| 错误 | 1px `--danger-500` | `#FFF` | `--text-900` | 下方显示错误文案 |
| 禁用 | 1px `--border` | `#F1F5F9` | `--text-400` | `cursor: not-allowed` |
| 只读 | 1px `--border-soft` | `--surface-muted` | `--text-700` | 无 hover 反馈 |

---

## 三、占位符 Placeholder

| 属性 | 值 |
|------|-----|
| color | `--text-400` |
| font | 同输入字号，Regular |

---

## 四、前后缀

### 4.1 前缀图标

| 属性 | 值 |
|------|-----|
| 尺寸 | 16px（SM / Default）/ 20px（LG）|
| 距左 padding | 14px |
| 与输入文字间距 | 8px |
| 默认色 | `--text-500` |
| Focus 态色 | `--primary-600` |

### 4.2 后缀

常见：清除按钮 `x-mark`、密码显隐 `eye` / `eye-off`、字数统计。

| 属性 | 值 |
|------|-----|
| 尺寸 | 16px |
| 距右 padding | 14px |
| 默认色 | `--text-400` |
| Hover 色 | `--text-700` |

---

## 五、标签 / 帮助文本 / 错误提示

```
┌──────────────────────────┐
│  Label *                 │  ← 14/22 Semibold，必填用 --danger-500 星号
│                          │
│  [ 输入框            ]   │
│                          │
│  帮助文本 / 错误提示       │  ← 12/18 Regular，错误态 --danger-600
└──────────────────────────┘
```

| 元素 | 字号 | 颜色 |
|------|------|------|
| Label | 14 / 22 Semibold | `--text-900` |
| 必填星号 | — | `--danger-500` |
| 帮助文本（提示）| 12 / 18 Regular | `--text-500` |
| 错误提示 | 12 / 18 Regular | `--danger-600` |
| 与输入框间距 | Label 与输入 `8px`；输入与提示 `6px` | — |

---

## 六、Textarea（多行）

| 属性 | 值 |
|------|-----|
| 最小高度 | 88px |
| padding | 12px 14px |
| resize | `vertical` |
| 字符计数 | 右下角 12 / 18，`--text-400`；超限 `--danger-500` |

---

## 七、CSS 变量

```css
:root[data-theme="new-style"] {
  --input-h-sm: 32px;
  --input-h-md: 44px;
  --input-h-lg: 52px;

  --input-radius: 6px;
  --input-radius-lg: 8px;
  --input-px: 14px;

  --input-border: var(--border);
  --input-border-hover: var(--primary-400);
  --input-border-focus: var(--primary-600);
  --input-border-error: var(--danger-500);

  --input-bg: #FFFFFF;
  --input-bg-disabled: #F1F5F9;
  --input-bg-readonly: var(--surface-muted);

  --input-text: var(--text-900);
  --input-placeholder: var(--text-400);

  --input-shadow-focus: var(--shadow-focus-ring);
}
```

---

## 八、与旧规范差异

| 维度 | 旧 | 新 |
|------|----|----|
| 默认高度 | 32px | 44px |
| 圆角 | 4px | 4px |
| Focus 反馈 | 蓝色边框 | 蓝色边框 + 主色外环 `0 0 0 4px` |
| Hover | 边框 `--color-primary-hover` | 边框 `--primary-400`（更柔）|
| Label 字重 | Regular | Semibold |
