# CRUD 代码生成模板

## 模板用途

CRUD模板组用于快速生成完整的增删改查功能代码，包含后端Java代码和前端Vue代码。基于Spring Boot + MyBatis Plus + Vue3技术栈，可生成标准的RESTful API和对应的前端管理页面。

## 模板组成

### 后端模板
- **Controller.ftl**: RESTful API控制器，继承BaseController，使用@CrudRequestMapping注解配置API路径和功能
- **Service.ftl**: 业务接口，继承BaseService和IService，定义业务方法
- **ServiceImpl.ftl**: 业务实现类，继承BaseServiceImpl，实现具体业务逻辑
- **Mapper.ftl**: 数据访问接口，继承BaseMapper，提供基础CRUD方法
- **MapperXml.ftl**: MyBatis XML映射文件，包含自定义SQL查询
- **Entity.ftl**: 实体类，继承BaseDO，使用@TableName注解映射数据库表
- **Query.ftl**: 查询对象，用于接收前端查询条件，支持分页和排序
- **Req.ftl**: 请求对象，用于接收新增和修改请求的数据
- **Resp.ftl**: 列表响应对象，用于返回列表数据，包含用户信息字符串
- **DetailResp.ftl**: 详情响应对象，用于返回详情数据，包含完整字段信息
- **Menu.ftl**: 菜单配置SQL，用于生成系统菜单和权限配置

### 前端模板
- **api.ftl**: TypeScript接口定义和HTTP请求函数，包含所有CRUD操作的API调用
- **index.ftl**: 列表页面组件，包含查询表单、数据表格、分页组件和操作按钮
- **AddModal.ftl**: 新增/编辑模态框组件，支持动态表单渲染和数据验证
- **DetailDrawer.ftl**: 详情抽屉组件，以只读模式展示数据详情

## 使用参数

### 必需参数
- `packageName`: 项目根包名（如：com.air.order）
- `classNamePrefix`: 实体类命名前缀（如：Order）
- `businessName`: 业务名称中文（如：订单）
- `apiModuleName`: API模块名（如：system）
- `apiName`: API名称（如：order）
- `tableName`: 数据库表名（如：t_order）
- `author`: 作者名称
- `datetime`: 创建日期时间

### 字段配置
- `fieldConfigs`: 字段配置列表，每个字段包含：
  - `fieldName`: 字段名
  - `fieldType`: 字段类型
  - `comment`: 字段注释
  - `showInList`: 是否在列表中显示
  - `showInQuery`: 是否在查询中显示
  - `formType`: 表单控件类型（INPUT、SELECT、DATE等）
  - `dictCode`: 字典代码（可选）

## 使用说明

使用模板时需要提供以下参数：

1. **基本参数**：项目包名、类名前缀、业务名称等基本信息
2. **API参数**：API模块名和API名称，用于生成接口路径
3. **数据库参数**：数据库表名，用于生成实体映射
4. **字段配置**：每个字段的名称、类型、注释、显示属性和表单控件类型
5. **作者信息**：作者名称和创建时间

字段配置支持多种表单控件类型：INPUT（输入框）、SELECT（下拉框）、DATE（日期选择）、RADIO（单选框）等，并可配置字典代码用于下拉选项。

## 生成效果

使用这些模板可以生成完整的CRUD功能代码：

### 后端生成内容
- **控制器层**：提供RESTful API接口，包括分页查询、详情查询、新增、修改、删除、批量删除、数据导出和字典查询接口
- **服务层**：业务接口和实现类，继承BaseService，提供基础CRUD业务逻辑
- **数据访问层**：Mapper接口和XML映射文件，支持自定义SQL查询
- **实体层**：实体类继承BaseDO，包含审计字段，支持MyBatis Plus注解
- **数据传输对象**：查询对象、请求对象、列表响应对象、详情响应对象

### 前端生成内容
- **API接口层**：TypeScript接口定义和HTTP请求函数，与后端API完全对应
- **页面视图**：列表页面包含查询表单、数据表格、操作按钮，支持分页、排序、筛选
- **表单组件**：新增/编辑模态框，支持多种表单控件类型和数据验证
- **详情组件**：抽屉式详情展示，支持只读模式的数据查看
- **权限控制**：集成权限验证，根据用户权限显示/隐藏操作按钮

### 功能特性
- 支持多种字段类型和表单控件
- 支持字典数据联动
- 支持日期范围查询
- 支持数据导出功能
- 响应式设计，适配移动端
- 完整的增删改查操作流程

## 技术栈

- 后端: Spring Boot + MyBatis Plus + MySQL/PostgreSQL
- 前端: Vue 3 + TypeScript + Arco Design

## 注意事项

### 代码生成规范
1. **严格遵循模板结构**：生成代码时必须严格按照模板文件的结构和格式，不得随意添加或删除模板中定义的代码块
2. **保持注解完整性**：模板中的所有注解（如@Service、@RestController、@CrudRequestMapping等）必须完整保留，不得遗漏
3. **继承关系不可变更**：生成的类必须按照模板定义的继承关系（如Controller继承BaseController，Entity继承BaseDO等）
4. **导入语句保持一致**：模板中定义的import语句必须完整保留，不得随意添加或删除

### 参数使用规范
1. **字段配置必须完整**：每个字段的fieldConfigs配置必须包含所有必要属性（fieldName、fieldType、comment等）
2. **布尔类型参数正确使用**：hasTimeField、hasBigDecimalField等布尔参数必须根据实际字段情况准确设置
3. **字典字段处理**：使用字典的字段必须正确配置dictCode，并在前端模板中正确引用
4. **API路径规范**：apiModuleName和apiName参数必须与实际项目中的路由配置保持一致

### 前端代码注意事项
1. **组件引用路径**：生成的import语句路径必须与项目实际文件结构匹配
2. **权限标识符**：权限标识符格式必须为`${apiModuleName}:${apiName}:操作类型`，不得随意更改
3. **表单控件类型**：formType必须使用模板中预定义的类型（INPUT、SELECT、DATE、DATE_TIME、RADIO等）
4. **字典数据引用**：字典数据引用方式必须与项目中useDict hook的使用方式一致

### 后端代码注意事项
1. **MyBatis Plus配置**：实体类的@TableName注解值必须与数据库表名完全一致
2. **接口路径规范**：@CrudRequestMapping中的value值必须与前端API调用路径一致
3. **方法签名保持**：Service接口中的方法签名必须与BaseService中定义的方法签名一致
4. **SQL文件位置**：MapperXml.ftl生成的XML文件必须放在resources/mapper目录下

### 常见错误避免
1. **不要添加自定义业务逻辑**：模板生成的代码只包含基础CRUD功能，不要在生成时添加复杂的业务逻辑
2. **不要修改模板结构**：不要改变模板中定义的类结构、方法签名或文件组织方式
3. **不要遗漏审计字段**：BaseDO中包含的审计字段（id、createTime、updateTime等）必须在实体中保留
4. **不要混淆响应对象**：Resp用于列表响应，DetailResp用于详情响应，不要混用

### 生成后处理
1. **数据库表验证**：生成代码前必须确认数据库表结构与字段配置一致
2. **字典数据准备**：使用字典字段的业务，必须提前在系统中配置相应的字典数据
3. **路由菜单配置**：生成的前端页面需要手动配置路由和菜单
4. **权限配置**：需要在权限系统中配置相应的功能权限
