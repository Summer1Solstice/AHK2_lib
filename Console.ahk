#Requires AutoHotkey v2.0
Persistent

class WindowsConsole {
    __New(Title := "AutoHotkey " A_AhkVersion, Encoding := 65001) {
        DllCall("AllocConsole") ; 分配控制台窗口
        this.stdin := FileOpen("*", "r", Encoding)
        this.stdout := FileOpen("*", "w", Encoding)
        DllCall("SetConsoleCP", "uint", Encoding)
        DllCall("SetConsoleOutputCP", "uint", Encoding)
        HandlerRoutine(event) {
            switch event {
                case 0: ExitApp()
                case 2: ExitApp()
            }
            return true
        }
        DllCall("SetConsoleCtrlHandler", "ptr", CallbackCreate(HandlerRoutine, "F"), "int", 1)
    }
    ; DllCall("AttachConsole", "uint", -1)    ; 附加到父进程控制台
    SetTitle := (Title) => (DllCall("SetConsoleTitle", "Str", Title))
    GetTitle() {
        size := DllCall("GetConsoleTitle", "str", "") + 1
        VarSetStrCapacity(&title, size)
        DllCall("GetConsoleTitle", "str", title, "uint", size)
        return title
    }

    GetACP => (DllCall("GetACP"))    ; utf-8: 65001
    GetOEMCP => (DllCall("GetOEMCP"))    ; utf-8: 65001

    Print(text) {
        this.stdout.Write(text)
        this.stdout.Read(0) ; 清除写入缓冲区.
    }
    PrintLine(text) {
        this.stdout.WriteLine(text)
        this.stdout.Read(0) ; 清除写入缓冲区.
    }

    GetInput => RTrim(this.stdin.ReadLine(), "`n")
    SetOutput(text) => this.stdout.Write(text)
    SetOutputLine(text) => this.stdout.WriteLine(text)
    Flush() => this.PrintLine("")
}
/*
考虑从class中分离
*/
