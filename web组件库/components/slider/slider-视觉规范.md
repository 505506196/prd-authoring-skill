---
name: 滑块 Slider（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius}.md
---

# 滑块 Slider（新风格）

> 轨道 8px；填充主色渐变；滑块 18px 圆 + 2px 白边 + focus 主色光圈；支持单值 / 范围 / 分档 / 带标签。

---

## 一、尺寸

| 尺寸 | 轨道高 | 滑块尺寸 |
|------|--------|---------|
| SM | 6px | 14px |
| Default | 8px | 18px |
| LG | 10px | 22px |

---

## 二、轨道

| 属性 | 值 |
|------|-----|
| 背景（未填充）| `--border` |
| 填充 | `linear-gradient(90deg, #155CCB, #4A8AEF)` |
| 100% 完成切换 | `--accent-green-600` 实色 |
| 圆角 | 999px |

---

## 三、滑块 Thumb

| 属性 | 值 |
|------|-----|
| 背景 | `#FFF` |
| 边框 | 2px `--primary-600` |
| 圆角 | 999px |
| 阴影（默认）| `0 1px 2px rgba(15,23,42,.10)` |
| Hover | `scale(1.08)` + 阴影加深 |
| Focus | `0 0 0 4px rgba(21,92,203,.15)` |
| Active | `scale(1.1)` |

---

## 四、气泡（值提示）

hover / drag 时显示气泡：

| 属性 | 值 |
|------|-----|
| 背景 | `rgba(15,23,42,.92)` |
| 文字 | `#FFF` |
| 字号 | 12 / 18 Medium |
| 圆角 | 8px |
| padding | 4px 8px |
| 位置 | 滑块上方 8px |
| 箭头 | 下指 6×6 三角 |

---

## 五、分档（Marks）

| 元素 | 规格 |
|------|------|
| 小刻度 | 2×10 圆角 1px `--border-strong`，居中 |
| 大刻度（含标签）| 2×14 圆角 1px `--primary-600` |
| 标签字号 | 12 / 18 Regular，`--text-500` |
| 标签位置 | 轨道下方 12px |
| 激活刻度文字 | `--primary-600` |

---

## 六、范围 Range

- 两个滑块，选中区域主色填充
- 两个滑块间距最小 = 1 step

---

## 七、禁用

| 属性 | 值 |
|------|-----|
| 轨道 | `--border-soft` |
| 填充 | `--primary-200` |
| 滑块 | `#F1F5F9` + 1px `--border` |
| 透明度 | 0.6 |

---

## 八、CSS 变量

```css
:root[data-theme="new-style"] {
  --sl-track-h-sm: 6px;
  --sl-track-h-md: 8px;
  --sl-track-h-lg: 10px;

  --sl-thumb-sm: 14px;
  --sl-thumb-md: 18px;
  --sl-thumb-lg: 22px;

  --sl-track-bg: var(--border);
  --sl-track-fill: linear-gradient(90deg, #155CCB, #4A8AEF);
  --sl-track-fill-done: var(--accent-green-600);
  --sl-track-radius: 999px;

  --sl-thumb-bg: #FFFFFF;
  --sl-thumb-border: 2px solid var(--primary-600);
  --sl-thumb-shadow: 0 1px 2px rgba(15,23,42,.10);

  --sl-tip-bg: rgba(15,23,42,.92);
  --sl-tip-text: #FFFFFF;
  --sl-tip-radius: 8px;
}
```
