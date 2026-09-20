/************************************************************************
 * @description 从注册表路径中获取文件路径
 * @author 
 * @date 2026/09/20
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 从注册表路径中获取文件路径
 * @param RegPath 注册表路径
 * @returns {String | unset} 文件路径
 */
GetPathFromReg(RegPath) {
    if not (RegPath is String) {
        throw "RegPath must be a string"
    }
    if not RegExMatch(RegRead(RegPath), "([a-zA-Z]:\\(?:.*?)(?=$|[`"']))", &Match) {
        throw "RegPath not found"
    }
    if not FileExist(Match[1]) {
        throw "FilePath/FileDir not found"
    }
    return Match[1]
}
;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    OutputDebug GetPathFromReg("HKCR\steam\shell\open\command\")
}
;@Ahk2Exe-IgnoreEnd
