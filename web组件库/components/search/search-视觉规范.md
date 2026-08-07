---
name: 搜索框 Search（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius,shadows}.md
---

# 搜索框 Search（新风格）

> 左前缀 `search` 图标；支持下拉联想 Suggestion；清除按钮按 hover 显隐；不使用旧规范的"右侧蓝色填充按钮"变体。

---

## 一、结构

```
┌─────────────────────────────────────────┐
│ 🔍  输入文字                        ✕  │
└─────────────────────────────────────────┘
                ↓
         ┌──────────────┐
         │ 建议项 1      │
         │ 建议项 2      │
         └──────────────┘
```

---

## 二、触发框

完全沿用 Input 规范：

| 尺寸 | 高度 | 圆角 | 水平 padding |
|------|------|------|--------------|
| SM | 32px | 4px | 12px |
| Default | 44px | 6px | 14px |
| LG | 52px | 8px | 16px |

### 2.1 前缀搜索图标

| 属性 | 值 |
|------|-----|
| 图标 | `search` 16px（SM/Default）/ 20px（LG）|
| 颜色 | `--text-500` |
| 距左 | 14px |
| 与文字间距 | 8px |

### 2.2 清除按钮

| 属性 | 值 |
|------|-----|
| 图标 | `x-circle-fill` 16px |
| 颜色 | `--text-400`，Hover `--text-700` |
| 显示规则 | 仅当 value 非空且触发框 hover/focus 时显示 |
| 距右 | 14px |

---

## 三、联想面板 Suggestion

与 Select Dropdown 样式一致：

| 属性 | 值 |
|------|-----|
| 圆角 | 8px |
| 阴影 | `--shadow-dropdown` |
| padding | 6px |
| 最大高度 | 360px |

### 3.1 联想项

| 属性 | 值 |
|------|-----|
| 高度 | 40px |
| 水平 padding | 12px |
| 字号 | 14 / 22 Regular |
| 关键字高亮 | `color: --primary-600; font-weight: 600;` |
| Hover | `--primary-50` 背景 |
| Empty 文案 | 12 / 18，`--text-500`，居中 |

---

## 四、尺寸变体

| 场景 | 尺寸 | 说明 |
|------|------|------|
| 顶部导航搜索 | Default 44px | 宽度 320~480px，圆角 6px |
| 页面内筛选搜索 | SM 32px | 贴合工具栏尺寸 |
| 登录页 / 独立搜索页 | LG 52px | 大输入 8px 圆角 |

---

## 五、交互规则

| 交互 | 行为 |
|------|------|
| 输入 | 触发联想请求（debounce 200ms）|
| 回车 | 执行搜索，面板关闭 |
| Esc | 清空联想面板 |
| 点击外部 | 面板关闭 |
| 点击清除按钮 | 清空输入，保持 focus |

---

## 六、CSS 变量

```css
:root[data-theme="new-style"] {
  --search-h-sm: 32px;
  --search-h-md: 44px;
  --search-h-lg: 52px;
  --search-radius: 6px;
  --search-radius-lg: 8px;

  --search-icon: var(--text-500);
  --search-icon-focus: var(--primary-600);

  --search-clear: var(--text-400);
  --search-clear-hover: var(--text-700);

  --search-suggest-radius: 8px;
  --search-suggest-shadow: var(--shadow-dropdown);
  --search-suggest-item-h: 40px;
  --search-suggest-item-bg-hover: var(--primary-50);
  --search-suggest-highlight: var(--primary-600);
}
```

---

## 七、与旧规范差异

| 维度 | 旧 | 新 |
|------|----|----|
| 右侧"搜索"按钮 | 支持填充蓝色按钮 | **不支持**；回车或防抖触发 |
| 圆角 | 4px | 4~8px |
| 联想面板阴影 | 单层黑色 | 双层 Slate |
| 关键字高亮 | 红色 | 主色 |
