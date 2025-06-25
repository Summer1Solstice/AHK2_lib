#Requires AutoHotkey v2.0

class ini {
    /**
     * 解析ini字符串
     * 
     * @param iniStr {String} ini字符串
     * @returns {Map} 解析后的Map对象
     */
    static Parse(iniStr) {
        result := Map()
        loop parse iniStr, "`n" {
            pos := InStr(A_LoopField, "=")
            if pos {
                result.Set(SubStr(A_LoopField, 1, pos - 1), SubStr(A_LoopField, pos + 1))
            } else {
                result.Set(A_LoopField, "")
            }
        }
        return result
    }
    /**
     * 将Map对象转换为ini字符串
     * 
     * @param iniMap {Map} 要转换的Map对象
     * @returns {String} 转换后的ini字符串
     */
    static Stringify(iniMap) {
        result := ""
        for k, v in iniMap {
            if v {
                result .= k "=" v "`n"
            } else {
                result .= k "`n"
            }
        }
        return result
    }
}