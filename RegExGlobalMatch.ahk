#Requires AutoHotkey v2.0

/**
 * RegExMatch的全局模式匹配
 * 
 * @param str   被查找的字符串
 * @param ex    正则表达式
 * @returns {Array} 返回数组，元素是匹配对象(RegExMatchInfo)
 */
RegExGlobalMatch(str, ex) {
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
/*示例
* RegExMatchInfo的使用方法，详见：https://www.autohotkey.com/docs/v2/lib/RegExMatch.htm#MatchObject
* match_arr := RegExGlobalMatch("hello world", "\w")
* OutputDebug(match_arr[1][0]) 输出 h
* OutputDebug(match_arr[2][0]) 输出 e
*/
