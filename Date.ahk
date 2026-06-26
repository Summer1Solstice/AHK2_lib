/************************************************************************
 * @description `FmtTUT`工具类，对内置函数`FormatTime`的包装。
 * `Date`、`Time`、`DateTime`、`TimeStamp`，提供日期、时间、日期时间、时间戳相关的派生类。
 * @author Summer1Solstice
 * @date 2026/06/26
 * @version 0.1.1
 ***********************************************************************/

#Requires AutoHotkey v2.0

; FmtTUT，全称FormatTimeUtils
class FmtTUT {
    /**
     * 转换为长日期格式
     * 1970年1月1日
     * @param Date 
     * @returns {String} 
     */
    static LongDate(Date) => FormatTime(Date, "LongDate")
    /**
     * 转换为时间格式
     * 0:00:00
     * @param Time 
     * @returns {String} 
     */
    static TimeT0(Time) => FormatTime(Time " T0", "Time")
    /**
     * 转换为日期时间格式
     * 1970年1月1日 0:00:00
     * @param DateTime 
     * @returns {String} 
     */
    static DateTimeT0R(DateTime) => FormatTime(DateTime " T0 R")
    /**
     * 转换为RFC1123格式
     * Thu, 1 Jan 1970 00:00:00 GMT
     * @param DateTime 
     * @returns {String} 
     */
    static RFC1123(DateTime) => FormatTime(DateTime " L0x0409", "ddd, d MMM yyyy HH:mm:ss 'GMT'")
    ; UTC历元
    static Epoch := "19700101000000"
    /**
     * 转换为时间戳
     * @param DateTime 
     * @returns {Integer} 
     */
    static TimeStamp(DateTime) => DateDiff(DateTime, this.Epoch, "Seconds")
    ; 时区偏移量(Seconds)
    static TimeZoneOffset := 28800
    ; 获取时区信息
    static GetTimeZoneInfo() {
        TZI := Buffer(172, 0)
        DllCall("GetTimeZoneInformation", "Ptr", TZI)
        return FmtTUT.TimeZoneOffset := Abs(NumGet(TZI, "Short") * 60)
    }
}
; 日期
class Date {
    /**
     * 分解日期，当参数为A_Now时，返回等同于内置变量。
     * @param {String} Date 
     * @returns {Object} Year: 年，Month: 月，Day: 日
     */
    static Split(Date := A_Now) {
        return {
            Year: FormatTime(Date, "yyyy"),
            Month: FormatTime(Date, "MM"),
            Day: FormatTime(Date, "dd"),
        }
    }
    ; 本地日期
    static Local => FmtTUT.LongDate(A_Now)
    ; UTC日期
    static UTC => FmtTUT.LongDate(A_NowUTC)
}
; 时间
class Time {
    /**
     * 分解时间，当参数为A_Now时，返回等同于内置变量。
     * @param {String} Date 
     * @returns {Object} Hour: 小时，Min: 分钟，Sec: 秒
     */
    static Split(Date := A_Now) {
        return {
            Hour: FormatTime(Date, "HH"),
            Min: FormatTime(Date, "mm"),
            Sec: FormatTime(Date, "ss"),
        }
    }
    ; 本地时间
    static Local => FmtTUT.TimeT0(A_Now)
    ; UTC时间
    static UTC => FmtTUT.TimeT0(A_NowUTC)
}
; 日期时间
class DateTime {
    ; 本地日期时间
    static Local => FmtTUT.DateTimeT0R(A_Now)
    ; UTC日期时间
    static UTC => FmtTUT.DateTimeT0R(A_NowUTC)
    ; RFC1123日期时间
    static RFC1123 => FmtTUT.RFC1123(A_NowUTC)
}
class TimeStamp {
    ; UTC时间戳(Seconds)
    static UTC => FmtTUT.TimeStamp(A_NowUTC)
    ; UTC毫秒时间戳(millisecond)
    static ms => FmtTUT.TimeStamp(A_NowUTC) . A_MSec
    ; 时间戳转日期时间
    static toDateTime(TimeStamp) => DateAdd(FmtTUT.Epoch, TimeStamp, "Seconds")
}

;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    for C in [FmtTUT, Date, Time, DateTime, TimeStamp] {
        OutputDebug("=====" C.Prototype.__Class "=====`n")
        for P in C.OwnProps() {
            if P ~= "__|Prototype" {
                continue
            }
            if C.%P% is Primitive {
                OutputDebug(p "=" C.%P% "`n")
            } else {
                if C.%P%.MinParams > 1 {
                    continue
                }
                try OutputDebug(p "=" C.%P%() "`n")
            }
        }
    }
}
;@Ahk2Exe-IgnoreEnd
