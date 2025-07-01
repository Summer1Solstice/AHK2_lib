/************************************************************************
 * @description 根据字符串给出结构的AHK字面量对象，不考虑内存对齐。
 * @description 试验作品
 * @date 2025/07/01
 * @version 0.0.1
 * @todo 考虑内存对齐、集成到Predefined.ahk、直接生成AHK对象
 ***********************************************************************/

#Requires AutoHotkey v2.0
#Include Predefined.ahk

Struct_text := "
(
typedef struct _TIME_ZONE_INFORMATION {
  LONG       Bias;
  WCHAR      StandardName[32];
  SYSTEMTIME StandardDate;
  LONG       StandardBias;
  WCHAR      DaylightName[32];
  SYSTEMTIME DaylightDate;
  LONG       DaylightBias;
} TIME_ZONE_INFORMATION, *PTIME_ZONE_INFORMATION, *LPTIME_ZONE_INFORMATION;
)"
result := ""
start := 0
size := 0
loop parse Struct_text, "`n" {
    if RegExMatch(A_LoopField, "\s*(\w+)\s*\{|\}", &match) {
        if match[1] {
            result .= match[1] " := {`n"
        }
        continue
    }
    RegExMatch(A_LoopField, "\s*(\w+)\s*(\w+)(\[\d+\])*", &match)
    member := match[2], data_type := match[1], list_len := match[3]
    if DTypes.HasOwnProp(data_type) {
        size := DTypes.%data_type%.Size
        if list_len {
            list_len := Trim(list_len, "[]")
            size := DTypes.%data_type%.Size * list_len
        }
        result .= Format('{1}:{{}Start:{2},Size:{3},TypeA:"{4}"{}},`n', member, start, size, DTypes.%data_type%.TypeA)
    } else if Struct.HasOwnProp(data_type) {
        size := Struct.%data_type%.size
        result .= Format('{1}:{{}Start:{2},Size:{3},TypeA:"Struct"{}},`n', member, start, size)
    }
    start += size
}
result .= "Size:" start "`n}"
OutputDebug result