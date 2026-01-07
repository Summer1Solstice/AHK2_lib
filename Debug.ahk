#Requires AutoHotkey v2.0

/**
 * 将变量转换为字符串表示形式
 * 该函数递归地将各种类型的变量转换为其字符串表示形式，包括基本类型、数组、映射、函数和对象等
 * 对于不同类型的值会进行相应的格式化处理：字符串会被加上引号，数组和对象会被转换为类JSON格式
 * 
 * @param val 要转换的变量，可以是任意类型
 * @returns {String} 返回变量的字符串表示形式
 */
stringify(val) {
    if val is Primitive {
        if val is String {
            return '"' val '"'
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
        result := "{"
        for k, v in val {
            result .= stringify(k) ": " stringify(v) ", "
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
Debug(val) {
    OutputDebug stringify(val) '`n'
}