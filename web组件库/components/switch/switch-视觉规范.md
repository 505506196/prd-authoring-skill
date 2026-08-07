---
name: 开关 Switch（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,radius,shadows}.md
---

# 开关 Switch（新风格）

> 圆角 999px 胶囊轨道 + 白色圆形滑块；选中态主色填充；滑动过渡 200ms。

---

## 一、尺寸

| 尺寸 | 轨道 W × H | 滑块 | 滑块偏移 | 字号（辅助标签）|
|------|----------|------|---------|----------------|
| SM | 32 × 18 | 14 × 14 | 2px | 12 / 18 |
| Default | 44 × 24 | 20 × 20 | 2px | 14 / 22 |
| LG | 56 × 32 | 28 × 28 | 2px | 16 / 24 |

---

## 二、状态

### 2.1 关闭 Off

| 属性 | 值 |
|------|-----|
| 轨道背景 | `--border-strong`（`#CBD5E1`）|
| 滑块背景 | `#FFF` |
| 滑块阴影 | `0 1px 2px rgba(15,23,42,.15)` |
| 滑块位置 | 左 |

### 2.2 开启 On

| 属性 | 值 |
|------|-----|
| 轨道背景 | `--primary-600` |
| 滑块背景 | `#FFF` |
| 滑块位置 | 右 |

### 2.3 Hover

| 状态 | 轨道 |
|------|------|
| Off + Hover | `--text-500` |
| On + Hover | `--primary-500` |

### 2.4 Focus

外环 `0 0 0 4px rgba(21,92,203,.15)`。

### 2.5 禁用

| 状态 | 轨道 | 滑块 | 透明度 |
|------|------|------|--------|
| Off Disabled | `--border` | `#F1F5F9` | 0.6 |
| On Disabled | `--primary-300` | `#F1F5F9` | 0.6 |

---

## 三、Loading 态

切换中：滑块上显示 12×12 spinner（主色），禁用点击直到 loading 结束。

---

## 四、Switch + Label

| 布局 | 规则 |
|------|------|
| 标签在左 | Switch 与标签间距 8px；标签 14/22 Regular |
| 标签在右 | 同上 |
| 内部文字（Switch 内部 ON/OFF）| 仅 LG 尺寸支持；文字 11/16 Medium，白色，居中 |

---

## 五、CSS 变量

```css
:root[data-theme="new-style"] {
  --switch-w-sm: 32px;
  --switch-h-sm: 18px;
  --switch-w-md: 44px;
  --switch-h-md: 24px;
  --switch-w-lg: 56px;
  --switch-h-lg: 32px;

  --switch-track-off: var(--border-strong);
  --switch-track-off-hover: var(--text-500);
  --switch-track-on: var(--primary-600);
  --switch-track-on-hover: var(--primary-500);
  --switch-track-off-disabled: var(--border);
  --switch-track-on-disabled: var(--primary-300);

  --switch-thumb: #FFFFFF;
  --switch-thumb-shadow: 0 1px 2px rgba(15,23,42,.15);
  --switch-transition: 200ms cubic-bezier(.4,0,.2,1);
}
```
