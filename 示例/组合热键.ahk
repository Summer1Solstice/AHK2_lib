#Requires AutoHotkey v2

#t::
tk_Tip(tk) {
    if not RegExMatch(tk, "([#!^+&<>*~$]+)(.*?)$", &match) {
        return
    }
    tk := RegExReplace(match[1], "[&<>*~$]") . StrUpper(match[2])
    static list := [
        ["+", "Shift+"],
        ["!", "Alt+"],
        ["^", "Ctrl+"],
        ["#", "Win+"],
    ]
    for i in list {
        tk := StrReplace(tk, i[1], i[2], , , 1)
    }
    ToolTip("(" tk ")已按下。正在等待按下第二个键…")
    SetTimer(ToolTip, 3000)
}
#s::tk_Tip(ThisHotkey)
#HotIf A_PriorHotkey = "#t" and A_TimeSincePriorHotkey < 3000
t:: Run('wt.exe -w 0')
g:: Run('wt.exe -w 0 -p "Git Bash"')
u:: Run('wt.exe -w 0 -p "Ubuntu-24.04"')