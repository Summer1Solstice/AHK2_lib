#Requires AutoHotkey v2.0

HowRun() {
    global A_DebuggerName
    if A_DebuggerName ?? "" = "Visual Studio Code" {
        return "VSCode"
    }
    try {
        FileOpen("*", "w")
        return "APP"
    } catch OSError {

    }
    if A_Args.Length or DllCall("AttachConsole", "uint", -1) {
        return "CLI"
    }
    return "Direct"
}
MsgBox HowRun()