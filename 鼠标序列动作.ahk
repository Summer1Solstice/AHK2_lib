/************************************************************************
 * @description 
 * @todo 配置的保存和多方案；写的很粗糙可能要重写规划一下
 * @date 2025/09/07
 ***********************************************************************/

#Requires AutoHotkey v2.0
CoordMode("Mouse", "Screen")

SequenceFile := "MouseSequence.txt"
Example := "
(
mm 551, 214
570, 230
1023, 295
mc , 551, 214
, 570, 230
)"

OnOff := true
SepTime := 100

parse(text) {
    result := []
    temp := ""
    loop parse text, "`n`r", " " {
        if not A_LoopField
            continue
        LineList := StrSplit(A_LoopField, [", ", " "])
        if LineList[1] ~= "[a-zA-Z]+" {
            Command := StrLower(LineList.RemoveAt(1))
        }
        switch Command {
            case "mm": result.Push(["MouseMove", LineList*]), temp := "MouseMove"
            case "mc": result.Push(["MouseClick", LineList*]), temp := "MouseClick"
            default: result.Push([temp, LineList*])
        }
    }
    return result
}
F1:: {
    global on_off := true
    list := parse(Example)
    while true {
        for i in list {
            if not on_off {
                Exit()
            }
            m := i.Clone()
            Command := m.RemoveAt(1)
            %Command%(m*)
            Sleep SepTime
        }
    }
}
XButton2:: {
    static fleg := 1
    if fleg {
        MouseGetPos &xpos, &ypos
        static coordinates := ""
        coordinates := xpos ", " ypos "`n"
        fleg := !fleg
    } else {
        SendText(coordinates)
        fleg := !fleg
    }
}
Esc:: {
    global on_off := false
    ToolTip("关闭")
    SetTimer () => ToolTip(), -3000
}