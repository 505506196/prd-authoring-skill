---
name: 数字输入框 InputNumber（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius}.md
---

# 数字输入框 InputNumber（新风格）

> 基于 Input，附带加减控制器。两种布局：外置（左右按钮）和内置（右侧堆叠上下）。

---

## 一、触发框

同 Input 规范：

| 尺寸 | 高度 | 圆角 |
|------|------|------|
| SM | 32px | 4px |
| Default | 44px | 6px |

- 字体 `tabular-nums`
- 文字对齐：输入区 `text-align: center`（外置）或 `left`（内置）

---

## 二、布局 1：外置按钮

```
┌────┬──────────┬────┐
│ −  │   100    │ +  │
└────┴──────────┴────┘
```

| 元素 | 规格 |
|------|------|
| 加减按钮 | 同输入框高度，宽度 40px（SM 32px）|
| 按钮背景（默认）| `--surface-muted` |
| 按钮背景（hover）| `--primary-50` |
| 按钮文字 | `--text-700`，hover `--primary-600` |
| 按钮图标 | `minus` / `plus` 16px |
| 按钮边 | 1px `--border` |
| 禁用时 | `--text-400` |

### 圆角

容器整体圆角 6px，减号按钮左上左下 6px，其他 0；加号按钮右上右下 6px；中间输入框无圆角。

---

## 三、布局 2：内置堆叠

```
┌──────────┬─┐
│   100    │▲│
│          │▼│
└──────────┴─┘
```

| 元素 | 规格 |
|------|------|
| 上下按钮 | 20×21px 堆叠（每个高 21），位于右侧 |
| 按钮背景 | 默认透明，Hover `--primary-50` |
| 按钮图标 | `chevron-up` / `chevron-down` 12px |
| 边框与输入共享 | 1px `--border` |

---

## 四、状态

与 Input 一致（默认 / Hover / Focus / Disabled / Error）。

---

## 五、精度 / 范围

| 属性 | 值 |
|------|-----|
| step | 1（默认，可配置 0.1、0.01 等）|
| min / max | 必填时输入超范围自动 clamp + 抖动红色提示 |
| 小数位 | 通过 `precision` 配置 |

---

## 六、交互

| 交互 | 行为 |
|------|------|
| 点击加减 | 按 step 增减 |
| 长按加减 | 每 150ms 触发一次 |
| 键盘 ↑/↓ | step 增减 |
| 键盘 PageUp/Down | 10×step 增减 |
| 超出范围 | Toast + 自动 clamp |

---

## 七、CSS 变量

```css
:root[data-theme="new-style"] {
  --inum-h-sm: 32px;
  --inum-h-md: 44px;
  --inum-radius: 6px;
  --inum-btn-w-md: 40px;
  --inum-btn-w-sm: 32px;

  --inum-btn-bg: var(--surface-muted);
  --inum-btn-bg-hover: var(--primary-50);
  --inum-btn-text: var(--text-700);
  --inum-btn-text-hover: var(--primary-600);

  --inum-inner-arrow-h: 21px;
  --inum-inner-arrow-w: 20px;
}
```
