/************************************************************************
 * @description 类`iniUtils`，包含两个方法`to_object`将ini转为类中的对象；`to_string` 将对象转为ini格式字符串。
 * @author Summer1Solstice
 * @date 2026/04/13
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0
#Include Print.ahk
class iniUtils {
    __New(iniPath) {
        this.iniPath := iniPath
        this.to_object()
    }
    /**
     * 读取ini文件，将ini转为对象。
     * 访问格式：ini.section.key 获取值。
     * 添加格式：ini.section.key = value
     */
    to_object() {
        iniPath := this.iniPath
        SectionList := StrSplit(IniRead(iniPath), "`n")
        for i in SectionList {
            obj := this.%i% := {}
            obj.__keys := []
            iniText := IniRead(iniPath, i)
            loop parse iniText, "`n" {
                pos := InStr(A_LoopField, "=")
                if pos {
                    key := SubStr(A_LoopField, 1, pos - 1)
                    obj.__keys.push(key)
                    value := SubStr(A_LoopField, pos + 1)
                    obj.%key% := value
                } else {
                    obj.%A_LoopField% := ""
                    obj.__keys.push(A_LoopField)
                }
            }
        }
        this.SectionList := SectionList
    }
    /**
     * 将对象转为ini格式字符串。
     * @returns {String} ini格式字符串。
     */
    to_string() {
        str := ""
        for i in this.SectionList {
            str .= "[" i "]`n"
            obj := this.%i%
            for j in obj.__keys {
                key := j
                value := obj.%j%
                if value {
                    str .= key "=" value "`n"
                } else {
                    str .= key "`n"
                }
            }
        }
        return str
    }
}