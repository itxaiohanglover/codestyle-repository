# 数据库配置模板

## 模板用途

数据库配置模板用于生成Spring Boot项目的数据库配置文件，支持MySQL和PostgreSQL两种数据库。模板包含主配置文件、数据库专属配置片段和Maven依赖配置，可快速搭建项目的数据库环境。

## 模板组成

### 主配置文件
- **application.yml.ftl**: Spring Boot主配置文件，包含项目基础配置和数据库核心配置，根据数据库类型动态选择驱动类

### 数据库专属配置
- **mysql/db-config-snippet.yml.ftl**: MySQL数据库专属配置，包含连接池参数和MyBatis Plus方言配置
- **postgresql/db-config-snippet.yml.ftl**: PostgreSQL数据库专属配置，包含连接池参数和MyBatis Plus方言配置

### 依赖配置
- **pom-dependency-snippet.ftl**: Maven依赖片段，包含数据库驱动和HikariCP连接池依赖

## 使用参数

### 必需参数
- `dbType`: 数据库类型，可选值为`mysql`或`postgresql`
- `dbUrl`: 数据库连接地址，完整的JDBC URL
- `dbUsername`: 数据库用户名
- `dbPassword`: 数据库密码
- `progectName`: 项目名称，用于Spring应用名称配置

## 使用说明

### 数据库连接URL格式
- **MySQL**: `jdbc:mysql://localhost:3306/database_name?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8`
- **PostgreSQL**: `jdbc:postgresql://localhost:5432/database_name`

### 配置文件生成流程
1. 根据dbType参数选择对应的数据库驱动类
2. 使用include指令引入对应数据库的专属配置片段
3. 生成完整的application.yml配置文件
4. 根据数据库类型生成对应的Maven依赖片段

## 生成效果

### 主配置文件内容
- Spring应用名称配置
- 数据源类型配置（HikariDataSource）
- 数据库驱动类名（根据数据库类型动态选择）
- 数据库连接URL、用户名、密码
- 数据库专属配置片段（通过include引入）

### MySQL专属配置
- 连接池参数：最小空闲连接数5，最大连接数20
- 连接超时设置：连接超时30秒，空闲超时5分钟
- 连接生命周期：最大生命周期30分钟
- MySQL特有配置：自增主键策略，连接验证SQL

### PostgreSQL专属配置
- 连接池参数：最小空闲连接数5，最大连接数10（比MySQL少）
- 连接超时设置：与MySQL相同的超时配置
- PostgreSQL特有配置：雪花算法主键策略，连接验证SQL（不使用DUAL表）

### Maven依赖内容
- 数据库驱动依赖（MySQL或PostgreSQL）
- HikariCP连接池依赖（显式引入避免版本冲突）

## 技术栈

- Spring Boot配置
- HikariCP连接池
- MyBatis Plus
- MySQL 
- PostgreSQL 

## 注意事项

### 配置生成规范
1. **数据库类型必须准确**：dbType参数必须严格使用`mysql`或`postgresql`，区分大小写
2. **连接URL格式正确**：必须使用完整的JDBC URL格式，包含必要的参数
3. **include路径保持不变**：application.yml.ftl中的include语句路径`db/${dbType}/db-config-snippet.yml.ftl`不得修改
4. **条件语句保持完整**：模板中的FreeMarker条件判断语句必须完整保留

### 参数使用规范
1. **progectName参数拼写**：注意参数名是`progectName`（不是`projectName`），必须与模板完全一致
2. **数据库URL参数**：URL中的特殊字符（如&、?等）必须正确转义
3. **密码特殊字符**：如果密码包含特殊字符，需要进行适当的URL编码
4. **版本号固定**：依赖中的版本号（如MySQL 8.0.33、PostgreSQL 42.6.0）不得随意修改

### 配置文件使用规范
1. **文件位置**：生成的application.yml必须放在src/main/resources目录下
2. **依赖添加位置**：pom-dependency-snippet.ftl的内容必须添加到pom.xml的dependencies节点内
3. **配置优先级**：如果项目已有配置，需要注意配置的优先级和覆盖关系
4. **环境变量支持**：敏感信息（如密码）建议使用环境变量或配置中心管理

### 常见错误避免
1. **不要修改驱动类名**：模板中动态生成的驱动类名不要手动修改
2. **不要混淆连接池配置**：MySQL和PostgreSQL的连接池参数有所不同，不要混用
3. **不要遗漏include指令**：application.yml.ftl中的include指令是引入专属配置的关键，不可遗漏
4. **不要修改依赖scope**：数据库驱动的scope为runtime，不要改为compile

### 生成后处理
1. **数据库创建**：使用配置前必须确保数据库已创建且用户权限正确
2. **网络连通性**：确保应用服务器可以访问数据库服务器
3. **配置验证**：启动应用前验证配置文件格式正确性
4. **连接测试**：首次启动后检查数据库连接是否正常