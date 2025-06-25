#Requires AutoHotkey v2.0


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