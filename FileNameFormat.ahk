/************************************************************************
 * @description 文件名格式化 WIP
 * @author 
 * @date 2026/11/15
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

class FileNameFormat {
    __New(NestedList) {
        this.NestedList := NestedList
    }
    NestedList := []
    Call(FileName, &out) {
        for i in this.NestedList {
            if RegExMatch(FileName, i[1]) {
                out := RegExReplace(FileName, i[1], i[2])
                return true
            }
        }
        return false
    }
}

;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {

}
;@Ahk2Exe-IgnoreEnd
