package ${packageName}.${subPackageName}.model.resp;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * 项目重命名响应参数
 *
 * @author ${author}
 * @since ${datetime}
 */
@Data
@Schema(description = "项目重命名响应参数")
public class ${className} implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Schema(description = "Java文件数量")
    private Integer javaFileCount;

    @Schema(description = "配置文件数量")
    private Integer configFileCount;

    @Schema(description = "数据库表数量")
    private Integer dbTableCount;

    @Schema(description = "预计执行时间（分钟）")
    private Integer estimatedMinutes;

    @Schema(description = "影响的文件列表")
    private List${"<"}String${">"} affectedFiles;

    @Schema(description = "影响的数据库表列表")
    private List${"<"}String${">"} affectedTables;

    @Schema(description = "扫描结果详情")
    private Map${"<"}String, Object${">"} scanDetails;

    @Schema(description = "建议")
    private List${"<"}String${">"} suggestions;

    @Schema(description = "警告信息")
    private List${"<"}String${">"} warnings;

    @Schema(description = "执行状态")
    private String status;

    @Schema(description = "执行消息")
    private String message;
}
