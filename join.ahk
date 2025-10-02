#Requires AutoHotkey v2.0

/**
 * 将数组中的元素拼接成一个字符串，使用指定的分隔符连接。
 * JavaScript用法
 * @param arr 要拼接的数组
 * @param {String} sep 每个元素之间的分隔符，默认为空格
 * @returns {String} 拼接后的字符串
 */
join(arr, sep := " ") {
    result := ""
    loop arr.Length - 1 {
        result .= arr[A_Index] . sep
    }
    return result .= arr[-1]
}
Array.Prototype.DefineProp("Join", { call: join })


/** 以指定字符串作为分隔符，将 var 中所有的元素(的字符串表示)合并为一个新的字符串
 * Python用法
 * @param sep 间隔字符
 * @param var 要连接的元素序列
 * @returns {String} 返回通过指定字符连接序列中元素后生成的新字符串。
 */
; join(sep, var) {
;     if var is String {
;         var := StrSplit(var)
;     }
;     loop var.Length - 1 {
;         result .= var[A_Index] . sep
;     }
;     return result .= var[-1]
; }
; (Object.Prototype.DefineProp)(String.Prototype, "Join", { call: join })
