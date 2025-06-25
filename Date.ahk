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
    ;=======================================================================
    ; UTC时间戳(Seconds)
    static Unix_Timestamp => DateDiff(A_NowUTC, Date.Epoch, "Seconds")
    ; ms时间戳(millisecond)
    static ms_Timestamp => DateDiff(A_NowUTC, Date.Epoch, "Seconds") . A_MSec
    ;=======================================================================
    ; 日期
    static Local_Date => FormatTime(, "LongDate")
    static UTC_Date => FormatTime(A_NowUTC, "LongDate")
    ; 时间
    static Local_Time => FormatTime("T0", "Time")
    static UTC_Time => FormatTime(A_NowUTC " T0", "Time")
    ; 日期时间
    static Local_Date_Time => FormatTime("T0 R")
    static UTC_Date_Time => FormatTime(A_NowUTC " T0 R")
    static GetTimeZoneInfo() {
        struct := Buffer(C.TIME_ZONE_INFORMATION, 0)
        result := DllCall("GetTimeZoneInformation", "Ptr", struct)
        Date.Time_Zone_Offset := Abs(NumGet(result, "Short")) * 60
    }
}