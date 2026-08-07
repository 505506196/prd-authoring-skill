---
name: 标签 Tag（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,spacing}.md
---

# 标签 Tag（新风格）

> 状态 Tag 采用 4px 圆角加同族描边；可点击的 Checkable / Selection Tag 使用胶囊形。通过形状区分“只读状态”与“可交互筛选”。

---

## 一、结构

```
┌────────────────────────┐
│  [icon]  文字  [✕]    │  ← 可选前置图标 + 文字 + 可选关闭
└────────────────────────┘
```

---

## 二、尺寸 Sizes

| 尺寸 | 高度 | 字号 | 水平 padding | 图标尺寸 |
|------|------|------|--------------|---------|
| SM | 20px | 12 / 18 Medium | 8px | 12px |
| Default | 24px | 12 / 18 Medium | 10px | 14px |
| LG | 28px | 12 / 18 Medium | 14px | 16px |

静态状态 Tag：`--r-tag` / 4px；Checkable Tag：`--r-pill` / 999px。

---

## 三、主题色方案

### 3.1 Primary（主题色）

| 变体 | 背景 | 文字 | 边框 |
|------|------|------|------|
| Light（默认） | `--primary-50` | `--primary-600` | 1px `--primary-200` |
| Dark（反色） | `--primary-600` | `#FFF` | 无 |
| Outline | `#FFF` | `--primary-600` | 1px `--primary-600` |

### 3.2 Success

| 变体 | 背景 | 文字 | 边框 |
|------|------|------|------|
| Light | `--accent-green-100` | `--accent-green-800` | 1px `--accent-green-200` |
| Dark | `--accent-green-600` | `#FFF` | 无 |
| Outline | `#FFF` | `--accent-green-700` | 1px `--accent-green-600` |

### 3.3 Warning

| 变体 | 背景 | 文字 | 边框 |
|------|------|------|------|
| Light | `--warning-100` | `--warning-800` | 1px `--warning-200` |
| Dark | `--warning-500` | `#FFF` | 无 |
| Outline | `#FFF` | `--warning-800` | 1px `--warning-500` |

### 3.4 Danger

| 变体 | 背景 | 文字 | 边框 |
|------|------|------|------|
| Light | `--danger-100` | `--danger-800` | 1px `--danger-200` |
| Dark | `--danger-500` | `#FFF` | 无 |
| Outline | `#FFF` | `--danger-600` | 1px `--danger-500` |

### 3.5 Neutral（中性）

| 变体 | 背景 | 文字 | 边框 |
|------|------|------|------|
| Light | `#F1F5F9` | `--text-700` | 1px `--border` |
| Dark | `--text-700` | `#FFF` | 无 |
| Outline | `#FFF` | `--text-700` | 1px `--border-strong` |

---

## 四、可关闭 Tag

| 元素 | 规格 |
|------|------|
| 关闭图标 | x-mark 12px |
| 颜色 | 与文字同色，透明度 0.6 |
| Hover | 透明度 1.0 + 轻微放大 |
| 距文字 | 4px |
| 点击热区 | 覆盖整个关闭图标 + 4px 外扩 |

---

## 五、Checkable Tag（可选中 Tag）

常见于筛选场景。

| 状态 | 背景 | 文字 | 边框 |
|------|------|------|------|
| 未选 | `#FFF` | `--text-700` | 1px `--border` |
| Hover | `--primary-50` | `--primary-600` | 1px `--primary-300` |
| 已选 | `--primary-600` | `#FFF` | 无 |
| 禁用 | `#F1F5F9` | `--text-400` | 1px `--border-soft` |

---

## 六、使用指南

| 场景 | 推荐变体 |
|------|---------|
| 状态标识（进行中 / 已完成） | Light |
| 强调标识（重要 / 置顶） | Dark |
| 筛选器 Tag | Checkable |
| 入口卡底部"角色标签" | Light + SM |
| 表格行内状态列 | Light |
| 需要强调的类别 | Outline |

**不允许同一页面混用 Dark 与 Light 表达同一语义**，必须全站一致。

---

## 七、CSS 变量

```css
:root[data-theme="new-style"] {
  --tag-h-sm: 20px;
  --tag-h-md: 24px;
  --tag-h-lg: 28px;
  --tag-radius: var(--r-sm);
  --tag-gap: 4px;

  --tag-primary-bg:   var(--primary-50);
  --tag-primary-text: var(--primary-600);
  --tag-success-bg:   var(--accent-green-100);
  --tag-success-text: var(--accent-green-800);
  --tag-warning-bg:   var(--warning-100);
  --tag-warning-text: var(--warning-800);
  --tag-danger-bg:    var(--danger-100);
  --tag-danger-text:  var(--danger-800);
  --tag-neutral-bg:   #F1F5F9;
  --tag-neutral-text: var(--text-700);
}
```

---

## 八、与旧规范差异

| 维度 | 旧 | 新 |
|------|----|----|
| 圆角 | 语义不明确 | 状态 4px，可交互 999px |
| 尺寸 | 不统一 | SM 20 / MD 24 / LG 28 |
| 浅色变体字重 | Regular | Medium |
| 图标支持 | 可选 | 推荐（前置）|
| 功能色饱和度 | 深 | 浅底 + 深文（对比度≥4.5:1）|
