---
name: 加载交互规范 — 显示时机 / 最小展示 / 骨架切换
category: interaction
scene: show-timing
status: stable
component: loading
paired-with: ../../loading.md
applies-to: 所有 Loading 形态（Spinner / Skeleton / Progress / 按钮 loading）
---

# 加载交互规范 — 显示时机 / 最小展示 / 骨架切换 / 进度上限

> **本文件解决「快接口闪一下 loading」「慢接口干等没反馈」「骨架与真实内容切换抖动」「进度永远卡 99%」四类问题。**
>
> 视觉规范见 [`../../loading.md`](../../loading.md)。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **不闪烁** | <300ms 接口不显示 loading |
| **不干等** | >300ms 必须显示 loading；>4s 必须升级为骨架 / 进度 |
| **切换平滑** | 骨架切真实内容时整体淡入，不允许"砰一下"出现 |
| **进度真实** | 不允许进度条永远停在 99% 不动 |

---

## 二、显示时机（防闪烁）

### 2.1 延迟显示

| 接口耗时 | Loading 表现 |
|---------|-------------|
| < 300ms | **不显示**（用户感知不到延迟）|
| 300ms–1s | 显示 Spinner |
| 1s–4s | 显示 Spinner + 文案"加载中…" |
| > 4s | 升级为骨架 / 进度条 |
| 超时（默认 30s）| 显示失败态 + 重试按钮 |

### 2.2 实现方式

```js
// 关键：setTimeout 300ms 才设置 loading=true
let timer = setTimeout(() => setLoading(true), 300);

await fetchData();

clearTimeout(timer);
setLoading(false);
```

### 2.3 最小展示时长

| 阶段 | 最小时长 |
|------|---------|
| Spinner 出现后 | 至少 200ms（避免一闪而过）|
| 骨架屏出现后 | 至少 400ms |

> 满足"延迟显示"和"最小展示"两个约束时，是先延迟 300ms，再显示至少 200ms，所以**最快接口下用户也不会看到 loading**。这是有意设计。

---

## 三、按钮 loading

### 3.1 触发

参考 [`../../button/interaction/loading-state.md`](../../button/interaction/loading-state.md) 第二节。

### 3.2 视觉

| 元素 | 规则 |
|------|------|
| 替换前置图标 | 用 Spinner 16/20/24px |
| 文字保留 | 不替换为"加载中…"（避免宽度跳变）|
| 透明度 | 0.7 |
| cursor | wait |

### 3.3 与 Form 集成

- 表单提交按钮的 loading 由表单接管
- 业务方不需要手动 setState

---

## 四、容器 loading

### 4.1 浮层 Spin（局部 loading）

| 触发 | 视觉 |
|------|------|
| 列表 / 卡片重新加载 | 容器内部叠加白色半透明遮罩 + Spinner + 文案 |
| 遮罩 | `rgba(255,255,255,.72)` + `backdrop-filter: blur(4px)`（参考 loading.md 1.1）|
| Spinner 大小 | Default 24px |
| 文案 | 14/22 Regular，`--text-700`，距 Spinner 12px 下方 |

### 4.2 全屏 Loading（页面级）

- 背景 `rgba(255,255,255,.85)`
- Spinner 居中 LG 32px
- 文案"加载中…" 14/22 Regular `--text-700`
- 仅用于路由切换 / 首次进入大量数据页面
- 业务方应优先使用骨架屏而非全屏 Spinner

---

## 五、骨架屏

### 5.1 骨架与真实结构的对应

- 骨架占位元素的尺寸 / 圆角 / 间距必须与真实内容**完全一致**
- 不允许"骨架 200px 高，真实内容 240px 高"导致切换抖动

### 5.2 切换动画

| 阶段 | 过渡 |
|------|------|
| 骨架显示 | 立即（接口耗时 >300ms 时显示）|
| 真实内容渲染前 | 骨架保持 |
| 切换瞬间 | 骨架 fadeOut 200ms + 真实内容 fadeIn 200ms（重叠）|

```css
.skeleton-wrap {
  transition: opacity .2s ease;
}
.skeleton-wrap.fade-out { opacity: 0; }
.real-content { animation: fadeIn .2s ease; }
```

### 5.3 复杂列表的骨架

| 列表类型 | 骨架数量 |
|---------|---------|
| 列表前 N 项明确（如手机端最多 5 条）| 渲染 5 条骨架 |
| 列表项数未知 | 渲染 3 条骨架（覆盖首屏即可）|
| 卡片网格 | 渲染 4–8 个骨架卡片，覆盖首屏 |

---

## 六、Progress 进度条

### 6.1 真实进度

| 数据来源 | 行为 |
|---------|------|
| 接口返回真实进度（如上传） | 直接绑定 |
| 业务无真实进度 | **禁止假进度**（不允许伪造一个 90% 让用户安心）|
| 长任务无真实进度 | 用 Spinner 而非 Progress |

### 6.2 上限处理

| 进度状态 | 视觉 |
|---------|------|
| 0–99% | 主色渐变填充 |
| 100% | 切换为 `--accent-green-600` 实色 + check 图标 + 文案"完成"（300ms 后淡出）|
| 失败 | 切换为 `--danger-500` + x 图标 + 文案"失败"+ 重试按钮 |

### 6.3 不允许卡 99%

- 接口未返回 100% 时，进度最多显示到 95%（保留余地）
- 接口返回完成时直接跳到 100% 切换为成功态
- 不允许停留在 99% 等待

---

## 七、Empty / Error 状态联动

### 7.1 加载完成后判定

```
loading 结束
  ├─ 数据为空 → 显示 EmptyState（参考 empty-state 交互规范）
  ├─ 数据正常 → 渲染列表
  └─ 接口报错 → 显示 ErrorState + 重试按钮
```

### 7.2 切换之间没有"白屏闪烁"

- 骨架直接 fade 切到 EmptyState 或 ErrorState
- 不允许中间出现纯白容器

---

## 八、文字 Loading（内联）

### 8.1 三点动画

```
"加载中" + 末尾 1–3 个点循环淡入
"加载中"      → 100ms
"加载中."     → 200ms
"加载中.."    → 300ms
"加载中..."   → 400ms
回到第一帧    → 500ms
```

- 适用于聊天消息流"对方正在输入"等场景
- 不要用于按钮内 loading（按钮用 Spinner）

---

## 九、自检清单

- [ ] <300ms 接口不显示 loading
- [ ] 300ms–1s 显示 Spinner
- [ ] >1s 显示 Spinner + 文案
- [ ] >4s 升级为骨架 / 进度条
- [ ] >30s 显示超时 + 重试
- [ ] Spinner 出现后至少展示 200ms
- [ ] 骨架占位与真实内容尺寸一致
- [ ] 骨架切真实内容时 fadeOut + fadeIn 200ms 重叠
- [ ] 列表骨架渲染 3–8 项覆盖首屏
- [ ] Progress 不假进度，无真实进度时用 Spinner
- [ ] Progress 不卡 99%，未到 100% 最多显示 95%
- [ ] 100% 后切换为成功色 + check
- [ ] 加载完成后正确路由到 Empty / Error / 数据
- [ ] 骨架切换无"白屏闪烁"中间态
- [ ] 文字 Loading 三点动画不用于按钮

---

## 十、不适用场景

- **静态资源 loading**（如图片）：使用 Image 组件自身的占位 / 错误态
- **流式响应**（如 ChatGPT 边输出边显示）：本规范不适用，应用流式 UI 模式
- **后台异步任务**（用户不需要等待）：用 Notification 推送结果，不显示 loading
