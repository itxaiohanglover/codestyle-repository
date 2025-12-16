<#--
数据库表重命名SQL脚本模板
用于将ContiNew项目的数据库表从原前缀重命名为新前缀

使用说明:
1. 根据实际情况修改表名
2. 将 ${oldTablePrefix} 替换为实际的旧表前缀
3. 将 ${newTablePrefix} 替换为实际的新表前缀
4. 在生产环境使用前请备份数据库
5. 建议在测试环境先行验证
-->

<#assign oldPrefix = oldTablePrefix />
<#assign newPrefix = newTablePrefix />

-- ========================================
-- ${businessName}项目数据库表重命名脚本
-- ========================================

-- 设置SQL安全模式 (MySQL)
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_SAFE_UPDATES = 0;

-- ========================================
-- 系统管理相关表重命名
-- ========================================

-- 用户管理
<#if oldPrefix??>
RENAME TABLE `${oldPrefix}_user` TO `${newPrefix}_user`;
RENAME TABLE `${oldPrefix}_role` TO `${newPrefix}_role`;
RENAME TABLE `${oldPrefix}_permission` TO `${newPrefix}_permission`;
RENAME TABLE `${oldPrefix}_user_role` TO `${newPrefix}_user_role`;
RENAME TABLE `${oldPrefix}_role_permission` TO `${newPrefix}_role_permission`;
</#if>

-- 部门管理
<#if oldPrefix??>
RENAME TABLE `${oldPrefix}_dept` TO `${newPrefix}_dept`;
RENAME TABLE `${oldPrefix}_user_dept` TO `${newPrefix}_user_dept`;
</#if>

-- 菜单管理
<#if oldPrefix??>
RENAME TABLE `${oldPrefix}_menu` TO `${newPrefix}_menu`;
RENAME TABLE `${oldPrefix}_menu_meta` TO `${newPrefix}_menu_meta`;
</#if>

-- 字典管理
<#if oldPrefix??>
RENAME TABLE `${oldPrefix}_dict_type` TO `${newPrefix}_dict_type`;
RENAME TABLE `${oldPrefix}_dict_data` TO `${newPrefix}_dict_data`;
</#if>

-- 参数配置
<#if oldPrefix??>
RENAME TABLE `${oldPrefix}_config` TO `${newPrefix}_config`;
</#if>

-- 通知公告
<#if oldPrefix??>
RENAME TABLE `${oldPrefix}_notice` TO `${newPrefix}_notice`;
RENAME TABLE `${oldPrefix}_notice_user` TO `${newPrefix}_notice_user`;
</#if>

-- ========================================
-- 日志审计相关表重命名
-- ========================================

-- 操作日志
<#if oldPrefix??>
RENAME TABLE `${oldPrefix}_operation_log` TO `${newPrefix}_operation_log`;
</#if>

-- 登录日志
<#if oldPrefix??>
RENAME TABLE `${oldPrefix}_login_log` TO `${newPrefix}_login_log`;
</#if>

-- ========================================
-- 文件管理相关表重命名
-- ========================================

-- 文件信息
<#if oldPrefix??>
RENAME TABLE `${oldPrefix}_file_info` TO `${newPrefix}_file_info`;
RENAME TABLE `${oldPrefix}_file_category` TO `${newPrefix}_file_category`;
</#if>

-- ========================================
-- 业务表重命名 (根据实际业务调整)
-- ========================================

-- 示例：订单管理
-- RENAME TABLE `${oldPrefix}_order` TO `${newPrefix}_order`;
-- RENAME TABLE `${oldPrefix}_order_item` TO `${newPrefix}_order_item`;
-- RENAME TABLE `${oldPrefix}_order_log` TO `${newPrefix}_order_log`;

-- 示例：商品管理
-- RENAME TABLE `${oldPrefix}_product` TO `${newPrefix}_product`;
-- RENAME TABLE `${oldPrefix}_product_category` TO `${newPrefix}_product_category`;
-- RENAME TABLE `${oldPrefix}_product_sku` TO `${newPrefix}_product_sku`;

-- ========================================
-- 更新外键约束 (如果存在)
-- ========================================

-- 注意：外键约束需要根据实际情况调整
-- 以下为示例，实际使用时需要根据具体的外键关系进行修改

-- 示例：更新用户角色表的外键
<#if oldPrefix?? && newPrefix??>
-- ALTER TABLE `${newPrefix}_user_role`
-- DROP FOREIGN KEY `fk_user_role_user_id`,
-- ADD CONSTRAINT `fk_user_role_user_id` FOREIGN KEY (`user_id`) REFERENCES `${newPrefix}_user` (`id`);

-- 示例：更新角色权限表的外键
-- ALTER TABLE `${newPrefix}_role_permission`
-- DROP FOREIGN KEY `fk_role_permission_role_id`,
-- ADD CONSTRAINT `fk_role_permission_role_id` FOREIGN KEY (`role_id`) REFERENCES `${newPrefix}_role` (`id`);
</#if>

-- ========================================
-- 更新视图 (如果存在)
-- ========================================

-- 示例：更新用户详情视图
-- DROP VIEW IF EXISTS `v_user_detail`;
-- CREATE VIEW `v_user_detail` AS
-- SELECT
--     u.id,
--     u.username,
--     u.nickname,
--     u.email,
--     u.mobile,
--     d.name as dept_name,
--     GROUP_CONCAT(r.name) as role_names
-- FROM `${newPrefix}_user` u
-- LEFT JOIN `${newPrefix}_user_dept` ud ON u.id = ud.user_id
-- LEFT JOIN `${newPrefix}_dept` d ON ud.dept_id = d.id
-- LEFT JOIN `${newPrefix}_user_role` ur ON u.id = ur.user_id
-- LEFT JOIN `${newPrefix}_role` r ON ur.role_id = r.id
-- GROUP BY u.id;

-- ========================================
-- 更新存储过程和函数 (如果存在)
-- ========================================

-- 示例：更新用户权限检查函数
-- DELIMITER $$
-- DROP FUNCTION IF EXISTS `check_user_permission`$$
-- CREATE FUNCTION `check_user_permission`(
--     p_user_id BIGINT,
--     p_permission_code VARCHAR(100)
-- ) RETURNS BOOLEAN
-- READS SQL DATA
-- DETERMINISTIC
-- BEGIN
--     DECLARE v_count INT DEFAULT 0;
--
--     SELECT COUNT(*) INTO v_count
--     FROM `${newPrefix}_user` u
--     JOIN `${newPrefix}_user_role` ur ON u.id = ur.user_id
--     JOIN `${newPrefix}_role_permission` rp ON ur.role_id = rp.role_id
--     JOIN `${newPrefix}_permission` p ON rp.permission_id = p.id
--     WHERE u.id = p_user_id
--       AND u.deleted = 0
--       AND p.code = p_permission_code
--       AND p.deleted = 0;
--
--     RETURN v_count > 0;
-- END$$
-- DELIMITER ;

-- ========================================
-- 更新触发器 (如果存在)
-- ========================================

-- 示例：更新用户操作日志触发器
-- DELIMITER $$
-- DROP TRIGGER IF EXISTS `tr_user_operation_log`$$
-- CREATE TRIGGER `tr_user_operation_log`
-- AFTER UPDATE ON `${newPrefix}_user`
-- FOR EACH ROW
-- BEGIN
--     INSERT INTO `${newPrefix}_operation_log` (
--         user_id, operation_type, description, create_time
--     ) VALUES (
--         NEW.update_by, 'UPDATE',
--         CONCAT('更新用户信息: ', NEW.username),
--         NOW()
--     );
-- END$$
-- DELIMITER ;

-- ========================================
-- 恢复SQL安全模式
-- ========================================

SET FOREIGN_KEY_CHECKS = 1;
SET SQL_SAFE_UPDATES = 1;

-- ========================================
-- 验证重命名结果
-- ========================================

-- 查看所有重命名后的表
<#if newPrefix??>
SELECT
    TABLE_NAME,
    TABLE_COMMENT,
    TABLE_ROWS
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME LIKE '${newPrefix}_%'
ORDER BY TABLE_NAME;
</#if>

-- ========================================
-- 注意事项
-- ========================================

-- 1. 生产环境使用前请务必备份数据库
-- 2. 建议在测试环境先行验证
-- 3. 重命名后需要更新应用程序中的表名配置
-- 4. 如果有ORM框架的实体类，需要同步更新@TableName注解
-- 5. 检查所有SQL语句、存储过程、函数中的表名引用
-- 6. 更新数据库文档和ER图

-- ========================================
-- 回滚脚本 (如需回滚，请执行以下SQL)
-- ========================================

-- SET FOREIGN_KEY_CHECKS = 0;
<#if oldPrefix?? && newPrefix??>
-- RENAME TABLE `${newPrefix}_user` TO `${oldPrefix}_user`;
-- RENAME TABLE `${newPrefix}_role` TO `${oldPrefix}_role`;
-- ... (其他表的回滚)
</#if>
-- SET FOREIGN_KEY_CHECKS = 1;

<#---- PostgreSQL（切换 PostgreSQL 数据库时请注释掉其他数据库脚本，并解开此段注释）-->
<#--DO $$-->
<#--DECLARE-->
<#--    old_prefix TEXT := '${oldTablePrefix}';-->
<#--    new_prefix TEXT := '${newTablePrefix}';-->
<#--    table_record RECORD;-->
<#--BEGIN-->

<#--    -- 禁用外键约束检查-->
<#--    SET CONSTRAINTS ALL DEFERRED;-->

<#--    -- 重命名表-->
<#--    FOR table_record IN-->
<#--        SELECT table_name-->
<#--        FROM information_schema.tables-->
<#--        WHERE table_schema = current_schema()-->
<#--        AND table_name LIKE old_prefix || '_%'-->
<#--    LOOP-->
<#--        EXECUTE 'ALTER TABLE ' || table_record.table_name ||-->
<#--                ' RENAME TO ' || replace(table_record.table_name, old_prefix, new_prefix);-->
<#--    END LOOP;-->

<#--END $$;-->