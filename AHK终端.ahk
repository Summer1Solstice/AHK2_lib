/************************************************************************
 * @description 搞笑作品，Linux终端模拟器
 * @date 2025/08/29
 * @version 0.0.2
 ***********************************************************************/
#Requires AutoHotkey v2.0
#SingleInstance
Persistent

if A_DebuggerName ?? 0 {
    Reload
}

DllCall("AllocConsole") ; 分配控制台窗口
DllCall("SetConsoleTitle", "Str", "AutoHotkey 终端")
stdin := FileOpen("*", "r")
stdout := FileOpen("*", "w")

stdout.WriteLine("AutoHotkey " A_AhkVersion)
while true {
    Print("PS " A_WorkingDir "> ")
    input := RTrim(stdin.ReadLine(), "`n")
    input := StrSplit(input, " ")
    Command := input.RemoveAt(1)
    if Commands.HasOwnProp(Command) {
        Commands.%Command%(input*)
    } else {
        PrintLint("Unknown command")
    }
    stdout.Read(0) ; 清除写入缓冲区.
}
Print(text) {
    stdout.Write(text)
    stdout.Read(0) ; 清除写入缓冲区.
}
PrintLint(text) {
    stdout.WriteLine(text)
    stdout.Read(0) ; 清除写入缓冲区.
}
class Commands {
    static exit => ExitApp()
    static r => Reload()
    static cd := (this, path, *) => (SetWorkingDir(path))
    static ls(*) {
        loop files "*.*", "DF" {
            stdout.WriteLine(A_LoopFilePath)
        }
        stdout.Read(0)
    }
}