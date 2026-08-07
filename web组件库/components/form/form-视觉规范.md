---
name: 表单 Form（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,spacing}.md
---

# 表单 Form（新风格）

> 规范表单布局、Label、帮助文本、必填标识、分组与校验反馈。视觉元素均复用 Input / Select / Checkbox 等原子组件。

---

## 一、布局 Layout

| 布局 | 说明 | 典型场景 |
|------|------|---------|
| Vertical（默认）| Label 在输入上方 | 注册、提交表单 |
| Horizontal | Label 在输入左侧 | 配置面板、筛选器 |
| Inline | 多项横向紧贴 | 工具栏筛选 |

### 1.1 Vertical

| 元素 | 间距 |
|------|------|
| Label 与输入 | 8px |
| 行与行 | 16px |
| 分组与分组 | 32px |

### 1.2 Horizontal

| 元素 | 规格 |
|------|-----|
| Label 宽度 | 固定 96 / 120 / 160px |
| Label 对齐 | 右对齐（默认）或左对齐 |
| Label 与输入 | 16px 水平间距 |
| 行高 | 44px（与输入一致）|

---

## 二、Label 标签

| 属性 | 值 |
|------|-----|
| 字号 | 14 / 22 Semibold |
| 颜色 | `--text-900` |
| 必填星号 | `*` 符号，`--danger-500`，距 Label 文字 4px |
| 可选标识 | `（选填）` 12 / 18 Regular，`--text-400` |
| 帮助图标（右侧）| `info-circle` 14px `--text-400`，hover Tooltip |

---

## 三、帮助文本 / 错误提示

| 元素 | 字号 / 颜色 |
|------|-----------|
| 帮助文本 | 12 / 18 Regular，`--text-500` |
| 错误提示 | 12 / 18 Regular，`--danger-600` |
| 距输入框下方 | 6px |

---

## 四、分组 Grouped

```
┌──────────────────────────────────┐
│  基本信息                          │  ← 分组标题
│  ────                              │
│  [Label] [Input]                  │
│  [Label] [Input]                  │
├──────────────────────────────────┤
│  附加信息                          │
│  [Label] [Input]                  │
└──────────────────────────────────┘
```

| 元素 | 规格 |
|------|-----|
| 分组标题 | 16 / 24 Semibold，`--text-900` |
| 分组下方分隔 | 1px `--border-soft`，距标题 12px |
| 分组上下间距 | 32px |
| 分组底色（可选）| `--surface-muted` |

---

## 五、底部操作区

| 属性 | 值 |
|------|-----|
| 对齐 | 右对齐（默认）或居中 |
| 按钮组合 | `[Outline 取消]` + `[Primary 提交]` |
| 按钮间距 | 8px |
| 与上方内容间距 | 24px |
| 顶部分隔（长表单）| 1px `--border-soft` |

---

## 六、校验反馈

| 时机 | 行为 |
|------|------|
| onBlur | 单字段校验格式 |
| onSubmit | 全局必填 + 业务规则 |
| onChange | 密码强度、字数限制等实时场景 |

错误态：
- 输入框 border `--danger-500`
- 错误提示显示在字段下方
- Label 不变色（避免视觉混乱）

---

## 七、禁用 / 只读态

| 态 | 输入框 | Label |
|---|--------|-------|
| 禁用 | 背景 `#F1F5F9`，文字 `--text-400` | `--text-500` |
| 只读 | 背景 `--surface-muted`，文字 `--text-700` | 同正常 |

---

## 八、CSS 变量

```css
:root[data-theme="new-style"] {
  --form-label-font: 14px/22px 600;
  --form-label-color: var(--text-900);
  --form-label-gap-v: 8px;
  --form-label-gap-h: 16px;
  --form-label-w-sm: 96px;
  --form-label-w-md: 120px;
  --form-label-w-lg: 160px;

  --form-required: var(--danger-500);
  --form-optional-text: var(--text-400);

  --form-help: 12px/18px 400;
  --form-help-color: var(--text-500);
  --form-help-gap: 6px;

  --form-error-color: var(--danger-600);

  --form-row-gap: 16px;
  --form-group-gap: 32px;
  --form-footer-gap: 24px;
  --form-button-gap: 8px;
}
```
