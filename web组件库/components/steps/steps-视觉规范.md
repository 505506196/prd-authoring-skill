---
name: 步骤条 Steps（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius}.md
---

# 步骤条 Steps（新风格）

> 圆形节点 + 主色高亮；完成态填充，进行中描边 + 内实心点，未开始浅灰；连接线 2px。

---

## 一、节点

| 尺寸 | 直径 | 字号（数字）|
|------|------|-------------|
| SM | 24px | 12 / 18 Semibold |
| Default | 32px | 14 / 22 Semibold |
| LG | 40px | 16 / 24 Semibold |

### 1.1 状态

| 状态 | 背景 | 边框 | 内容 | 文字色 |
|------|------|------|------|--------|
| 未开始 | `#FFF` | 2px `--border` | 数字 | `--text-500` |
| 进行中 | `#FFF` | 2px `--primary-600` | 8px 实心圆 `--primary-600`（或数字）| `--primary-600` |
| 已完成 | `--primary-600` | 无 | `check` 图标白色 | — |
| 错误 | `--danger-500` | 无 | `x-mark` 图标白色 | — |
| 禁用 | `#F1F5F9` | 2px `--border-soft` | 数字 | `--text-400` |

---

## 二、文字标题

| 元素 | 默认 | 进行中 | 已完成 | 错误 |
|------|------|--------|--------|------|
| 标题（16/24）| `--text-500` | `--text-900` Semibold | `--text-900` Regular | `--danger-600` Semibold |
| 说明（12/18）| `--text-400` | `--text-500` | `--text-500` | `--danger-500` |

---

## 三、连接线

| 属性 | 值 |
|------|-----|
| 厚度 | 2px |
| 颜色（已完成段）| `--primary-600` |
| 颜色（未完成段）| `--border` |
| 对齐 | 节点中心水平 / 垂直 |

---

## 四、布局

### 4.1 水平 Horizontal

```
① ─────── ② ─────── ③ ─────── ④
标题      标题      标题      标题
说明      说明      说明      说明
```

- 节点与文字间距 12px
- 节点与连接线连续
- 项宽度自适应 or 平均分布

### 4.2 垂直 Vertical

```
①  标题
│  说明
②  标题
│  说明
```

- 项上下间距 24px
- 连接线宽 2px，高度自适应文字区域

### 4.3 Dot 迷你版

| 属性 | 值 |
|------|-----|
| 节点尺寸 | 8px |
| 连接线 | 1px |
| 仅显示节点 + 标题（行内）|

---

## 五、可点击

已完成步骤默认可点击返回修改：
- Hover：节点描边加深主色 300 光环；标题主色
- Active：节点缩小 `scale(.96)`

---

## 六、CSS 变量

```css
:root[data-theme="new-style"] {
  --step-size-sm: 24px;
  --step-size-md: 32px;
  --step-size-lg: 40px;

  --step-border: 2px solid var(--border);
  --step-border-active: 2px solid var(--primary-600);
  --step-bg-done: var(--primary-600);
  --step-bg-error: var(--danger-500);

  --step-text-default: var(--text-500);
  --step-text-active: var(--text-900);
  --step-text-active-weight: 600;

  --step-line-h: 2px;
  --step-line-done: var(--primary-600);
  --step-line-todo: var(--border);

  --step-gap: 12px;
}
```
