/************************************************************************
 * @description 脚本概述自动生成脚本
 * @author Summer1Solstice
 * @date 2026/04/13
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0
FileEncoding("UTF-8-RAW")

README := FileRead("README.md")
new_readme := "
(
# AHK2_lib
# 包含脚本`n
)"
Plus := false
add(text) {
    global new_readme .= text "`n"
}
loop files "*.ahk" {
    ScripFileName := A_LoopFileName
    if ScripFileName ~= "(String|Array|Map)Plus" {
        if Plus {
            continue
        }
        Plus := true
        text := "
        (`
            ### (String|Array|Map)Plus.ahk
            `#Include`其他(库|脚本)的聚合文件。
            被引入的文件通常自带对原生(对象|原始值)扩展的`DefineProp`语句。
        )"
        add(text "`n")
        continue
    }

    new_readme .= "### " ScripFileName "`n"
    flag := false
    desc := false

    loop read ScripFileName {
        if A_LoopReadLine ~= "/\*+" {
            flag := true
            continue
        }
        if A_LoopReadLine ~= "\*+/" {
            flag := false
            break
        }
        if desc {
            if InStr(A_LoopReadLine, "* @") {
                desc := false
                break
            } else {
                add(LTrim(A_LoopReadLine, " @*"))
            }
        }
        if Pos := InStr(A_LoopReadLine, "@description") {
            desc := true
            add(LTrim(SubStr(A_LoopReadLine, Pos + 12), " "))
        }
    }
    new_readme .= "`n"
}

fileobj := FileOpen("README.md", "w")
fileobj.Write(new_readme)
fileobj.Close()
; OutputDebug new_readme