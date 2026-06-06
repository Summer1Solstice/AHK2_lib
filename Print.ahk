/************************************************************************
 * @description `Print`在标准输出或调试控制台输出，字符串化变量。
 * `stringify`函数，用于字符串化变量，不遵守`JSON`规范，不包含格式美化。
 * 而是尽可能还原能在AHK中直接定义相同变量的文本。
 * 字符串变量中的换行符、制表符、回车符会被替换为相应的AHK转义字符。
 * @author Summer1Solstice
 * @date 2026/06/06
 * @version 0.1.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 将变量转换为字符串表示形式
 * 该函数递归地将各种类型的变量转换为其字符串表示形式，包括基本类型、数组、映射、函数和对象等
 * 
 * @param val 要转换的变量，可以是任意类型
 * @returns {String} 返回变量的字符串表示形式
 */
stringify(val) {
    if val is Primitive {
        if val is Number {
            return val
        }
        if val is String {
            return '"' StrReplace(StrReplace(StrReplace(val, "`n", "``n"), "`r", "``r"), "`t", "``t") '"'
        }
        return val
    }
    if val is Array {
        result := "["
        for i in val {
            result .= stringify(i) ", "
        }
        result := RTrim(result, ", ")
        return result "]"
    }
    if val is Map {
        result := "Map("
        for k, v in val {
            result .= stringify(String(k)) ", " stringify(v) ", "
        }
        result := RTrim(result, ", ")
        return result ")"
    }
    if val is Func {
        return val.name
    }
    if val is Object {
        result := "{"
        for k, v in val.OwnProps() {
            result .= Trim(stringify(k), '"') ": " stringify(v) ", "
        }
        result := RTrim(result, ", ")
        return result "}"
    }
}

/**
 * 将变量转换为字符串形式并输出到调试窗口
 * 该函数使用 stringify 函数将变量转换为字符串表示形式，然后输出到调试窗口
 * 对于不同类型的变量（基本类型、数组、映射、函数、对象等）会进行相应的格式化输出
 * 
 * @param val 要输出的变量，可以是任意类型
 * @returns 无返回值，直接输出到调试窗口
 */
Print(val) {
    str := stringify(val) '`n'
    try {
        FileAppend(str, "*")
    } catch {
        OutputDebug(str)
    }
}
;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    Print([Map("1", { a: "b`nc" })])
}
;@Ahk2Exe-IgnoreEnd
