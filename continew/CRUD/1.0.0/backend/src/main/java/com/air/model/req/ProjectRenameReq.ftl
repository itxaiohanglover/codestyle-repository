package ${packageName}.${subPackageName}.model.req;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 项目重命名请求参数
 *
 * @author ${author}
 * @since ${datetime}
 */
@Data
@Schema(description = "项目重命名请求参数")
public class ${className} implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Schema(description = "原包名前缀", example = "com.air")
    @NotBlank(message = "原包名不能为空")
    private String oldPackageName;

    @Schema(description = "新包名前缀", example = "com.company")
    @NotBlank(message = "新包名不能为空")
    private String newPackageName;

    @Schema(description = "原项目标识名", example = "air")
    @NotBlank(message = "原项目名不能为空")
    private String oldProjectName;

    @Schema(description = "新项目标识名", example = "company")
    @NotBlank(message = "新项目名不能为空")
    private String newProjectName;

    @Schema(description = "原表名前缀", example = "t_air")
    private String oldTablePrefix;

    @Schema(description = "新表名前缀", example = "t_company")
    private String newTablePrefix;

    @Schema(description = "项目根目录路径", example = "D:\\projects\\my-continew-app")
    @NotBlank(message = "项目路径不能为空")
    private String projectRootPath;

    @Schema(description = "是否重命名目录", example = "true")
    @NotNull(message = "是否重命名目录不能为空")
    private Boolean renameDirectories = true;

    @Schema(description = "是否更新数据库", example = "true")
    private Boolean updateDatabase = false;

    @Schema(description = "是否创建备份", example = "true")
    private Boolean createBackup = true;

    @Schema(description = "备份路径")
    private String backupPath;

    @Schema(description = "包含的文件类型", example = "*.java,*.xml,*.yml")
    private String includePatterns = "*.java,*.xml,*.yml,*.properties,*.md";

    @Schema(description = "排除的文件路径", example = "target/,build/,node_modules/")
    private String excludePaths = "target/,build/,node_modules/,git/,idea/";

    @Schema(description = "操作描述")
    private String description;
}