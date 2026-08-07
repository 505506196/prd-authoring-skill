---
name: 布局规范（新风格）
category: foundations
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
---

# 布局规范（新风格）

> 融合版（社考克制形态）：标准后台使用白色顶栏和侧栏，页面底色为 `#F8FAFC`；聚焦型业务详情可使用主色实色 AppBar。网格只用于登录/品牌页。

---

## 一、页面骨架

### 1.1 通用管理后台

```
┌────────────────────────────────────────────────────────────────┐
│  顶栏 Topbar  64px（实底白 + 极细底边）                                 │
├──────────┬─────────────────────────────────────────────────────┤
│          │                                                     │
│  侧栏     │        主内容区                                      │
│  240px   │        padding: 32px                                 │
│ 实底白   │                                                     │
│          │                                                     │
└──────────┴─────────────────────────────────────────────────────┘
```

### 1.2 登录页

```
┌───────────────────────────┬─────────────────────────┐
│  Hero 渐变 + 网格         │   白色登录面板           │
│  40×40 Tile + 大标题      │   欢迎登录 / 副标题      │
│  (第二行主色渐变)         │   账号输入                │
│  描述段 + 插画             │   密码输入                │
│                           │   主按钮 →                │
│                           │   Footer 版权             │
└───────────────────────────┴─────────────────────────┘
```

### 1.3 任务列表 / 入口页

- 顶部右侧胶囊：头像 + 用户名 + 退出
- 中心：Display 标题 + 说明
- 下方：Feature Card 网格（图标 Tile + 标题 + 描述 + 胶囊标签 + 角落箭头）

### 1.4 业务详情页（带顶蓝条）

```
┌────────────────────────────────────────────────────────────────┐
│ 蓝条 AppBar  64px (实色主色 --primary-600)                            │
│ ← 面包屑/标题 ……… [已抽记录] [时间 chip] [用户头像 chip]          │
├────────────────────────────────────────────────────────────────┤
│                                                                │
│                   中心聚焦单一任务                                │
│                   图 / 标题 / 说明 / 主 CTA                       │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

---

## 二、尺寸

| 区域 | 尺寸 |
|------|------|
| 顶栏 Topbar（标准） | 高度 64px |
| 顶栏 AppBar（业务蓝条） | 高度 64px |
| 侧栏 Sidebar（展开） | 宽度 240px |
| 侧栏 Sidebar（折叠） | 宽度 64px |
| 内容区上下 padding | 32px |
| 内容区左右 padding | 后台 24px；门户/文档 32px |
| Section 最大宽度 | 1400px |
| 登录面板宽度 | 440px |
| Hero 左右比例 | 55% / 45% |

---

## 三、侧栏 Sidebar

社考克制形态：**实底白 + 右边框**（不用玻璃态/blur）：

```css
.sidebar {
  background: var(--surface);
  border-right: 1px solid var(--border);
  width: 240px;
}
```

### 3.1 菜单项

| 属性 | 值 |
|------|-----|
| padding | 10px 16px |
| border-radius | 4px (sm) |
| 默认文字色 | `--text-700` |
| hover 背景 | `--fill-hover` |
| 激活背景 | `--primary-50` |
| 激活文字 | `--primary-600` |
| 激活字重 | 600 |
| 激活指示条 | 左侧 3px 主色，高度铺满菜单项 |

### 3.2 分组标题

| 属性 | 值 |
|------|-----|
| font | 12 / 600 |
| color | `--text-400` |
| letter-spacing | 0.08em |
| text-transform | uppercase |
| padding | 8px 16px |

---

## 四、顶栏 Topbar

### 4.1 普通顶栏（管理后台）

| 属性 | 值 |
|------|-----|
| height | 64px |
| background | `var(--surface)`（实底白） |
| border-bottom | 1px solid `--border` |
| box-shadow | `--shadow-topbar` |

结构：`[Logo] [Title] ……… [Search] ……… [Version / Avatar / Logout]`

### 4.2 业务 AppBar（实色蓝条）

| 属性 | 值 |
|------|-----|
| height | 64px |
| background | `var(--primary-600)`（实色主色，非渐变） |
| color | `#FFFFFF` |
| 左侧返回按钮 | 40×40 圆形，`rgba(255,255,255,.14)` 半透明 |
| 右侧胶囊操作 | `rgba(255,255,255,.14)` 底 + 白文字 + `--r-pill` |

---

## 五、栅格

### 5.1 基数

- 基数：8px
- 所有间距从 `spacing.md` 的阶梯中取值

### 5.2 卡片网格

| 场景 | 列数 | gap |
|------|------|-----|
| Feature Card（入口）| 1~3 列响应式 | 24px |
| 任务卡 | 2~4 列 | 20px |
| 统计卡 | 4 列 | 16px |
| 表单分组卡 | 1~2 列 | 24px |

---

## 六、断点 Breakpoints

| 断点 | 宽度 | 场景 |
|------|------|------|
| sm | ≥ 640px | 小屏（信息展示） |
| md | ≥ 768px | 平板 |
| lg | ≥ 1024px | 桌面（主要目标） |
| xl | ≥ 1280px | 大桌面 |
| 2xl | ≥ 1536px | 超大桌面 |

**本组件库聚焦桌面端**（lg 以上），移动端适配由产品单独定义。

---

## 七、Z-index 层级

| 层级 | 值 | 用途 |
|------|-----|------|
| z-base | 0 | 默认 |
| z-sticky | 100 | 表头粘性、侧栏 |
| z-topbar | 200 | 顶栏 |
| z-dropdown | 1000 | Select / Dropdown |
| z-tooltip | 1100 | Tooltip |
| z-popover | 1200 | Popconfirm |
| z-drawer | 1300 | Drawer |
| z-dialog | 1400 | Dialog |
| z-toast | 1500 | Toast / Notification |
| z-max | 9999 | Loading 全屏 |

---

## 八、CSS 变量汇总

```css
:root[data-theme="new-style"] {
  --layout-topbar-h: 64px;
  --layout-appbar-h: 64px;
  --layout-sidebar-w: 240px;
  --layout-sidebar-collapsed-w: 64px;
  --layout-content-px: 32px;
  --layout-content-py: 32px;
  --layout-section-max: 1400px;

  --z-base:     0;
  --z-sticky:   100;
  --z-topbar:   200;
  --z-dropdown: 1000;
  --z-tooltip:  1100;
  --z-popover:  1200;
  --z-drawer:   1300;
  --z-dialog:   1400;
  --z-toast:    1500;
  --z-max:      9999;
}
```
