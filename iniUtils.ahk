/************************************************************************
 * @description 类`iniUtils`，包含两个方法`ToObject`将ini转为类中的对象；`ToString` 将对象转为ini格式字符串。
 * @author Summer1Solstice
 * @date 2026/07/04
 * @version 0.0.1
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 读取ini文件，将ini转为类中的对象属性。
 * 访问格式：ini.[section].[key] 获取值；
 * 添加格式：ini.[section].[key] := value；
 * 忽略不在段内的键值对。
 */
class iniUtils {
    __New(iniPath) {
        this.iniPath := iniPath
        this.ToObject()
    }
    /**
     * 读取ini文件，将ini转为对象。
     */
    ToObject(iniPath := this.iniPath) {
        SectionList := StrSplit(IniRead(iniPath), "`n")
        for i in SectionList {
            obj := this.%i% := {}
            iniText := IniRead(iniPath, i)
            loop parse iniText, "`n" {
                pos := InStr(A_LoopField, "=")
                if pos {
                    key := SubStr(A_LoopField, 1, pos - 1)
                    value := SubStr(A_LoopField, pos + 1)
                    obj.%key% := value
                } else {
                    obj.%A_LoopField% := ""
                }
            }
        }
        this.SectionList := SectionList
    }
    /**
     * 将对象转为ini格式字符串。
     * 由于对象属性不保留顺序，转换后丢失原有的排列顺序。
     * @returns {String} ini格式字符串。
     */
    ToString() {
        str := ""
        for i in this.OwnProps() {
            if i = "SectionList" or i = "iniPath" {
                continue
            }
            obj := this.%i%
            if not (obj is Object) {
                continue
            }
            str .= "[" i "]`n"
            for j in obj.OwnProps() {
                key := j
                value := obj.%j%
                if not (value is Primitive) {
                    throw "iniUtils: value must be Primitive type"
                }
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