/************************************************************************
 * @description 对内置函数`SplitPath`的封装，将路径字符串分解为对象
 * @author 
 * @date 2026/07/09
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 对内置函数SplitPath的封装
 * @param path 路径字符串
 * @returns {Object} 分解后的路径对象
 * @property {string} FileName 文件名
 * @property {string} Dir 目录
 * @property {string} Extension 扩展名
 * @property {string} NameNoExt 无扩展名的文件名
 * @property {string} Drive 盘符
 */
SplitPath2Object(path) {
    SplitPath(path, &OutFileName, &OutDir, &OutExtension, &OutNameNoExt, &OutDrive)
    return {
        FileName: OutFileName,
        Dir: OutDir,
        Extension: OutExtension,
        NameNoExt: OutNameNoExt,
        Drive: OutDrive
    }
}
;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    if not A_Args.Length {
        A_Args.Push("https://www.autohotkey.com/download/")
    }
    result := A_Args[1] "`n"
    result .= RegExReplace(A_Args[1], "ahk:/*") "`n"
    for k, v in SplitPath2Object(A_Args[1]).OwnProps() {
        result .= k " " v "`n"
    }
    OutputDebug result
}
;@Ahk2Exe-IgnoreEnd
