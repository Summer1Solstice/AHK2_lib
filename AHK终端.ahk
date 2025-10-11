#Requires AutoHotkey v2.0
/************************************************************************
 * @description 搞笑作品，Linux终端模拟器
 * @date 2025/08/29
 * @version 0.0.2
 ***********************************************************************/
#SingleInstance ; 替换旧实例
Persistent  ; 持久运行
#Include join.ahk

if A_DebuggerName ?? 0 {
    Reload
}

DllCall("AllocConsole") ; 分配控制台窗口
DllCall("SetConsoleTitle", "Str", "AutoHotkey 终端")
HandlerRoutine(event) {
    switch event {
        case 0: ExitApp()
        case 2: ExitApp()
    }
    return true
}
DllCall("SetConsoleCtrlHandler", "ptr", CallbackCreate(HandlerRoutine, "F"), "int", 1)
; 标准输入
stdin := FileOpen("*", "r")
; 标准输出
stdout := FileOpen("*", "w")
; 标准错误
stderr := FileOpen("**", "w")

stdout.WriteLine("AutoHotkey " A_AhkVersion)
while true {
    Print("PS " A_WorkingDir "> ")
    input := RTrim(stdin.ReadLine(), "`n")   ; 没有控制台输入时会阻塞在这一步
    input := StrSplit(input, " ")
    if not input.Length {
        continue
    }
    Command := Trim(input.RemoveAt(1), "`n`r `t")
    if Command and Commands.HasOwnProp(Command) {
        if r := Commands.%Command%(input*) {
            PrintLine(r)
        }
    } else {
        PrintLine("Unknown command")
    }
    stdout.Read(0) ; 清除写入缓冲区.
}
Print(text) {
    stdout.Write(text)
    stdout.Read(0) ; 清除写入缓冲区.
}
PrintLine(text) {
    stdout.WriteLine(text)
    stdout.Read(0) ; 清除写入缓冲区.
}
class Commands {
    static exit => ExitApp()
    static r => Reload()
    static cd(path, *) {
        path = "~" ? path := EnvGet("USERPROFILE") : ""
        try {
            SetWorkingDir(path)
        } catch {
            PrintLine(Format("cd: 找不到路径{1}\{2}，因为该路径不存在。", A_WorkingDir, path))
        }
    }
    static ls(*) {
        loop files "*.*", "DF" {
            stdout.WriteLine(A_LoopFilePath)
        }
        stdout.Read(0)
    }
    static echo(args*) {
        if not args.Length {
            PrintLine("")
            return
        }
        return args.Join(" ")
    }
    static t(*){
        PrintLine( "located_ADB: `n`tADB" )
    }
}