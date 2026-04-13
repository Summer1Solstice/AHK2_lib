/************************************************************************
 * @description 基于`OutputDebug`将变量字符串化输出到调试控制台。
 * 还包含一个`stringify`函数，用于字符串化变量，不遵守`JSON`规范。
 * @author Summer1Solstice
 * @date 2026/04/13
 * @version 0.0.0
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
            return '"' val '"'
        }
        return val
    }
    if val is Array {
        result := "["
        loop val.Length - 1 {
            result .= stringify(val[A_Index]) ", "
        }
        result .= stringify(val[-1])
        return result "]"
    }
    if val is Map {
        result := "{"
        for k, v in val {
            result .= stringify(String(k)) ": " stringify(v) ", "
        }
        result := RTrim(result, ", ")
        return result "}"
    }
    if val is Func {
        return val.name "()"
    }
    if val is Object {
        result := "{"
        for k, v in val.OwnProps() {
            result .= stringify(k) ": " stringify(v) ", "
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
    OutputDebug stringify(val) '`n'
}