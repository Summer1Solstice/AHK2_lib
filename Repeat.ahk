#Requires AutoHotkey v2.0

/**
 * 重复指定的字符串 `count` 次，并将结果返回。
 * 
 * @param text 要重复的字符串
 * @param count 重复次数，必须为非负整数
 * @returns {String} 重复后的字符串
 */
Repeat(text, count) {
    result := "", step := text
    loop count {
        result .= step
    }
    return result
}