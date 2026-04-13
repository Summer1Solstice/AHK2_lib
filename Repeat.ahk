/************************************************************************
 * @description 重复指定文本指定次数，并返回最终结果字符串。
 * @author Summer1Solstice
 * @date 2026/04/13
 * @version 0.0.0
 ***********************************************************************/

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
(Object.Prototype.DefineProp)(String.Prototype, "Repeat", { call: Repeat })