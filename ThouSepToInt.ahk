/************************************************************************
 * @description 千分位数值转整数
 * @author 
 * @date 2026/07/21
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * @description 千分位数值转整数
 * @param args 千分位数值；如：123, 456, 789
 * @returns {Number} 整数
 */
ThouSepToInt(args*) {
    result := 0
    loop args.Length {
        result += args[-A_Index] * (1000 ** (A_Index - 1))
    }
    return result
}
;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    OutputDebug(ThouSepToInt(123, 456, 789))
}
;@Ahk2Exe-IgnoreEnd
