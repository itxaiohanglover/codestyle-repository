package ${packageName}.${subPackageName};

import ${packageName}.model.req.ProjectRenameReq;
import ${packageName}.model.resp.ProjectRenameResp;

import java.util.Map;

/**
 * 项目重命名业务接口
 *
 * @author ${author}
 * @since ${datetime}
 */
public interface ${className} {

    /**
     * 预览重命名影响范围
     *
     * @param request 重命名请求参数
     * @return 影响范围预览
     */
    ProjectRenameResp preview(ProjectRenameReq request);

    /**
     * 执行项目重命名
     *
     * @param request 重命名请求参数
     * @return 执行结果
     */
    Map${"<"}String, Object${">"} executeRename(ProjectRenameReq request);

    /**
     * 批量重命名Java文件
     *
     * @param request 重命名请求参数
     * @return 执行结果
     */
    Map${"<"}String, Object${">"} renameJavaFiles(ProjectRenameReq request);

    /**
     * 更新配置文件
     *
     * @param request 重命名请求参数
     * @return 执行结果
     */
    Map${"<"}String, Object${">"} updateConfigFiles(ProjectRenameReq request);

    /**
     * 生成数据库重命名脚本
     *
     * @param request 重命名请求参数
     * @return SQL脚本内容
     */
    String generateDatabaseScript(ProjectRenameReq request);

    /**
     * 验证重命名结果
     *
     * @param request 重命名请求参数
     * @return 验证结果
     */
    Map${"<"}String, Object${">"} verifyRename(ProjectRenameReq request);

    /**
     * 回滚重命名操作
     *
     * @param request 重命名请求参数
     * @return 回滚结果
     */
    Map${"<"}String, Object${">"} rollbackRename(ProjectRenameReq request);

    /**
     * 获取重命名历史
     *
     * @param projectPath 项目路径
     * @return 历史记录
     */
    Map${"<"}String, Object${">"} getRenameHistory(String projectPath);
}
