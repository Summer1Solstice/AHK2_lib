#Requires AutoHotkey v2.0
/** 为Windows的C++数据类型和结构预定义字节长度
 * @description 预定义字节长度
 * @learn Windows 数据类型 https://learn.microsoft.com/zh-cn/windows/win32/winprog/windows-data-types
 * @learn 数据类型范围 https://learn.microsoft.com/zh-cn/cpp/cpp/data-type-ranges?view=msvc-170
 * @todo 更多预定义字节长度的数据类型，在AutoHotkey提取这些数据类型对应的Type
 */
class C {
    static bool := 1
    static char := 1
    static int := 4
    static float := 4
    static double := 8
    static wchar_t := 2
    static short := 2
    /*****************************************************************************/
    ; type: UShort
    static WORD := C.short
    ; type: Int Short
    static LONG := 4
    ; type: UShort [StrGet]
    static WCHAR := C.wchar_t
    /*****************************************************************************/
    ; SYSTEMTIME 结构
    static SYSTEMTIME := C.WORD * 8
    ; TIME_ZONE_INFORMATION 结构
    static TIME_ZONE_INFORMATION := (C.LONG + C.WCHAR * 32 + C.SYSTEMTIME) * 2 + C.LONG
}