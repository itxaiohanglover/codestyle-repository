import http from '@/utils/http'
import type { PageQuery, PageRes } from '@/types/global'

const BASE_URL = '/api/v1/project-rename'

// 请求参数类型
export interface ProjectRenameReq {
  oldPackageName: string
  newPackageName: string
  oldProjectName: string
  newProjectName: string
  oldTablePrefix?: string
  newTablePrefix?: string
  projectRootPath: string
  renameDirectories?: boolean
  updateDatabase?: boolean
  createBackup?: boolean
  backupPath?: string
  includePatterns?: string
  excludePaths?: string
  description?: string
}

// 响应参数类型
export interface ProjectRenameResp {
  javaFileCount: number
  configFileCount: number
  dbTableCount: number
  estimatedMinutes: number
  affectedFiles?: string[]
  affectedTables?: string[]
  scanDetails?: Record${"<"}string, any${">"}
  suggestions?: string[]
  warnings?: string[]
  status?: string
  message?: string
}

// 历史记录类型
export interface RenameHistory {
  id: string
  projectPath: string
  oldPackageName: string
  newPackageName: string
  oldProjectName: string
  newProjectName: string
  status: string
  errorMessage?: string
  createTime: string
}

/** @desc 预览重命名影响范围 */
export function previewProjectRename(data: ProjectRenameReq) {
  return http.post${"<"}ProjectRenameResp${">"}(`${"$"}{BASE_URL}/preview`, data)
}

/** @desc 执行项目重命名 */
export function executeProjectRename(data: ProjectRenameReq) {
  return http.post${"<"}Record${"<"}string, any${">"}${">"}(`${"$"}{BASE_URL}/execute`, data)
}

/** @desc 批量重命名Java文件 */
export function renameJavaFiles(data: ProjectRenameReq) {
  return http.post${"<"}Record${"<"}string, any${">"}${">"}(`${"$"}{BASE_URL}/java/rename`, data)
}

/** @desc 更新配置文件 */
export function updateConfigFiles(data: ProjectRenameReq) {
  return http.post${"<"}Record${"<"}string, any${">"}${">"}(`${"$"}{BASE_URL}/config/update`, data)
}

/** @desc 生成数据库重命名脚本 */
export function generateDatabaseScript(data: ProjectRenameReq) {
  return http.post${"<"}string${">"}(`${"$"}{BASE_URL}/database/script`, data)
}

/** @desc 验证重命名结果 */
export function verifyRenameResult(data: ProjectRenameReq) {
  return http.post${"<"}Record${"<"}string, any${">"}${">"}(`${"$"}{BASE_URL}/verify`, data)
}

/** @desc 回滚重命名操作 */
export function rollbackProjectRename(data: ProjectRenameReq) {
  return http.post${"<"}Record${"<"}string, any${">"}${">"}(`${"$"}{BASE_URL}/rollback`, data)
}

/** @desc 获取重命名历史 */
export function getRenameHistory(projectPath: string) {
  return http.get${"<"}Record${"<"}string, any${">"}${">"}(`${"$"}{BASE_URL}/history`, { params: { projectPath } })
}
