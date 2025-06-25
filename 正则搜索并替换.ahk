#Requires AutoHotkey v2.0

/**
 * 对一个字符串进行批量正则搜索并替换
 * 
 * @param {String} text 要搜索和替换其内容的字符串
 * @param {Array} search 包含一个或多个正则表达式的数组
 * @param {Array} replace 与搜索表达式对应的替换字符串的数组
 * @param {String} default_replace 没有匹配项时使用的默认替换字符串
 * @returns {String} 
 */
SearchAndReplace(text, search, replace := [], default_replace := "") {
    if search.Length > replace.Length {
        replace.length := search.Length
        replace.Default := default_replace
    }
    for i in search {
        text := RegExReplace(text, i, replace[A_Index])
    }
    return text
}