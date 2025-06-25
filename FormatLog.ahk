#Requires AutoHotkey v2.0

/**
 * 生成用于输出的日志文本
 * 
 * @param Explain 日志说明
 * @param {Integer} LogLevel["DEBUG"|"INFO"|"WARN"|"ERROR"] 
 * @param {String} Script 当前脚本名，自动获取
 * @param {String} FuncName 当前函数名，自动获取
 * @returns {String} 输出 “时间 [日志级别] 脚本名: 函数名 日志说明” 格式的文本
 */
FormatLog(Explain, LogLevel := 1, Script := A_ScriptName, FuncName := A_ThisFunc) {
    static logLevelDict := ["DEBUG", "INFO", "WARN", "ERROR"]
    time := FormatTime(, "yyyy-MM-dd HH:mm:ss")
    Log := Format("{1} [{2}] {3}: {4} {5}", time, logLevelDict[LogLevel], Script, FuncName, Explain)
    return Log
}