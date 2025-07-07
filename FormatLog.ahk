#Requires AutoHotkey v2.0

/**
 * 格式化日志
 * @param Explain 说明
 * @param {Integer} LogLevel 日志等级 DEBUG, INFO, WARN, ERROR
 * @param {String} Source 来源
 * @returns {String} 格式化后的日志
 */
FormatLog(Explain, LogLevel := 1, Source := "") {
    static logLevelDict := ["DEBUG", "INFO", "WARN", "ERROR"]
    date := FormatTime(, "yyyy-MM-dd")
    time := FormatTime(, "HH:mm:ss")
    FormatStr := Source ? "{1} {2} {3:-5} - [{4}] {5}`n" : "{1} {2} {3:-5} - {5}`n"
    return Format(FormatStr, date, time, logLevelDict[LogLevel], Source, Explain)
}