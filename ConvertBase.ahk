#Requires AutoHotkey v2.0


/**
 * 进制转换函数，将指定进制的数字字符串转换为另一种进制的字符串表示
 * @param nptr - 需要转换的数字字符串，可以是各种进制表示的数字
 * @param InputBase - 输入数字的进制基数，范围2-36，如10表示十进制，16表示十六进制
 * @param OutputBase - 输出数字的进制基数，范围2-36，转换后的结果将使用此进制表示
 * @returns {String} - 返回转换后的数字字符串，使用指定的OutputBase进制表示
 */
ConvertBase(nptr, InputBase, OutputBase) {
    VarSetStrCapacity(&s, 66)
    value := DllCall("msvcrt.dll\_wcstoui64", "Str", nptr, "UInt", 0, "UInt", InputBase, "CDECL Int64")
    DllCall("msvcrt.dll\_i64tow", "Int64", value, "Str", s, "UInt", OutputBase, "CDECL")
    Return s
}
; 10 -> 16
hex := (n) => ("0x" ConvertBase(n, 10, 16))
; 10 -> 2
bin := (n) => ("0b" ConvertBase(n, 10, 2))
; 10 -> 8
oct := (n) => ("0o" ConvertBase(n, 10, 8))
; xx -> 10
int := (Input, InputBase := 10) => (ConvertBase(Input, InputBase, 10))

; 10 -> 2
IntToBin := (i) => ((i >> 1 ? IntToBin(i >> 1) : "") i & 1)
; 2 -> 10
BinToInt := (n) => (StrLen(n) > 1 ? BinToInt(SubStr(n, 1, -1)) << 1 : 0) | SubStr(n, -1)
; 10 -> 16
IntToHex := (i) => (Format("{:#x}", i))
; 16 -> 10
HexToInt := (h) => (Format("{:d}", h))

/**
 * 整数转2-52进制
 * @param int 正整数
 * @param base 基数
 * @returns {String} 与常见的进制规范不同，仅为简单的进位制
 */
IntTo_(int, base) {
    if ( not IsInteger(int)) or (int <= 0) {
        throw ValueError("参数错误，必须是正整数。")
    }
    if base < 2 or base > 62 {
        throw ValueError("基数必须在2-62之间。")
    }
    static chars := StrSplit("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    result := ""
    while int > 0 {
        result := chars[mod(int, base) + 1] . result
        int //= base
    }
    return result
}