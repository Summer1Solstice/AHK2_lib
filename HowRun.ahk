/************************************************************************
 * @description 通过标准输出、`A_DebuggerName`、`A_Args`、控制台附加等方式判断脚本如何运行。
 * @author 
 * @date 2026/04/13
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 检测当前脚本的运行环境
 * 该函数通过多种方式判断脚本是在何种环境下运行的
 * 可能的运行环境包括：Visual Studio Code, SciTE4AutoHotkey, 命令行界面, 直接运行等
 * 
 * @returns {unset | String} 返回运行环境的名称，可能的值包括:
 *   - "APP": 通过GUI应用程序运行
 *   - "CLI": 通过命令行界面运行
 *   - "Direct": 直接运行脚本
 *   - unset: 无法确定运行环境时返回未定义值
 */
HowRun() {
    /*
    * Visual Studio Code
    * SciTE4AutoHotkey
    * ……
    */
    global A_DebuggerName
    if IsSet(A_DebuggerName) {
        return A_DebuggerName
    }
    try {
        FileOpen("*", "w")
        return "APP"
    } catch OSError {

    }
    if A_Args.Length or DllCall("AttachConsole", "uint", -1) {
        return "CLI"
    }
    return "Direct"
}
if A_ScriptName = "HowRun.ahk"
    MsgBox HowRun()