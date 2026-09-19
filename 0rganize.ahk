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
(`
    # AHK2_lib
    大部分脚本在单独运行时，会运行用于测试或演示的代码。
    其格式如下：
    ```AutoHotkey
    ;@Ahk2Exe-IgnoreBegin   ; 编译器指令，忽略以下代码
    ;如果脚本是从外部文件加载的, 这等同于 A_ScriptFullPath, 除非该行属于脚本的 #Include 文件之一.
    if A_LineFile = A_ScriptFullPath {
       ; 测试代码 
    }
    ;@Ahk2Exe-IgnoreEnd     ; 编译器指令，忽略代码结束
    ```
    # 包含脚本
    
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
