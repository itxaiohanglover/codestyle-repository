package ${packageName}.${subPackageName};

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Insert;

import java.util.List;
import java.util.Map;

/**
 * 项目重命名数据访问层
 *
 * @author ${author}
 * @since ${datetime}
 */
@Mapper
public interface ${className} {

    /**
     * 根据前缀查询数据库表
     *
     * @param tablePrefix 表名前缀
     * @return 表名列表
     */
    @Select("SELECT TABLE_NAME FROM information_schema.TABLES " +
            "WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME LIKE CONCAT(#{tablePrefix}, '_%')")
    List${"<"}String${">"} listTablesByPrefix(@Param("tablePrefix") String tablePrefix);

    /**
     * 查询表的外键约束
     *
     * @param tableName 表名
     * @return 外键约束列表
     */
    @Select("SELECT CONSTRAINT_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME " +
            "FROM information_schema.KEY_COLUMN_USAGE " +
            "WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = #{tableName} AND REFERENCED_TABLE_NAME IS NOT NULL")
    List${"<"}Map${"<"}String, Object${">"}${">"} listTableForeignKeys(@Param("tableName") String tableName);

    /**
     * 查询视图
     *
     * @param viewPrefix 视图名前缀
     * @return 视图列表
     */
    @Select("SELECT TABLE_NAME FROM information_schema.VIEWS " +
            "WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME LIKE CONCAT(#{viewPrefix}, '_%')")
    List${"<"}String${">"} listViewsByPrefix(@Param("viewPrefix") String viewPrefix);

    /**
     * 查询存储过程
     *
     * @param procPrefix 存储过程名前缀
     * @return 存储过程列表
     */
    @Select("SELECT ROUTINE_NAME FROM information_schema.ROUTINES " +
            "WHERE ROUTINE_SCHEMA = DATABASE() AND ROUTINE_TYPE = 'PROCEDURE' " +
            "AND ROUTINE_NAME LIKE CONCAT(#{procPrefix}, '_%')")
    List${"<"}String${">"} listProceduresByPrefix(@Param("procPrefix") String procPrefix);

    /**
     * 查询函数
     *
     * @param funcPrefix 函数名前缀
     * @return 函数列表
     */
    @Select("SELECT ROUTINE_NAME FROM information_schema.ROUTINES " +
            "WHERE ROUTINE_SCHEMA = DATABASE() AND ROUTINE_TYPE = 'FUNCTION' " +
            "AND ROUTINE_NAME LIKE CONCAT(#{funcPrefix}, '_%')")
    List${"<"}String${">"} listFunctionsByPrefix(@Param("funcPrefix") String funcPrefix);

    /**
     * 插入重命名历史记录
     *
     * @param history 历史记录
     * @return 影响行数
     */
    @Insert("INSERT INTO project_rename_history (" +
            "project_path, old_package_name, new_package_name, " +
            "old_project_name, new_project_name, status, error_message, create_time" +
            ") VALUES (" +
            "#{projectPath}, #{oldPackageName}, #{newPackageName}, " +
            "#{oldProjectName}, #{newProjectName}, #{status}, #{errorMessage}, #{createTime}" +
            ")")
    int insertRenameHistory(@Param("history") Map${"<"}String, Object${">"} history);

    /**
     * 查询重命名历史
     *
     * @param projectPath 项目路径
     * @return 历史记录列表
     */
    @Select("SELECT * FROM project_rename_history " +
            "WHERE project_path = #{projectPath} " +
            "ORDER BY create_time DESC")
    List${"<"}Map${"<"}String, Object${">"}${">"} selectRenameHistory(@Param("projectPath") String projectPath);

    /**
     * 查询触发器
     *
     * @param triggerPrefix 触发器名前缀
     * @return 触发器列表
     */
    @Select("SELECT TRIGGER_NAME FROM information_schema.TRIGGERS " +
            "WHERE TRIGGER_SCHEMA = DATABASE() AND TRIGGER_NAME LIKE CONCAT(#{triggerPrefix}, '_%')")
    List${"<"}String${">"} listTriggersByPrefix(@Param("triggerPrefix") String triggerPrefix);

    /**
     * 检查表是否存在
     *
     * @param tableName 表名
     * @return 是否存在
     */
    @Select("SELECT COUNT(*) FROM information_schema.TABLES " +
            "WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = #{tableName}")
    int checkTableExists(@Param("tableName") String tableName);

    /**
     * 获取表的创建语句
     *
     * @param tableName 表名
     * @return 创建语句
     */
    @Select("SHOW CREATE TABLE #{tableName}")
    Map${"<"}String, Object${">"} getTableCreateSQL(@Param("tableName") String tableName);
}
