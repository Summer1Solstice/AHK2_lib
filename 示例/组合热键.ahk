#Requires AutoHotkey v2

#t:: {
    OutputDebug A_ThisHotkey
}
#HotIf A_PriorHotkey = "#t" and A_TimeSincePriorHotkey < 3000
t:: Run('wt.exe')
g:: Run('wt.exe -p "Git Bash"')
u:: Run('wt.exe -p "Ubuntu-24.04"')