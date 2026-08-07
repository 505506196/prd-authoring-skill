---
name: 警告提示 Alert（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius}.md
---

# 警告提示 Alert（新风格）

> 页面内持久提示；浅底 + 左侧 4px 主题色条 + 主题图标。区别于 Toast / Notification（临时弹出）。

---

## 一、类型

| 类型 | 背景 | 左条 | 图标 | 标题色 | 描述色 |
|------|------|------|------|--------|--------|
| Info | `--primary-50` | `--primary-600` | `info-circle` | `--primary-700` | `--text-700` |
| Success | `--accent-green-100` | `--accent-green-600` | `check-circle` | `--accent-green-800` | `--text-700` |
| Warning | `--warning-100` | `--warning-500` | `alert-triangle` | `--warning-800` | `--text-700` |
| Danger | `--danger-100` | `--danger-500` | `alert-circle` | `--danger-800` | `--text-700` |

---

## 二、尺寸

| 尺寸 | padding | 图标 | 标题 | 描述 |
|------|---------|------|------|------|
| SM | 10px 14px | 16px | 12 / 18 Semibold | 12 / 18 Regular |
| Default | 14px 18px | 20px | 14 / 22 Semibold | 14 / 22 Regular |
| LG | 18px 22px | 24px | 16 / 24 Semibold | 14 / 22 Regular |

---

## 三、容器

| 属性 | 值 |
|------|-----|
| 圆角 | 8px |
| 左边条 | 4px，全高度 |
| 图标与文字间距 | 12px |
| 标题与描述间距 | 4px |
| Close 按钮 | 20×20，`x-mark` 14px，距右 14px |

---

## 四、变体

| 变体 | 说明 |
|------|------|
| 单行 | 仅标题 |
| 多行 | 标题 + 描述 |
| 带操作 | 描述下方右对齐 Text / Secondary 按钮组 |
| Banner | 宽度铺满容器，常用于页面顶部提示 |

---

## 五、交互

- 可关闭：右上角 `x-mark`
- 自动关闭：需配合 JS 倒计时；Alert 本身默认**不自动关闭**
- 操作按钮：使用 Text Primary / Secondary Primary

---

## 六、CSS 变量

```css
:root[data-theme="new-style"] {
  --alert-radius: 8px;
  --alert-bar-w: 4px;
  --alert-icon-gap: 12px;
  --alert-title-desc-gap: 4px;

  --alert-info-bg:    var(--primary-50);
  --alert-info-bar:   var(--primary-600);
  --alert-success-bg: var(--accent-green-100);
  --alert-success-bar: var(--accent-green-600);
  --alert-warning-bg: var(--warning-100);
  --alert-warning-bar: var(--warning-500);
  --alert-danger-bg:  var(--danger-100);
  --alert-danger-bar: var(--danger-500);
}
```
