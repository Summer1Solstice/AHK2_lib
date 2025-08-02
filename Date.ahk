#Requires AutoHotkey v2.0
/************************************************************************
 * @description 日期时间与时间戳
 * @date 2025/06/24
 ***********************************************************************/
#Include Predefined.ahk
class Date {
    ; UTC历元
    static Epoch := "19700101000000"
    ; 时区偏移量(Seconds)
    static Time_Zone_Offset := 28800

    ; UTC时间戳(Seconds)
    static Unix_Timestamp => DateDiff(A_NowUTC, Date.Epoch, "Seconds")
    ; UTC时间戳(millisecond)
    static ms_Timestamp => DateDiff(A_NowUTC, Date.Epoch, "Seconds") . A_MSec

    ; 本地日期
    static Local_Date => FormatTime(, "LongDate")
    ; UTC日期
    static UTC_Date => FormatTime(A_NowUTC, "LongDate")
    ; 本地时间
    static Local_Time => FormatTime("T0", "Time")
    ; UTC时间
    static UTC_Time => FormatTime(A_NowUTC " T0", "Time")
    ; 本地日期时间
    static Local_Date_Time => FormatTime("T0 R")
    ; UTC日期时间
    static UTC_Date_Time => FormatTime(A_NowUTC " T0 R")

    ; 获取时区信息
    static GetTimeZoneInfo() {
        TZI := Buffer(Struct.TIME_ZONE_INFORMATION.Size, 0)
        DllCall("GetTimeZoneInformation", "Ptr", TZI)
        return Date.Time_Zone_Offset := Abs(NumGet(TZI, "Short") * 60)
    }
}
if A_ScriptName = "Date.ahk" {
    for i in Date.OwnProps() {
        ii := Date.%i%
        if ii is Primitive {
            OutputDebug i "=" ii "`n"
        } else if ii is Func {
            OutputDebug i "=" ii(Date) "`n"
        }
    }
}