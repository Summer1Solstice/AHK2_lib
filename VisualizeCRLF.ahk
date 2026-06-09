/************************************************************************
 * @description 可视化\n \r \t
 * @author 
 * @date 2026/06/08
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 可视化\n \r \t
 * @param str 待处理的字符串
 * @returns {String} 处理后的字符串
 */
VisualizeCRLF(str) {
    for i in [["`n", "``n`n"], ["`r", "``r"], ["`t", "``t"]] {
        str := RegExReplace(str, i*)
    }
    return str
}

;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    str := "    diyihang`r`n    di2hang`n    di3hang`t1111    "
    OutputDebug VisualizeCRLF(str)
}
;@Ahk2Exe-IgnoreEnd
