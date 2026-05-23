#Requires AutoHotkey v2
CoordMode("ToolTip", "Screen")
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
    static x := A_ScreenWidth // 2, y := A_ScreenHeight // 2
    ToolTip("(" tk ")已按下。正在等待按下第二个键…", x, y)
    SetTimer(ToolTip, 3000)
}
#s:: tk_Tip(ThisHotkey)
#HotIf A_PriorHotkey = "#t" and A_TimeSincePriorHotkey < 3000
t:: Run('wt.exe -w 0')
g:: Run('wt.exe -w 0 -p "Git Bash"')
u:: Run('wt.exe -w 0 -p "Ubuntu-24.04"')
s:: Run('wt.exe -w 0 -p "PowerShell" D:\scrcpy-win64-v4.0\scrcpy.exe')