/************************************************************************
 * @description 生成包含日期时间、日志等别、函数名和说明的格式化日志文本
 * @author Summer1Solstice
 * @date 2026/04/13
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 格式化日志
 * @param Text log文本
 * @param {Integer} Level 日志等级 DEBUG, INFO, WARN, ERROR
 * @param {String} Source 来源
 * @returns {String} 格式化后的日志
 */
FormatLog(Text, Level := 1, Source := A_ThisFunc) {
    static LevelList := ["DEBUG", "INFO", "WARN", "ERROR", "FATAL"]
    date := FormatTime(, "yyyy-MM-dd")
    time := FormatTime(, "HH:mm:ss")
    FormatStr := Source ? "{1} {2} {3:-5} - [{4}] {5}`n" : "{1} {2} {3:-5} - {5}`n"
    return Format(FormatStr, date, time, LevelList[Level], Source, Text)
}