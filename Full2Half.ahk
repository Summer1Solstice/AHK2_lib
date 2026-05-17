/************************************************************************
 * @description 全角字符、半角字符互转
 * @author 
 * @date 2026/05/08
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 全角字符、半角字符互转
 * @param {String} char 单个全角或半角字符
 * @returns {String} 转换后的字符
 */
full2half(char) {
    if char ~= "[!-~]" {    ; U+0021 - U+007E
        return Chr(Ord(char) + 0XFEE0)
    }
    if char ~= "[！-～]" {  ; U+FF01 - U+FF5E
        return Chr(Ord(char) - 0XFEE0)
    }
}