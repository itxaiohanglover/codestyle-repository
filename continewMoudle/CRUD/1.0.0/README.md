# ContiNew Blank 代码生成模板

基于 ContiNew 框架的空白代码生成模板，用于快速生成标准化的前后端项目结构。

## 模板概述

本模板组包含完整的前后端代码生成模板，支持一键生成标准化的项目模块结构。

### 后端模块结构 (Backend)

```
backend/
└── src/
    └── main/
        ├── java/com/air/
        │   ├── controller/
        │   │   └── Controller.ftl          # 控制层模板 - 生成 RESTful API Controller
        │   ├── mapper/
        │   │   └── Mapper.ftl              # 数据访问层 Mapper 接口模板
        │   ├── model/
        │   │   ├── entity/
        │   │   │   └── Entity.ftl          # 实体类模板
        │   │   ├── query/
        │   │   │   └── Query.ftl           # 查询条件封装类模板
        │   │   ├── req/
        │   │   │   └── Req.ftl             # 请求参数封装类模板
        │   │   └── resp/
        │   │       ├── DetailResp.ftl      # 详情响应封装类模板
        │   │       └── Resp.ftl            # 响应结果封装类模板
        │   └── service/
        │       ├── impl/
        │       │   └── ServiceImpl.ftl     # 服务层实现模板
        │       └── Service.ftl             # 服务层接口模板
        └── resources/
            └── mapper/
                └── MapperXml.ftl           # MyBatis XML 映射文件模板
```

### 前端模块结构 (Frontend)

```
frontend/
└── src/
    ├── api/
    │   └── api.ftl                        # API 接口调用模板
    ├── components/
    │   ├── AddModal.ftl                   # 新增/编辑弹窗组件模板
    │   └── DetailDrawer.ftl               # 详情抽屉组件模板
    └── views/
        └── index.ftl                      # 列表页面模板 (Vue)
```

## 各文件作用说明

### 后端文件

| 模板文件 | 说明 |
|---------|------|
| Controller.ftl | 控制层模板，用于生成 RESTful API Controller，处理 HTTP 请求和响应 |
| Service.ftl | 服务层接口模板，定义业务逻辑接口 |
| ServiceImpl.ftl | 服务层实现模板，实现业务逻辑接口，调用数据访问层 |
| Mapper.ftl | 数据访问层 Mapper 接口模板，定义数据库操作方法 |
| MapperXml.ftl | MyBatis XML 映射文件模板，定义 SQL 语句和结果映射 |
| Entity.ftl | 实体类模板，映射数据库表结构 |
| Query.ftl | 查询条件封装类模板，封装列表查询的各种条件 |
| Req.ftl | 请求参数封装类模板，封装新增/编辑的请求参数 |
| Resp.ftl | 响应结果封装类模板，封装列表查询的响应结果 |
| DetailResp.ftl | 详情响应封装类模板，封装详情查询的响应结果 |

### 前端文件

| 模板文件 | 说明 |
|---------|------|
| api.ftl | API 接口调用模板，封装前端与后端的通信方法 |
| index.ftl | 列表页面模板，展示数据列表，支持查询、分页等功能 |
| AddModal.ftl | 新增/编辑弹窗组件模板，用于新增和修改数据 |
| DetailDrawer.ftl | 详情抽屉组件模板，用于展示数据详情 |

## 使用方法

1. 通过 `codestyleSearch` 工具搜索模板：
   - 关键词: Blank, 空白模板, 项目模板, continew

2. 通过 `getTemplateByPath` 获取具体模板内容，传入模板路径如：
   - `continew/Blank/1.0.0/backend/src/main/java/com/air/controller/Controller.ftl`
   - `continew/Blank/1.0.0/frontend/src/views/index.ftl`

## 模板变量说明

主要变量包括：
- `packageName`: 项目根包名 (如: com.air.order)
- `subPackageName`: 子包名 (如: controller)
- `classNamePrefix`: 实体类命名前缀 (如: Order)
- `className`: 类名 (如: OrderController)
- `businessName`: 业务名称中文 (如: 订单)
- `apiModuleName`: API模块名 (如: system)

## 适用场景

- Spring Boot 后端项目
- Vue 3 + TypeScript 前端项目
- MyBatis Plus 数据访问层
- ContiNew Admin 管理系统

## Logo信息

本项目使用的Logo遵循以下规范：
- 1:1比例，包含48X48、64X64尺寸
- Q版扁平化卡通风格
- 拟人化白色简历文档形象，带有纸张折角和"offer"头带
- 配色方案：蓝白红橙
- 纯白色背景
- 除"offer"文字外，无其他文字与水印