#Requires AutoHotkey v2.0

/**
 * 进制转换函数，将指定进制的数字字符串转换为另一种进制的字符串表示
 * 
 * @param InputBase 输入数字的进制基数 (2-36)
 * @param OutputBase 输出数字的进制基数 (2-36)
 * @param nptr 待转换的数字字符串
 * @returns {String} 转换后的数字字符串
 */
ConvertBase(InputBase, OutputBase, nptr)
{
    VarSetStrCapacity(&s, 66)
    value := DllCall("msvcrt.dll\_wcstoui64", "Str", nptr, "UInt", 0, "UInt", InputBase, "CDECL Int64")
    DllCall("msvcrt.dll\_i64tow", "Int64", value, "Str", s, "UInt", OutputBase, "CDECL")
    Return s
}
; 10 -> 16
hex := (n) => ("0x" ConvertBase(10, 16, n))
; 10 -> 2
bin := (n) => ("0b" ConvertBase(10, 2, n))
; 10 -> 8
oct := (n) => ("0o" ConvertBase(10, 8, n))
; xx -> 10
int := (Input, InputBase := 10) => (ConvertBase(InputBase, 10, Input))