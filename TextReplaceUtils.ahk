/************************************************************************
 * @description 进行多次文本替换的包装函数
 * @author 
 * @date 2026/05/08
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 多次StrReplace替换，无返回值
 * @param str 以 &value 传入的字符串
 * @param list 嵌套列表，内层列表以解包形式传入内置参数 StrReplace
 */
StrReplace_s(&str, list) {
    for i in list {
        str := StrReplace(str, i*)
    }
}
/**
 * 多次RegExReplace替换，无返回值
 * @param str 以 &value 传入的字符串
 * @param list 嵌套列表，内层列表以解包形式传入内置参数 RegExReplace
 */
RegExReplace_s(&str, list) {
    for i in list {
        str := RegExReplace(str, i*)
    }
}