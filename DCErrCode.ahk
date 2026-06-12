/************************************************************************
 * @description DllCall错误代码查询
 * @author 
 * @date 2026/06/12
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

DCErrCode := Map(
    -1073741275, "STATUS_NOT_FOUND",
    -1073741811, "STATUS_INVALID_PARAMETER",
    -1073741801, "STATUS_NO_MEMORY"
)