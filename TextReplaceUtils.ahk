/************************************************************************
 * @description 进行多次文本替换的包装函数
 * @author 
 * @date 2026/05/08
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0
__dependency(Fn, &str, list) {
    if Type(Fn) != "Func" or not Fn.IsBuiltIn {
        throw "需要传入内置函数 StrReplace 或 RegExReplace"
    }
    if Type(str) != "String" {
        throw "需要传入字符串，而不是 " Type(str)
    }
    if Type(list) != "Array" {
        throw "需要传入数组，而不是 " Type(list)
    }
    for i in list {
        if Type(i) != "Array" {
            throw "数组元素不是数组"
        }
        str := Fn(str, i*)
    }
}
/**
 * 多次StrReplace替换，无返回值
 * @param str 以 &value 传入的字符串
 * @param list 嵌套列表，内层列表以解包形式传入内置参数 StrReplace
 */
StrReplace_s := __dependency.Bind(StrReplace)

/**
 * 多次RegExReplace替换，无返回值
 * @param str 以 &value 传入的字符串
 * @param list 嵌套列表，内层列表以解包形式传入内置参数 RegExReplace
 */
RegExReplace_s := __dependency.Bind(RegExReplace)

;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    s := "abacadae"
    StrReplace_s(&s, [["b"], ["c"], ["d"], ["e"]])
    OutputDebug s "`n"
    s := "a1a2a3a4"
    RegExReplace_s(&s, [["\d"], ["a", "A"]])
    OutputDebug s "`n"
}
;@Ahk2Exe-IgnoreEnd
