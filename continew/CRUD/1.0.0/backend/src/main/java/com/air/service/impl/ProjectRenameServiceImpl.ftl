package ${packageName}.${subPackageName};

import ${packageName}.mapper.ProjectRenameMapper;
import ${packageName}.model.req.ProjectRenameReq;
import ${packageName}.model.resp.ProjectRenameResp;
import ${packageName}.service.ProjectRenameService;
import ${packageName}.utils.ProjectRenameUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * 项目重命名业务实现
 *
 * @author ${author}
 * @since ${datetime}
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ${className} implements ${classNamePrefix}Service {

    private final ${classNamePrefix}Mapper projectRenameMapper;
    private final ExecutorService executorService = Executors.newFixedThreadPool(4);

    @Override
    public ProjectRenameResp preview(ProjectRenameReq request) {
        log.info("开始预览重命名影响范围: {}", request);

        ProjectRenameResp response = new ProjectRenameResp();

        // 扫描Java文件
        List${"<"}String${">"} javaFiles = ProjectRenameUtils.scanJavaFiles(request.getProjectRootPath());
        response.setJavaFileCount(javaFiles.size());

        // 扫描配置文件
        List${"<"}String${">"} configFiles = ProjectRenameUtils.scanConfigFiles(request.getProjectRootPath());
        response.setConfigFileCount(configFiles.size());

        // 扫描数据库表
        List${"<"}String${">"} dbTables = projectRenameMapper.listTablesByPrefix(request.getOldTablePrefix());
        response.setDbTableCount(dbTables.size());

        // 估算执行时间
        response.setEstimatedMinutes((javaFiles.size() + configFiles.size()) / 10);

        log.info("预览完成: Java文件{}个, 配置文件{}个, 数据表{}个",
            javaFiles.size(), configFiles.size(), dbTables.size());

        return response;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Map${"<"}String, Object${">"} executeRename(ProjectRenameReq request) {
        log.info("开始执行项目重命名: {}", request);

        Map${"<"}String, Object${">"} result = new HashMap${"<"}${">"}();
        List${"<"}String${">"} errors = new ArrayList${"<"}${">"}();

        try {
            // 1. 创建备份
            String backupPath = ProjectRenameUtils.createBackup(request.getProjectRootPath());
            result.put("backupPath", backupPath);

            // 2. 并行执行重命名任务
            CompletableFuture${"<"}Void${">"} javaTask = CompletableFuture.runAsync(() -> {
                try {
                    renameJavaFiles(request);
                } catch (Exception e) {
                    log.error("Java文件重命名失败", e);
                    errors.add("Java文件重命名失败: " + e.getMessage());
                }
            }, executorService);

            CompletableFuture${"<"}Void${">"} configTask = CompletableFuture.runAsync(() -> {
                try {
                    updateConfigFiles(request);
                } catch (Exception e) {
                    log.error("配置文件更新失败", e);
                    errors.add("配置文件更新失败: " + e.getMessage());
                }
            }, executorService);

            // 等待任务完成
            CompletableFuture.allOf(javaTask, configTask).join();

            // 3. 记录操作历史
            saveRenameHistory(request, "SUCCESS", null);

            result.put("success", errors.isEmpty());
            result.put("errors", errors);
            result.put("message", errors.isEmpty() ? "项目重命名成功" : "项目重命名部分失败");

        } catch (Exception e) {
            log.error("执行项目重命名失败", e);
            saveRenameHistory(request, "FAILED", e.getMessage());
            result.put("success", false);
            result.put("errors", Arrays.asList(e.getMessage()));
            result.put("message", "项目重命名失败: " + e.getMessage());
        }

        return result;
    }

    @Override
    public Map${"<"}String, Object${">"} renameJavaFiles(ProjectRenameReq request) {
        Map${"<"}String, Object${">"} result = new HashMap${"<"}${">"}();
        List${"<"}String${">"} processedFiles = new ArrayList${"<"}${">"}();
        List${"<"}String${">"} errors = new ArrayList${"<"}${">"}();

        try {
            List${"<"}String${">"} javaFiles = ProjectRenameUtils.scanJavaFiles(request.getProjectRootPath());

            for (String filePath : javaFiles) {
                try {
                    boolean success = ProjectRenameUtils.renameJavaFile(filePath, request);
                    if (success) {
                        processedFiles.add(filePath);
                    } else {
                        errors.add("处理文件失败: " + filePath);
                    }
                } catch (Exception e) {
                    log.error("处理文件失败: " + filePath, e);
                    errors.add("处理文件失败: " + filePath + " - " + e.getMessage());
                }
            }

            result.put("totalFiles", javaFiles.size());
            result.put("processedFiles", processedFiles.size());
            result.put("errors", errors);
            result.put("success", errors.isEmpty());

        } catch (Exception e) {
            log.error("批量重命名Java文件失败", e);
            result.put("success", false);
            result.put("errors", Arrays.asList(e.getMessage()));
        }

        return result;
    }

    @Override
    public Map${"<"}String, Object${">"} updateConfigFiles(ProjectRenameReq request) {
        Map${"<"}String, Object${">"} result = new HashMap${"<"}${">"}();
        List${"<"}String${">"} processedFiles = new ArrayList${"<"}${">"}();
        List${"<"}String${">"} errors = new ArrayList${"<"}${">"}();

        try {
            List${"<"}String${">"} configFiles = ProjectRenameUtils.scanConfigFiles(request.getProjectRootPath());

            for (String filePath : configFiles) {
                try {
                    boolean success = ProjectRenameUtils.updateConfigFile(filePath, request);
                    if (success) {
                        processedFiles.add(filePath);
                    } else {
                        errors.add("更新配置文件失败: " + filePath);
                    }
                } catch (Exception e) {
                    log.error("更新配置文件失败: " + filePath, e);
                    errors.add("更新配置文件失败: " + filePath + " - " + e.getMessage());
                }
            }

            result.put("totalFiles", configFiles.size());
            result.put("processedFiles", processedFiles.size());
            result.put("errors", errors);
            result.put("success", errors.isEmpty());

        } catch (Exception e) {
            log.error("更新配置文件失败", e);
            result.put("success", false);
            result.put("errors", Arrays.asList(e.getMessage()));
        }

        return result;
    }

    @Override
    public String generateDatabaseScript(ProjectRenameReq request) {
        log.info("生成数据库重命名脚本: {}", request);

        StringBuilder script = new StringBuilder();
        script.append("-- 数据库重命名脚本\n");
        script.append("-- 生成时间: ").append(LocalDateTime.now()).append("\n\n");

        try {
            // 查询需要重命名的表
            List${"<"}String${">"} tables = projectRenameMapper.listTablesByPrefix(request.getOldTablePrefix());

            for (String oldTableName : tables) {
                String newTableName = oldTableName.replace(request.getOldTablePrefix(), request.getNewTablePrefix());

                // 生成重命名表的SQL
                script.append("-- 重命名表\n");
                script.append("RENAME TABLE `").append(oldTableName).append("` TO `").append(newTableName).append("`;\n\n");
            }

            // 查询并生成视图重命名脚本
            List${"<"}String${">"} views = projectRenameMapper.listViewsByPrefix(request.getOldTablePrefix());
            for (String oldViewName : views) {
                String newViewName = oldViewName.replace(request.getOldTablePrefix(), request.getNewTablePrefix());
                script.append("-- 重命名视图\n");
                script.append("RENAME VIEW `").append(oldViewName).append("` TO `").append(newViewName).append("`;\n\n");
            }

            log.info("数据库脚本生成完成，包含{}个表和{}个视图", tables.size(), views.size());

        } catch (Exception e) {
            log.error("生成数据库脚本失败", e);
            script.append("-- 错误: ").append(e.getMessage()).append("\n");
        }

        return script.toString();
    }

    @Override
    public Map${"<"}String, Object${">"} verifyRename(ProjectRenameReq request) {
        Map${"<"}String, Object${">"} result = new HashMap${"<"}${">"}();
        List${"<"}String${">"} issues = new ArrayList${"<"}${">"}();

        try {
            // 验证Java文件
            List${"<"}String${">"} javaFiles = ProjectRenameUtils.scanJavaFiles(request.getProjectRootPath());
            for (String filePath : javaFiles) {
                List${"<"}String${">"} fileIssues = ProjectRenameUtils.verifyJavaFile(filePath, request);
                issues.addAll(fileIssues);
            }

            // 验证配置文件
            List${"<"}String${">"} configFiles = ProjectRenameUtils.scanConfigFiles(request.getProjectRootPath());
            for (String filePath : configFiles) {
                List${"<"}String${">"} fileIssues = ProjectRenameUtils.verifyConfigFile(filePath, request);
                issues.addAll(fileIssues);
            }

            result.put("verifiedFiles", javaFiles.size() + configFiles.size());
            result.put("issues", issues);
            result.put("success", issues.isEmpty());

        } catch (Exception e) {
            log.error("验证重命名结果失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }

        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Map${"<"}String, Object${">"} rollbackRename(ProjectRenameReq request) {
        log.warn("开始回滚重命名操作: {}", request);

        Map${"<"}String, Object${">"} result = new HashMap${"<"}${">"}();
        List${"<"}String${">"} errors = new ArrayList${"<"}${">"}();

        try {
            // 交换新旧名称进行回滚
            ProjectRenameReq rollbackRequest = new ProjectRenameReq();
            rollbackRequest.setOldPackageName(request.getNewPackageName());
            rollbackRequest.setNewPackageName(request.getOldPackageName());
            rollbackRequest.setOldProjectName(request.getNewProjectName());
            rollbackRequest.setNewProjectName(request.getOldProjectName());
            rollbackRequest.setOldTablePrefix(request.getNewTablePrefix());
            rollbackRequest.setNewTablePrefix(request.getOldTablePrefix());
            rollbackRequest.setProjectRootPath(request.getProjectRootPath());
            rollbackRequest.setRenameDirectories(request.getRenameDirectories());
            rollbackRequest.setCreateBackup(false); // 回滚时不创建备份

            // 执行回滚
            Map${"<"}String, Object${">"} rollbackResult = executeRename(rollbackRequest);
            result.put("rollbackSuccess", rollbackResult.get("success"));
            result.put("message", "重命名操作已回滚");

            // 记录回滚历史
            saveRenameHistory(request, "ROLLED_BACK", null);

        } catch (Exception e) {
            log.error("回滚重命名操作失败", e);
            result.put("success", false);
            errors.add(e.getMessage());
            result.put("errors", errors);
        }

        return result;
    }

    @Override
    public Map${"<"}String, Object${">"} getRenameHistory(String projectPath) {
        Map${"<"}String, Object${">"} result = new HashMap${"<"}${">"}();

        try {
            List${"<"}Map${"<"}String, Object${">"}${">"} history = projectRenameMapper.selectRenameHistory(projectPath);

            result.put("projectPath", projectPath);
            result.put("history", history);
            result.put("count", history.size());
            result.put("success", true);

        } catch (Exception e) {
            log.error("获取重命名历史失败", e);
            result.put("success", false);
            result.put("error", e.getMessage());
        }

        return result;
    }

    /**
     * 保存重命名历史记录
     */
    private void saveRenameHistory(ProjectRenameReq request, String status, String errorMessage) {
        try {
            Map${"<"}String, Object${">"} history = new HashMap${"<"}${">"}();
            history.put("projectPath", request.getProjectRootPath());
            history.put("oldPackageName", request.getOldPackageName());
            history.put("newPackageName", request.getNewPackageName());
            history.put("oldProjectName", request.getOldProjectName());
            history.put("newProjectName", request.getNewProjectName());
            history.put("status", status);
            history.put("errorMessage", errorMessage);
            history.put("createTime", LocalDateTime.now());

            projectRenameMapper.insertRenameHistory(history);

        } catch (Exception e) {
            log.error("保存重命名历史失败", e);
        }
    }
}
