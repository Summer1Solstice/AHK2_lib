#Requires AutoHotkey v2.0

; 隐藏控制台窗口
HideConsoleWindow() {
    DllCall("AllocConsole") ; 分配控制台窗口
    ; DllCall("SetConsoleCP", "uint", DllCall("GetConsoleCP"))    ; 设置控制台编码为当前系统编码。UTF-8：65001
    ConsoleWindowHandle := DllCall("GetConsoleWindow", "ptr")   ; 获取控制台窗口句柄
    ; 隐藏控制台窗口后最小化窗口，避免窗口影响WinActive检查活动窗口
    WinHide(ConsoleWindowHandle)
    WinMinimize(ConsoleWindowHandle)
    WinHide(ConsoleWindowHandle)
}

/**
 * 执行单条命令并等待其完成，返回命令的标准输出。
 * 
 * @param command 要执行的命令字符串
 * @returns {String} 命令的标准输出内容
 */
RunWaitOne(command) {
    shell := ComObject("WScript.Shell")
    ; 通过 cmd.exe 执行单条命令
    exec := shell.Exec(A_ComSpec " /C " command)
    ; 读取并返回命令的输出
    return exec.StdOut.ReadAll()
}

/**
 * 在同一个命令行会话中执行多条命令，并返回所有命令的标准输出。
 * 
 * @param commands 多条命令字符串，各命令之间用换行符分隔
 * @returns {String} 所有命令的标准输出内容
 */
RunWaitMany(commands) {
    shell := ComObject("WScript.Shell")
    ; 打开 cmd.exe 禁用命令回显
    exec := shell.Exec(A_ComSpec " /Q /K echo off")
    ; 发送并执行命令, 使用新行分隔
    exec.StdIn.WriteLine(commands "`nexit")  ; 总是在最后退出!
    ; 读取并返回所有命令的输出
    return exec.StdOut.ReadAll()
}

/**
 * 运行指定的命令并隐藏窗口
 * 
 * @param command 要运行的命令
 */
RunHidden(command) {
    shell := ComObject("WScript.Shell")
    ; 使用 shell.Run 并添加隐藏窗口参数 (0 = 隐藏)
    shell.Run(A_ComSpec " /C " command, 0, true)
}

if A_ScriptName = "RunWait.ahk" {
    HideConsoleWindow()
}