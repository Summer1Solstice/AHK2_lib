#Requires AutoHotkey v2.0
Persistent

class WindowsConsole {
    __New(Title := "AutoHotkey " A_AhkVersion, Encoding := 65001) {
        DllCall("AllocConsole") ; 分配控制台窗口
        this.SetTitle(Title)
        ; 标准输入
        this.stdin := FileOpen("*", "r", Encoding)
        ; 标准输出
        this.stdout := FileOpen("*", "w", Encoding)
        ; 标准错误
        this.stderr := FileOpen("**", "w", Encoding)
        DllCall("SetConsoleCP", "uint", Encoding)   ; 设置控制台输入编码
        DllCall("SetConsoleOutputCP", "uint", Encoding) ; 设置控制台输出编码
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
    ; 设置控制台标题
    SetTitle := (Title) => (DllCall("SetConsoleTitle", "Str", Title))
    ; 获取控制台标题
    GetTitle() {
        size := DllCall("GetConsoleTitle", "str", "") + 1
        VarSetStrCapacity(&title, size)
        DllCall("GetConsoleTitle", "str", title, "uint", size)
        return title
    }
    ; 获取编码
    GetACP => (DllCall("GetACP"))    ; utf-8: 65001
    ; 获取编码
    GetOEMCP => (DllCall("GetOEMCP"))    ; utf-8: 65001
    ; 打印
    Print(text) {
        this.stdout.Write(text)
        this.stdout.Read(0) ; 清除写入缓冲区.
    }
    ; 打印
    PrintLine(text) {
        this.stdout.WriteLine(text)
        this.stdout.Read(0) ; 清除写入缓冲区.
    }
    ; 获取输入
    GetInput => RTrim(this.stdin.ReadLine(), "`n")
    ; 设置输出
    SetOutput(text) => this.stdout.Write(text)
    ; 设置输出
    SetOutputLine(text) => this.stdout.WriteLine(text)
    ; 刷新输出
    Flush() => this.PrintLine("")
}
/*
考虑从class中分离
*/
