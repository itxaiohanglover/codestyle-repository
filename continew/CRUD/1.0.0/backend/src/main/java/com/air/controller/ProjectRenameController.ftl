package ${packageName}.${subPackageName};

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import top.continew.admin.common.core.response.R;
import top.continew.admin.common.validation.ValidationGroup;
import ${packageName}.model.req.ProjectRenameReq;
import ${packageName}.model.resp.ProjectRenameResp;
import ${packageName}.service.ProjectRenameService;

import jakarta.validation.Valid;
import java.util.Map;

/**
 * 项目重命名管理 API
 *
 * @author ${author}
 * @since ${datetime}
 */
@Slf4j
@Tag(name = "项目重命名管理 API")
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/project-rename")
@Validated
public class ${className} {

    private final ${classNamePrefix}Service projectRenameService;

    /**
     * 预览重命名影响范围
     *
     * @param request 重命名请求参数
     * @return 影响范围预览
     */
    @Operation(summary = "预览重命名影响范围", description = "分析项目重命名将影响的文件和配置")
    @PostMapping("/preview")
    public R${"<"}ProjectRenameResp${">"} preview(@Valid @RequestBody ProjectRenameReq request) {
        log.info("预览项目重命名: {}", request);
        ProjectRenameResp response = projectRenameService.preview(request);
        return R.ok(response);
    }

    /**
     * 执行项目重命名
     *
     * @param request 重命名请求参数
     * @return 执行结果
     */
    @Operation(summary = "执行项目重命名", description = "执行完整的项目重命名操作")
    @PostMapping("/execute")
    public R${"<"}Map${"<"}String, Object${">"}${">"} execute(@Valid @RequestBody ProjectRenameReq request) {
        log.info("开始执行项目重命名: {}", request);
        Map${"<"}String, Object${">"} result = projectRenameService.executeRename(request);
        return R.ok(result);
    }

    /**
     * 批量重命名Java文件
     *
     * @param request 重命名请求参数
     * @return 执行结果
     */
    @Operation(summary = "批量重命名Java文件", description = "批量更新Java文件中的包名和import语句")
    @PostMapping("/java/rename")
    public R${"<"}Map${"<"}String, Object${">"}${">"} renameJavaFiles(@Valid @RequestBody ProjectRenameReq request) {
        log.info("批量重命名Java文件: {}", request);
        Map${"<"}String, Object${">"} result = projectRenameService.renameJavaFiles(request);
        return R.ok(result);
    }

    /**
     * 更新配置文件
     *
     * @param request 重命名请求参数
     * @return 执行结果
     */
    @Operation(summary = "更新配置文件", description = "更新项目中的配置文件")
    @PostMapping("/config/update")
    public R${"<"}Map${"<"}String, Object${">"}${">"} updateConfigFiles(@Valid @RequestBody ProjectRenameReq request) {
        log.info("更新配置文件: {}", request);
        Map${"<"}String, Object${">"} result = projectRenameService.updateConfigFiles(request);
        return R.ok(result);
    }

    /**
     * 生成数据库重命名脚本
     *
     * @param request 重命名请求参数
     * @return SQL脚本内容
     */
    @Operation(summary = "生成数据库重命名脚本", description = "生成数据库表重命名的SQL脚本")
    @PostMapping("/database/script")
    public R${"<"}String${">"} generateDatabaseScript(@Valid @RequestBody ProjectRenameReq request) {
        log.info("生成数据库重命名脚本: {}", request);
        String script = projectRenameService.generateDatabaseScript(request);
        return R.ok(script);
    }

    /**
     * 验证重命名结果
     *
     * @param request 重命名请求参数
     * @return 验证结果
     */
    @Operation(summary = "验证重命名结果", description = "验证重命名操作是否完整")
    @PostMapping("/verify")
    public R${"<"}Map${"<"}String, Object${">"}${">"} verifyRename(@Valid @RequestBody ProjectRenameReq request) {
        log.info("验证重命名结果: {}", request);
        Map${"<"}String, Object${">"} result = projectRenameService.verifyRename(request);
        return R.ok(result);
    }

    /**
     * 回滚重命名操作
     *
     * @param request 重命名请求参数
     * @return 回滚结果
     */
    @Operation(summary = "回滚重命名操作", description = "回滚已执行的重命名操作")
    @PostMapping("/rollback")
    public R${"<"}Map${"<"}String, Object${">"}${">"} rollbackRename(@Valid @RequestBody ProjectRenameReq request) {
        log.warn("回滚重命名操作: {}", request);
        Map${"<"}String, Object${">"} result = projectRenameService.rollbackRename(request);
        return R.ok(result);
    }

    /**
     * 获取重命名历史
     *
     * @param projectPath 项目路径
     * @return 历史记录
     */
    @Operation(summary = "获取重命名历史", description = "获取指定项目的重命名操作历史")
    @GetMapping("/history")
    public R${"<"}Map${"<"}String, Object${">"}${">"} getRenameHistory(@RequestParam String projectPath) {
        log.info("获取重命名历史: {}", projectPath);
        Map${"<"}String, Object${">"} history = projectRenameService.getRenameHistory(projectPath);
        return R.ok(history);
    }
}
