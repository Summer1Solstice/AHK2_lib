#Requires AutoHotkey v2.0
; 为原始值添加属性
; 方法一 https://github.com/0w0Demonic/AquaHotkey/blob/main/src/Core/AquaHotkey.ahk
(Object.Prototype.DefineProp)(String.Prototype, "Repeat", { call: Repeat })
Repeat(this, count) => StrReplace(Format("{:" count "}", ""), " ", this)
OutputDebug "A".Repeat(3) "`n"

; 方法二 https://github.com/Descolada/AHK-v2-libraries
class Replaceable {
    static __New() {
        __ObjDefineProp := Object.Prototype.DefineProp
        for __Replaceable_Prop in Replaceable.OwnProps()
            if SubStr(__Replaceable_Prop, 1, 2) != "__"
                __ObjDefineProp(String.Prototype, __Replaceable_Prop, Replaceable.GetOwnPropDesc(__Replaceable_Prop))
    }
    static Length => StrLen(this)
}
OutputDebug "0123456789".Length "`n"

; 方法三 https://github.com/Autumn-one/ahk-standard-lib/blob/main/string.ahk
__DefProp := {}.DefineProp
__DefProp("".Base, 'Trim', { Call: __StrTrim })
__StrTrim(str, omitChars?) {
    return Trim(str, IsSet(omitChars) ? omitChars : unset)
}
OutputDebug "123   ".Trim() "`n"

;为对象衍生添加属性
; 方法一 https://github.com/Nich-Cebolla/AutoHotkey-Array/blob/main/Array.ahk
Array.Prototype.DefineProp("Join", { call: JOIN })
JOIN(this, sep := " ") {
    result := ""
    for i in this {
        if IsObject(i) {
            i := Type(i)
        }
        result .= i . sep
    }
    return RTrim(result, sep)
}
OutputDebug ["数", "组", "转", "字", "符", "串"].Join("")