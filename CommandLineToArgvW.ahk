/************************************************************************
 * @description 命令行参数文本转数组，基于`Shell32\CommandLineToArgvW`。
 * @author 
 * @date 2026/05/27
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 命令行参数转数组
 * @param lpCmdLine 命令行参数
 * @returns {Integer | Array} 成功则返回参数数组，失败则返回false
 */
CommandLineToArgvW(lpCmdLine) {
    pNumArgs := 0
    arr := []

    pArgv := DllCall('Shell32\CommandLineToArgvW', 'wstr', lpCmdLine, 'int*', &pNumArgs, 'ptr')
    if not pArgv {
        return false
    }
    loop pNumArgs {
        arr.Push(StrGet(NumGet(pArgv, (A_Index - 1) * A_PtrSize, "uint"), , "utf-16"))
    }
    if DllCall("LocalFree", "Ptr", pArgv) {
        throw "LocalFree failed"
    }
    return arr
}