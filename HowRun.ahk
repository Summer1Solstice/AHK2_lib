#Requires AutoHotkey v2.0

HowRun() {
    /*
    * Visual Studio Code
    * SciTE4AutoHotkey
    * ……
    */
    global A_DebuggerName
    if IsSet(A_DebuggerName) {
        return A_DebuggerName
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