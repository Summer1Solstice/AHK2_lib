/************************************************************************
 * @description 批量添加WinMerge的替换过滤器
 * @author 
 * @date 2026/11/20
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

class WinMergeSubstitutionFilters {
    RegPath := "HKEY_CURRENT_USER\SOFTWARE\Thingamahoochie\WinMerge\SubstitutionFilters"
    StartIndex := RegRead(this.RegPath, "Values")
    ValueType := Map()
    __New() {
        this.ValueType.Default := "REG_DWORD"
        this.ValueType.Set([
            "Pattern", "REG_SZ",
            "Replacement", "REG_SZ",
        ]*)
    }
    __Delete() {
        RegWrite(this.StartIndex, this.ValueType["Values"], this.RegPath, "Values")
    }
    Add(
        Pattern, Replacement,
        Enabled := true,
        UseRegExp := false, CaseSensitive := false, MatchWholeWordOnly := false
    ) {
        index := Format("{1:02}", this.StartIndex)
        for i in [
            "Pattern", "Replacement",
            "Enabled",
            "UseRegExp", "CaseSensitive", "MatchWholeWordOnly"
        ] {
            RegWrite(%i%, this.ValueType[i], this.RegPath, i . index)
        }
        this.StartIndex++
    }
}
;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    t := WinMergeSubstitutionFilters()
    list := ["的", "地", "得"]
    for i in list {
        for j in list {
            if i != j {
                t.Add(i, j)
            }
        }
    }
}
;@Ahk2Exe-IgnoreEnd
