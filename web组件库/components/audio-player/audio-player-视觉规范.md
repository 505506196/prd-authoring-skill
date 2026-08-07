---
name: 音频播放器 AudioPlayer（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows}.md
---

# 音频播放器 AudioPlayer（新风格）

> 波形可视化 + 圆形播放按钮 + 进度条 + 时间码。主色渐变填充波形；背景 8px 圆角卡片。

---

## 一、容器

| 属性 | 值 |
|------|-----|
| 背景 | `#FFF` |
| 圆角 | 8px |
| 边框 | 1px `--border` |
| padding | 12px 16px |
| 高度 | 64px（紧凑）/ 80px（默认）/ 120px（展开，带波形）|
| 阴影 | `--shadow-card` |

---

## 二、播放按钮

| 属性 | 值 |
|------|-----|
| 尺寸 | 40×40（紧凑）/ 48×48（默认）|
| 形状 | 圆形（`--r-pill`）|
| 背景 | `linear-gradient(135deg, #155CCB, #1E6AE0)` |
| 阴影 | `--shadow-btn-primary` |
| 图标 | `play` / `pause` 20px，白色 |
| Hover | 整体 `scale(1.05)` + 阴影加深 |
| Loading | 替换图标为白色 spinner |

---

## 三、波形 Waveform

| 属性 | 值 |
|------|-----|
| 柱宽 | 3px |
| 柱间距 | 2px |
| 最低高度 | 4px |
| 最高高度 | 32px（随容器高度缩放）|
| 未播放柱色 | `--border-strong`（`#CBD5E1`）|
| 已播放柱色 | `--primary-600` |
| Hover 前瞻色 | `--primary-400` |
| 圆角 | 1.5px |
| 交互 | 点击定位 + 拖拽预览 |

---

## 四、纯进度条变体（无波形）

| 属性 | 值 |
|------|-----|
| 高度 | 4px |
| 圆角 | 999px |
| 轨道背景 | `--border-soft` |
| 已播放 | `linear-gradient(90deg, #155CCB, #4A8AEF)` |
| 缓冲（可选）| `--primary-200`，半透明 |
| 滑块 | 12px 圆，`--primary-600` |

---

## 五、时间码

| 元素 | 规格 |
|------|------|
| 当前时间 / 总时长 | 12 / 18 Medium，`tabular-nums` |
| 当前时间色 | `--text-900` |
| 总时长色 | `--text-500` |
| 位置 | 进度条右侧 8px |

---

## 六、次要操作

| 操作 | 图标 | 尺寸 | 位置 |
|------|------|------|------|
| 音量 | `volume-2` / `volume-x` | 20px | 播放按钮右侧 |
| 倍速 | 文字 `1.0x` | — | 右侧 |
| 下载 | `download` | 20px | 右侧 |
| 收藏 | `star` | 20px | 右侧 |

---

## 七、错误态

| 元素 | 规格 |
|------|------|
| 背景 | `--danger-100` |
| 边框 | 1px `--danger-500` |
| 图标 | `alert-circle` 20px，`--danger-600` |
| 文案 | `音频加载失败`，14/22，`--danger-600` |
| 重试按钮 | Text Primary SM |

---

## 八、录音态（额外）

| 元素 | 规格 |
|------|------|
| 指示灯 | 8px 圆 `--danger-500`，`animation: pulse 1s infinite` |
| 波形 | 实时绘制，每 60ms 采样 1 柱 |
| 计时 | `00:00` 红色 Mono |
| 停止按钮 | 红色圆形（同播放按钮结构，主色换 danger）|

---

## 九、CSS 变量

```css
:root[data-theme="new-style"] {
  --ap-container-bg: #FFFFFF;
  --ap-container-radius: 8px;
  --ap-container-padding: 12px 16px;
  --ap-container-h-default: 80px;
  --ap-container-shadow: var(--shadow-card);

  --ap-play-size: 48px;
  --ap-play-bg: linear-gradient(135deg, #155CCB, #1E6AE0);
  --ap-play-shadow: var(--shadow-btn-primary);
  --ap-play-icon-color: #FFFFFF;

  --ap-wave-bar-w: 3px;
  --ap-wave-bar-gap: 2px;
  --ap-wave-bar-min-h: 4px;
  --ap-wave-color-unplayed: var(--border-strong);
  --ap-wave-color-played: var(--primary-600);
  --ap-wave-radius: 1.5px;

  --ap-progress-h: 4px;
  --ap-progress-bg: var(--border-soft);
  --ap-progress-fill: linear-gradient(90deg, #155CCB, #4A8AEF);

  --ap-time-font: 12px/18px 500;
  --ap-time-current: var(--text-900);
  --ap-time-total: var(--text-500);
}
```
