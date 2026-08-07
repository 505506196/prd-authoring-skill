---
name: 上传 Upload（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows}.md
---

# 上传 Upload（新风格）

> 三种形态：按钮 Button / 拖拽区 DragZone / 图片上传 Picture-Card。圆角紧凑；支持进度条与错误态。

---

## 一、按钮 Button 形态

最简形态：复用 Button 规范，附加上传语义。

| 常见变体 | 按钮 | 图标 |
|---------|------|------|
| 主操作上传 | Primary Default | `upload` 16px 前缀 |
| 次要上传 | Outline | `upload` |
| 仅图标上传 | Ghost 纯图标 | `paperclip` |

文字通常为：`选择文件` / `上传附件` / `导入数据`。

---

## 二、拖拽区 DragZone

```
┌────────────────────────────────────┐
│                                    │
│       ⬆ 拖拽文件到此或点击选择        │
│       支持 PDF / JPG / PNG (≤ 10M)  │
│                                    │
└────────────────────────────────────┘
```

| 属性 | 值 |
|------|-----|
| 宽度 | 100%（可配置固定）|
| 最小高度 | 160px |
| 背景 | `--surface-muted`（`#F1F5F9`）|
| 边框 | 1px dashed `--border-strong` |
| 圆角 | 8px |
| 主文案 | 14 / 22 Semibold，`--text-900` |
| 副文案 | 12 / 18 Regular，`--text-500` |
| 图标 | 40px `cloud-upload`，`--primary-600` |
| 图标与文字间距 | 12px |

### 2.1 状态

| 状态 | 边框 | 背景 |
|------|------|------|
| 默认 | 1px dashed `--border-strong` | `--surface-muted` |
| Hover | 1px dashed `--primary-500` | `--primary-50` |
| Dragover | 2px dashed `--primary-600` | `--primary-50` |
| 禁用 | 1px dashed `--border` | `#F1F5F9` |
| 错误 | 1px dashed `--danger-500` | `--danger-100` |

---

## 三、图片卡 Picture-Card

| 属性 | 值 |
|------|-----|
| 卡片尺寸 | 120×120（可配置）|
| 圆角 | 8px |
| 背景 | `--surface-muted` |
| 边框 | 1px dashed `--border-strong` |
| 添加图标 | `plus` 24px，`--text-500` |
| 已上传图片 | 对象适配 cover + 圆角继承 |

### 3.1 悬浮遮罩

已上传图片 hover：
- 半透明黑遮罩 `rgba(15,23,42,.48)`
- 白色图标按钮组：预览 `eye` / 下载 `download` / 删除 `trash`
- 按钮间距 12px

---

## 四、文件列表（上传后）

| 元素 | 规格 |
|------|------|
| 列表项高 | 48px |
| 列表项 padding | 12px 16px |
| 列表项圆角 | 4px |
| 列表项边框 | 1px `--border-soft` |
| 文件图标 | 24px，按类型色板 |
| 文件名 | 14 / 22 Regular，`--text-900`，ellipsis |
| 文件大小 | 12 / 18 Regular，`--text-500` |
| 进度条 | 4px 高，主色渐变 |
| 操作按钮 | `x-mark` 16px，Hover 红 |

### 4.1 状态

| 状态 | 左侧图标色 | 文件名色 | 备注 |
|------|----------|--------|------|
| 上传中 | `--primary-600` | `--text-900` | 右侧 Progress Line SM |
| 成功 | `--accent-green-600` | `--text-900` | 右侧 `check-circle` 16px |
| 失败 | `--danger-500` | `--danger-600` | 右侧 `alert-circle` + 重试 |

---

## 五、限制

| 属性 | 默认 |
|------|-----|
| 最大文件数 | 无限（可配置 `maxCount`）|
| 单文件最大 | 10MB（可配置）|
| 格式限制 | `accept="..."` 属性传入 |
| 超限提示 | Message Danger |

---

## 六、CSS 变量

```css
:root[data-theme="new-style"] {
  --upload-drag-min-h: 160px;
  --upload-drag-radius: 8px;
  --upload-drag-bg: var(--surface-muted);
  --upload-drag-border: 1px dashed var(--border-strong);
  --upload-drag-border-hover: 1px dashed var(--primary-500);
  --upload-drag-border-active: 2px dashed var(--primary-600);

  --upload-card-size: 120px;
  --upload-card-radius: 8px;

  --upload-list-item-h: 48px;
  --upload-list-item-radius: 4px;
  --upload-list-progress-h: 4px;
}
```
