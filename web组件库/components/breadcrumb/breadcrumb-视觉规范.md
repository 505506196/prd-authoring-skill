---
name: 面包屑 Breadcrumb（新风格）
category: components
status: final
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）+ 业务受理学员端 PC 实践补充
depends: foundations/{colors,typography}.md
---

# 面包屑 Breadcrumb（新风格）

> 12 / 18 Regular；分隔符 `/`；最后一级固定为 `--text-900` Semibold。左侧带返回按钮 + 竖线分隔。

---

## 一、结构

```
← 返回  |  上级页面  /  当前页面
```

- 最左侧为返回按钮（`← 返回`），点击执行 `router.back()`
- 返回按钮与面包屑之间用 1px 竖线分隔
- 中间层级为链接（可点击跳转）
- 最后一级为当前页，不可点击

---

## 二、规格

| 属性 | 值 |
|------|-----|
| 字号 | 12px / 18px Regular |
| 返回按钮文字 | `--text-700`，hover `--primary-600` |
| 返回箭头 | chevron-left 14px SVG，stroke-width 2 |
| 竖线分隔 | 1px × 14px，`#E6E8EB` |
| 路径分隔符 | `/` 字符，`--text-400` |
| 链接文字 | `--text-500`，hover `--primary-600` |
| 当前页文字 | `--text-900` Semibold (600) |
| 各元素间距 | 8px |
| 组件高度 | 内容自适应（不设固定高度） |
| 单项最大宽度 | 160px，超出 ellipsis |

---

## 三、位置规范

| 属性 | 值 |
|------|-----|
| 位置 | 白色内容卡片**外部**顶部 |
| 水平对齐 | 与白色卡片左边缘对齐（同 max-width + padding-left） |
| 与卡片间距 | 12px（面包屑底部到白色卡片顶部） |
| 与顶栏间距 | 8px（顶栏底部到面包屑顶部） |

---

## 四、溢出处理

| 场景 | 处理 |
|------|------|
| 超过 4 级 | 中间折叠为 `...`，点击展开 popover 显示折叠层级 |
| 单项过长 | 最大宽度 160px，超出 ellipsis + tooltip |

---

## 五、CSS 变量

```css
:root[data-theme="new-style"] {
  --bc-font: 12px/18px 400;
  --bc-back-color: var(--text-700);
  --bc-back-hover: var(--primary-600);
  --bc-divider: #E6E8EB;
  --bc-divider-size: 1px 14px;
  --bc-sep: var(--text-400);
  --bc-link: var(--text-500);
  --bc-link-hover: var(--primary-600);
  --bc-current: var(--text-900);
  --bc-current-weight: 600;
  --bc-gap: 8px;
}
```

---

## 六、Props

| Prop | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| items | `Array<{label, path?}>` | 必填 | 面包屑层级数组，最后一项为当前页 |
| showBack | `boolean` | `true` | 是否显示返回按钮 |
