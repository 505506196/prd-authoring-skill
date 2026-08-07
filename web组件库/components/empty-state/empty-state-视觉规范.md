---
name: 空状态 Empty State（新风格）
category: components
status: draft
style: new-style
source: 智慧化面试签到抽签系统 UI 设计规范 v1.0（2026-04-16）
depends: foundations/{colors,typography,radius}.md
---

# 空状态 Empty State（新风格）

> 列表 / 搜索 / 权限 / 失败四类空态。统一插画 + 主文案 + 副文案 + 主操作按钮。

---

## 一、结构

```
        ┌──────┐
        │ ILLU │        ← 180×180 / 120×120 插画
        └──────┘

         暂无数据                  ← 主文案 16 / 24 Semibold
         快来创建你的第一条记录吧    ← 副文案 14 / 22 Regular

           [ + 新建 ]              ← 主操作 Primary MD
```

---

## 二、尺寸档

| 档位 | 插画 | 主文案 | 副文案 | 容器最小高 |
|------|------|--------|--------|----------|
| LG（全页）| 240×240 | 20/28 Semibold | 14/22 | 480px |
| Default（列表内）| 180×180 | 18/28 Semibold | 14/22 | 320px |
| SM（紧凑）| 120×120 | 16/24 Semibold | 12/18 | 200px |

---

## 三、文案配色

| 元素 | 颜色 |
|------|------|
| 主文案 | `--text-900` |
| 副文案 | `--text-500` |
| 主操作 | Primary 主色 |
| 次操作 | Text Primary 链接 |

---

## 四、类型与插画

| 类型 | 插画主题 | 主文案 | 典型操作 |
|------|---------|--------|---------|
| 空列表 | 空文件夹 / 占位框 | 暂无数据 | 新建 / 导入 |
| 搜索无结果 | 放大镜 | 未找到相关内容 | 清空筛选 |
| 无权限 | 锁图 | 您没有访问此内容的权限 | 联系管理员 |
| 加载失败 | 错误图 | 加载失败 | 重试 |
| 网络错误 | 断网图 | 网络异常 | 刷新 |
| 404 | 404 图 | 页面不存在 | 返回首页 |

---

## 五、插画规则

| 属性 | 值 |
|------|-----|
| 风格 | 扁平 + 浅蓝（主色 50/100）+ 白色 + 主色点缀 |
| 格式 | SVG 内联 |
| 禁用 | emoji / 3D 插画 / 写实图 |

---

## 六、CSS 变量

```css
:root[data-theme="new-style"] {
  --empty-illus-lg: 240px;
  --empty-illus-md: 180px;
  --empty-illus-sm: 120px;

  --empty-title-lg: 20px/28px 600;
  --empty-title-md: 18px/28px 600;
  --empty-title-sm: 16px/24px 600;
  --empty-title-color: var(--text-900);

  --empty-desc: 14px/22px 400;
  --empty-desc-sm: 12px/18px 400;
  --empty-desc-color: var(--text-500);

  --empty-title-desc-gap: 4px;
  --empty-illus-text-gap: 16px;
  --empty-text-action-gap: 20px;

  --empty-min-h-lg: 480px;
  --empty-min-h-md: 320px;
  --empty-min-h-sm: 200px;
}
```
