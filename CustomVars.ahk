#Requires AutoHotkey v2.0

; \r
C_CR := "`r"
; \n
C_LF := "`n"
; \r\n
C_CRLF := "`r`n"
; Zero-width-space
C_ZeroWideSpace := Chr(0x200B)
; 1s = 1000ms
C_Seconds := 1000
; 1m = 60s = 60000ms
C_Minutes := 60 * C_Seconds
; 1h = 60m = 3600000ms
C_Hours := 60 * C_Minutes
; 1d = 24h = 86400000ms
C_Days := 24 * C_Hours