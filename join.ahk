#Requires AutoHotkey v2.0

/**
 * 将数组中的元素拼接成一个字符串，使用指定的分隔符连接。
 * 
 * @param arr 要拼接的数组
 * @param {String} sep 每个元素之间的分隔符，默认为空格
 * @returns {String} 拼接后的字符串
 */
join(arr, sep := " ") {
    result := ""
    loop arr.Length -1 {
        result .= arr[A_Index] . sep
    }
    return result .= arr[-1]
}
Array.Prototype.DefineProp("Join", { call: join })