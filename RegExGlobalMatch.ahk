/************************************************************************
 * @description 提供对字符串进行全局正则匹配的功能，返回包含所有匹配项（RegExMatchInfo 对象）的数组。
 * @author Summer1Solstice
 * @date 2026/04/13
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * RegExMatch的全局模式匹配
 * 
 * @param &str   被查找的字符串
 * @param ex    正则表达式
 * @returns {Array} 返回数组，元素是匹配对象(RegExMatchInfo)
 */
RegExGlobalMatch(&str, ex) {
    SPos := 1
    result := Array()
    result.Default := ""
    while RegExMatch(str, ex, &M, SPos) {
        result.Length := A_Index
        result[A_Index] := M
        SPos := M.Pos + M.Len
    }
    return result
}
;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    ; RegExMatchInfo的使用方法，详见：https: // www.autohotkey.com / docs / v2 / lib / RegExMatch.htm#MatchObject
    match_arr := RegExGlobalMatch(&s := "hello world", "\w")
    OutputDebug(match_arr[1][0]) ; 输出 h
    OutputDebug(match_arr[2][0]) ; 输出 e
}
;@Ahk2Exe-IgnoreEnd
