/************************************************************************
 * @description 将当前时间偏移指定的时间
 * @author 
 * @date 2026/10/25
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0


/**
 * 将当前时间偏移指定的时间
 * @param Days 天
 * @param Hours 小时
 * @param Minutes 分
 * @param Seconds 秒
 */
NowShift(Days?, Hours?, Minutes?, Seconds?) {
    result := A_Now
    if IsSet(Days) {
        result := DateAdd(result, Days, "Days")
    }
    if IsSet(Hours) {
        result := DateAdd(result, Hours, "Hours")
    }
    if IsSet(Minutes) {
        result := DateAdd(result, Minutes, "Minutes")
    }
    if IsSet(Seconds) {
        result := DateAdd(result, Seconds, "Seconds")
    }
    return result
}


;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    OutputDebug(FormatTime(NowShift(, 8), "yyyy年MM月dd日 HH时mm分ss秒"))
}
;@Ahk2Exe-IgnoreEnd
