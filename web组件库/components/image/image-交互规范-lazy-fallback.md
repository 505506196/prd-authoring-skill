---
name: 图片交互规范 — 懒加载 / 失败占位 / 渐显
category: interaction
scene: lazy-fallback
status: stable
component: image
paired-with: ../../image.md
applies-to: 所有 Image / Avatar 组件（含表格内小图、卡片大图、英雄区图片、头像群组）
---

# 图片交互规范 — 懒加载 / 加载失败占位 / 渐显切换 / 头像群组

> **本文件解决「页面初始加载图片过多卡顿」「图片加载失败显示破图」「真实图替换骨架时跳变」三类问题。**
>
> 视觉规范见 [`../../image.md`](../../image.md)。

---

## 一、设计目标

| 目标 | 表现 |
|------|------|
| **懒加载** | 视口外图片不加载，首屏更快 |
| **失败有兜底** | 加载失败显示规范的错误占位 + 文案 |
| **切换平滑** | 骨架到真实图渐显过渡 |
| **头像兜底** | 头像加载失败 / 无图时显示首字母 |

---

## 二、懒加载

### 2.1 触发

| 触发方式 | 行为 |
|---------|------|
| 默认 | 使用 `loading="lazy"`（浏览器原生）|
| 进阶（视口预加载）| IntersectionObserver 监听，距离视口 200px 时触发加载 |

### 2.2 不应懒加载的场景

| 场景 | 原因 |
|------|------|
| 首屏 LCP 关键图（如英雄图、产品大图）| 影响 Largest Contentful Paint，必须立即加载 |
| 头像图标（极小尺寸）| 立即加载成本低于占位 |
| 列表前 3 项缩略图 | 可见即加载 |

> 业务方对首屏图明确加 `priority` 标记，跳过懒加载。

### 2.3 占位

- 懒加载未触发时显示 Skeleton（参考 image.md 第二节）
- 占位尺寸必须与真实图等大，避免触发后 layout shift

---

## 三、加载状态切换

### 3.1 三种状态

| 状态 | 视觉 |
|------|------|
| loading | Skeleton 渐变（参考 loading.md 第二节）|
| loaded | 真实图片 |
| error | 错误占位（image-off 图标 + 文案） |

### 3.2 状态机

```
初始 → loading
  ├─ image.onload → loaded
  └─ image.onerror → error
```

### 3.3 渐显动画

```css
img.loaded {
  animation: fade-in .3s ease;
}
@keyframes fade-in {
  from { opacity: 0; transform: scale(.98); }
  to { opacity: 1; transform: scale(1); }
}
```

- 持续 300ms ease
- 同时 Skeleton fadeOut 200ms 重叠
- 不允许"砰"一下出现

### 3.4 缓存图（已加载过）

- 浏览器缓存命中时不显示 Skeleton（避免画蛇添足）
- 检测：`img.complete && img.naturalHeight !== 0`
- 缓存命中跳过渐显动画

---

## 四、错误态

### 4.1 触发

- `image.onerror` 触发
- 资源 404、CORS 错误、超时（默认 10s）

### 4.2 视觉（参考 image.md 第三节）

| 元素 | 规则 |
|------|------|
| 容器尺寸 | 与原图占位一致 |
| 背景 | `--surface-muted` |
| 边框 | 1px dashed `--border-strong` |
| 图标 | `image-off` 24px，`--text-400`，居中 |
| 文案 | "图片加载失败" 12/18，`--text-500`，距图标 8px |

### 4.3 重试

| 触发 | 行为 |
|------|------|
| 业务方启用 retry=true | 错误态显示"重试"链接，点击重新加载 |
| 默认 | 不显示重试（避免重复请求资源不存在的图）|

### 4.4 业务自定义占位

- 业务方可传入 `fallbackSrc` 替换默认错误占位
- fallbackSrc 同样适用 onerror（如 fallbackSrc 也加载失败，进入默认错误态）

---

## 五、object-fit 与对齐

### 5.1 推荐值

| 场景 | object-fit |
|------|-----------|
| 头像 | `cover` |
| 缩略图 | `cover` |
| 卡片大图 | `cover`（默认）/ `contain`（显示完整图）|
| 英雄区 | `cover` |
| 商品详情 | `contain`（不裁切）|

### 5.2 居中

- 默认 `object-position: center`
- 业务方可配置 `top` / `bottom` 等（如人物半身像通常 `top` 避免裁掉脸）

---

## 六、头像 Avatar 变体

### 6.1 加载失败 / 无 src 时的兜底

| 兜底优先级 | 内容 |
|----------|------|
| 1 | 真实图 |
| 2 | 业务方提供的 fallbackSrc |
| 3 | 用户名首字母（参考 image.md 第五节）|
| 4 | 默认用户图标 |

### 6.2 首字母规则

| 维度 | 规则 |
|------|------|
| 字符数 | 中文 1 字（取姓氏），英文 1–2 字（取首字母）|
| 颜色 | 主色背景 `--primary-100` + `--primary-600` 文字 |
| 字号 | 按头像尺寸规则（参考 image.md 第五节）|
| 字重 | Semibold |

### 6.3 头像群组

| 元素 | 规则 |
|------|------|
| 错位间距 | -8px（左右重叠 8px）|
| zIndex | 从右向左递减（最右侧最高，避免遮挡）|
| 边框 | 2px `#FFF`（避免与下层叠色）|
| 超出 N 个 | 最后一个显示 "+N" |

#### "+N" 视觉

- 背景：`--text-100`
- 文字：`--text-700`
- 字重：Semibold
- hover 显示 Tooltip 列出所有未显示用户

---

## 七、点击放大（与 ImagePreview 联动）

### 7.1 触发

| 配置 | 行为 |
|------|------|
| 业务方启用 `previewable=true` | 鼠标 hover 显示放大镜图标 + cursor: zoom-in |
| 点击图片 | 打开 ImagePreview 全屏预览 |

### 7.2 与 ImagePreview 集成

- 图片所在的图组（如商品多图）作为预览数据
- 默认从被点击的图开始
- 详见 [`../../image-preview/interaction/zoom-pan.md`](../../image-preview/interaction/zoom-pan.md)

---

## 八、性能与优化

### 8.1 多分辨率（响应式）

```html
<img srcset="small.jpg 480w, medium.jpg 768w, large.jpg 1200w"
     sizes="(max-width: 480px) 100vw, 50vw"
     src="medium.jpg" />
```

- 业务方可启用 srcset，组件透传
- 减少移动端流量

### 8.2 WebP / AVIF

- 业务方可提供 WebP / AVIF 路径，浏览器优先选择
- 不支持的浏览器回退到 JPG / PNG

### 8.3 不缓存策略

- 头像图（用户上传）建议加版本号查询参数（`?v=timestamp`）
- 避免用户改头像后还看到旧图

---

## 九、自检清单

- [ ] 默认使用 `loading="lazy"`
- [ ] 首屏 LCP 关键图加 priority 标记跳过懒加载
- [ ] 占位尺寸与真实图等大（无 layout shift）
- [ ] loading 显示 Skeleton（参考 image.md）
- [ ] loaded 渐显 300ms（cache 命中跳过）
- [ ] error 显示规范的错误占位 + 文案
- [ ] 业务方 fallbackSrc 失败时进入默认错误态
- [ ] 头像无图时显示首字母（中文取姓氏，英文取首字母）
- [ ] 头像群组错位 -8px，zIndex 从右向左递减
- [ ] 头像群组"+N" hover 显示 Tooltip 列表
- [ ] previewable=true 时 hover 显示放大镜图标
- [ ] srcset 响应式正确（业务方启用时）

---

## 十、不适用场景

- **SVG 矢量图**：直接用 `<svg>` 内联，不走 Image 组件
- **背景图**：用 CSS `background-image` + 业务方控制
- **视频缩略图**：用专门的 VideoPreview 组件
- **动态生成内容（如 canvas / chart）**：不在本规范范围内
