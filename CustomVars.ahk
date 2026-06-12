/************************************************************************
 * @description 自定义变量，命名格式仿照AHK内置变量，但是使用`C_`前缀。
 * @author Summer1Solstice
 * @date 2026/06/11
 * @version 0.0.5
 ***********************************************************************/

#Requires AutoHotkey v2.0

; C = [C]onstant = [C]ustom

; 字符常量
; \r
C_CR := "`r"
; \n
C_LF := "`n"
; \r\n
C_CRLF := "`r`n"
; Zero-width-space
C_ZeroWideSpace := Chr(0x200B)

; 时间常量
; 1s = 1000ms
C_Seconds := 1000
; 1m = 60s = 60000ms
C_Minutes := 60 * C_Seconds
; 1h = 60m = 3600000ms
C_Hours := 60 * C_Minutes
; 1d = 24h = 86400000ms
C_Days := 24 * C_Hours
;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    for i in [C_Seconds, C_Minutes, C_Hours, C_Days] {
        OutputDebug i "`n"
    }
}
;@Ahk2Exe-IgnoreEnd
; 数学常量
; 圆周率
C_Pi := 3.1415926535897931

; ; 速度常量
; ; 音速 340m/s
; C_SpeedOfSound := 340
; ; 光速 299792458m/s
; C_SpeedOfLight := 299792458

; ; 长度
; ; 天文单位
; C_AU := 149597870700
; ; 光年
; C_LightYear := 9460730472580800

; 编码
; 代码页标识符
C_GB2312 := "CP936"
C_GB18030 := "CP54936"
C_UTF8 := "CP65001"
C_ASCII := "CP1252"

; 数据长度
C_KByte := 1 << 10
C_MByte := 1 << 20
C_GByte := 1 << 30
C_TByte := 1 << 40

;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    for i in [C_KByte, C_MByte, C_GByte, C_TByte] {
        OutputDebug i "`n"
    }
}
;@Ahk2Exe-IgnoreEnd
