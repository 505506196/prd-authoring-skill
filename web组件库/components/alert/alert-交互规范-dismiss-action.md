---
name: 警告提示交互规范 — 关闭 / 操作 / 自动隐藏 / Banner
category: interaction
scene: dismiss-action
status: stable
component: alert
paired-with: ../../alert.md
applies-to: 所有 Alert（Info / Success / Warning / Danger / Banner）
---

# 警告提示交互规范 — 关闭 / 操作链接 / 自动消失 / Banner 堆叠

> **本文件解决「关闭后用户记忆消失」「操作链接没有 hover 反馈」「Banner 与页面布局冲突」三类问题。**
>
> 视觉规范见 [`../../alert.md`](../../alert.md)。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **可关闭可记忆** | 关闭后通过 localStorage 记住用户偏好，下次不再展示 |
| **操作可达** | 操作链接 / 按钮独立 Tab 顺序 |
| **不阻断布局** | Banner 自动占位推开下方内容，不浮动 |
| **可重新唤起** | 业务方可程序化重新显示已被关闭的 Alert |

---

## 二、关闭交互

### 2.1 关闭按钮显示规则

| 配置 | 是否显示 |
|------|---------|
| 默认 | 不显示（持久 Alert）|
| `closable=true` | 显示 |
| Banner 类型 | 推荐显示（用户读完后可关闭）|

### 2.2 关闭动画

```css
@keyframes alert-collapse {
  from { opacity: 1; max-height: 200px; padding: 14px 18px; }
  to { opacity: 0; max-height: 0; padding: 0 18px; }
}
```

- 持续 250ms cubic-bezier(.4,0,.2,1)
- 同时下方内容上移填空（参与 max-height 过渡）

### 2.3 关闭记忆

| 场景 | 行为 |
|------|------|
| Alert 设置 `dismissKey="xxx"` | 关闭后写入 localStorage，相同 key 下次进页面不再显示 |
| 无 dismissKey | 关闭仅当前会话有效，刷新页面后重现 |
| 业务清除记忆 | 调用 `Alert.resetDismissed("xxx")` 重置 |

> 关键场景：版本更新公告、新功能引导。用户读过一次后不再打扰。

---

## 三、操作链接 / 按钮

### 3.1 位置

参考 alert.md 第四节"带操作"变体：
- 描述下方右对齐
- 与描述间距 12px
- 按钮组间距 8px

### 3.2 可访问性

- 操作按钮独立 Tab 顺序
- Focus Ring 显示 `0 0 0 4px rgba(21,92,203,.15)`
- Aria：`role="alert"` + 按钮的 aria-label

### 3.3 按钮种类

| 场景 | 推荐按钮 |
|------|---------|
| 主要操作（如"立即升级"）| Text Primary 或 Secondary |
| 次要操作（如"了解详情"）| Text |
| 不可逆操作 | Outline 或 Danger（少见，通常 Alert 不放危险操作）|

### 3.4 跳转 vs 内联

| 操作类型 | 实现 |
|---------|------|
| 内联操作（如"忽略"）| 调用业务回调 |
| 跳转操作（如"查看详情"）| 默认新标签页打开（`target="_blank"`），避免跳走当前页面正在做的事 |

---

## 四、自动消失（默认不消失）

### 4.1 默认行为

> Alert 与 Toast 的核心差异：**Alert 默认不自动消失**。

| 类型 | 是否自动消失 |
|------|-----------|
| Info / Success / Warning / Danger | 默认 **不**自动消失 |
| 业务方启用 `autoClose=N` | N 秒后关闭 |

### 4.2 与 Toast 的区分

- 临时反馈（保存成功 / 删除成功）→ Toast
- 持久信息（系统公告 / 表单错误汇总）→ Alert
- **不允许将 Alert 用于临时反馈**

---

## 五、Banner 类型

### 5.1 适用场景

- 页面顶部全局公告（系统维护通知 / 版本更新 / 重要提示）
- 跨页面持久显示
- 宽度 100% 铺满容器

### 5.2 与 Layout 的关系

| 维度 | 规则 |
|------|------|
| 位置 | 通常在 AppBar 下方、内容区上方 |
| 宽度 | 100%（铺满父容器）|
| 圆角 | **0**（不延续 alert.md 的 8px，因为是边到边）|
| 左条 | 仍保留 4px 主题色条 |
| 内边距 | 上下 12px，左右与内容区 padding 对齐 |

### 5.3 多 Banner 堆叠

| 场景 | 行为 |
|------|------|
| 同时有多个 Banner | 按优先级垂直堆叠（Danger > Warning > Info > Success）|
| 同优先级多 Banner | 按入场顺序堆叠 |
| 关闭一条 | 下方 Banner 上移 250ms |

---

## 六、与表单错误汇总集成

### 6.1 表单提交失败的 Alert

```
┃ ⚠️ 表单填写有误，请检查以下问题：
┃    • 邮箱格式不正确
┃    • 密码长度不能少于 8 位
┃    [前往第一个错误]
```

### 6.2 行为

| 元素 | 规则 |
|------|------|
| 显示位置 | 表单顶部 |
| 内容 | 列出所有错误字段（不超过 5 项，超过显示"等 N 个错误"）|
| "前往第一个错误"按钮 | 点击滚动到第一个错误字段 + 聚焦 |
| 字段修正后 | 该错误从列表中移除 |
| 全部修正 | Alert 自动消失（淡出 250ms）|

### 6.3 错误聚焦

- 滚动 `behavior: "smooth"`
- 错误字段进入视口后立即聚焦
- 距视口顶部留出 88px 空间（避开 AppBar）

---

## 七、键盘交互

| 按键 | 行为 |
|------|------|
| Tab | 进入 Alert 内的关闭按钮 / 操作按钮 |
| Enter | 触发当前聚焦按钮 |
| Esc（焦点在 Alert 内时）| 触发关闭（如有 closable）|

---

## 八、与 Dialog / Drawer 内的 Alert

### 8.1 嵌入场景

- Dialog / Drawer 内可放 Alert 强调重要信息
- Alert 视觉沿用主规范，圆角保留 8px

### 8.2 与遮罩交互

- Alert 不影响 Dialog 的 focus trap
- Alert 内按钮可被 Dialog 的 Tab 循环捕获

---

## 九、自检清单

- [ ] 默认不显示关闭按钮，closable=true 才显示
- [ ] 关闭动画 250ms collapse
- [ ] dismissKey 关闭后 localStorage 记忆，刷新不重现
- [ ] 业务可调用 resetDismissed 重置
- [ ] 操作按钮独立 Tab 顺序，Focus Ring 可见
- [ ] 跳转操作默认新标签页打开
- [ ] 默认不自动消失，autoClose=N 秒后关闭
- [ ] Banner 圆角 0，宽度 100%
- [ ] 多 Banner 按优先级堆叠
- [ ] 表单错误 Alert 列出错误字段，不超过 5 项
- [ ] "前往第一个错误"按钮 smooth 滚动 + 聚焦
- [ ] 字段修正后从错误列表移除
- [ ] Esc 关闭可关闭的 Alert

---

## 十、不适用场景

- **临时反馈（保存成功 / 删除成功）**：用 Toast / Notification
- **需要确认的危险操作**：用 Dialog 二次确认
- **行内字段错误**：用 Form 字段下方的内联错误，不用 Alert
- **超过 200 字的内容**：拆分到详情页 + Alert 提示"查看详情"
