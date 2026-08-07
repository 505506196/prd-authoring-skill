---
name: 树形 Tree（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius}.md
---

# 树形 Tree（新风格）

> 层级缩进 20px；展开箭头 12px；节点 hover 浅主色；可嵌 Checkbox / 自定义图标。

---

## 一、节点 Node

| 属性 | 值 |
|------|-----|
| 高度 | 36px |
| 圆角 | 8px |
| 水平 padding | 8px |
| 缩进单位 | 20px（每一级向右 20px）|
| 字号 | 14 / 22 Regular |
| 文字色（默认）| `--text-700` |
| Hover 背景 | `--primary-50` |
| Hover 文字 | `--text-900` |
| 选中背景 | `--primary-50` |
| 选中文字 | `--primary-600` Semibold |
| 禁用文字 | `--text-400` |

### 1.1 展开 / 收起箭头

| 属性 | 值 |
|------|-----|
| 图标 | `chevron-right` 12px |
| 颜色 | `--text-400` |
| 大小热区 | 20×20 |
| 展开旋转 | 90° |
| 动画 | `transform .2s` |

叶子节点用点替代箭头位（6×6 `--text-300` 圆点）。

---

## 二、Checkbox Tree

| 状态 | 说明 |
|------|------|
| 未选 | 空 Checkbox |
| 已选 | 完整 Checkbox |
| 半选 | Indeterminate 横线 |

- 半选逻辑：部分子节点选中
- 父子联动：点父节点全选/全否所有子孙

### 2.1 Checkbox 与节点距离

8px 间距；Checkbox 垂直居中对齐节点文字中线。

---

## 三、自定义图标节点

| 属性 | 值 |
|------|-----|
| 节点图标 | 16px，`--text-500`，选中时 `--primary-600` |
| 文件夹图标 | `folder` / `folder-open` 切换 |
| 文件图标 | 按类型渲染 |

---

## 四、搜索与高亮

| 属性 | 值 |
|------|-----|
| 匹配关键字 | `background: rgba(21,92,203,.12); color: --primary-700;` |
| 自动展开 | 匹配到的节点路径全部展开 |
| 无匹配 | 显示"无匹配结果" Empty SM |

---

## 五、拖拽排序

| 属性 | 值 |
|------|-----|
| 拖拽手柄 | 节点左侧 `grip-vertical` 12px，默认隐藏，hover 显示 |
| 拖拽中 | 虚影 `opacity: .6` |
| 目标线 | 2px `--primary-600` 实线指示插入位置 |

---

## 六、CSS 变量

```css
:root[data-theme="new-style"] {
  --tree-h: 36px;
  --tree-radius: 8px;
  --tree-px: 8px;
  --tree-indent: 20px;
  --tree-font: 14px/22px 400;

  --tree-text: var(--text-700);
  --tree-bg-hover: var(--primary-50);
  --tree-text-hover: var(--text-900);
  --tree-bg-selected: var(--primary-50);
  --tree-text-selected: var(--primary-600);
  --tree-text-selected-weight: 600;

  --tree-arrow-size: 12px;
  --tree-arrow-hit: 20px;
  --tree-arrow-color: var(--text-400);
  --tree-cb-gap: 8px;
}
```
