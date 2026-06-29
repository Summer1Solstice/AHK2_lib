/************************************************************************
 * @description 注册自定义URI Scheme
 * @author 
 * @date 2026/06/29
 * @version 0.0.0
 * @learn https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/platform-apis/aa767914(v=vs.85)
 ***********************************************************************/

#Requires AutoHotkey v2.0
/**
 * @description 注册自定义URI Scheme
 * 可用属性：
 * Scheme：自定义URI Scheme；
 * Exe：处理程序路径；
 * Script：额外脚本路径。
 */
class Custom_URI_Scheme {
    ; Custom_URI_Scheme
    Scheme := "ahk"
    ; 处理程序路径
    Exe := "C:\Program Files\AutoHotkey\UX\AutoHotkeyUX.exe"
    ; 额外脚本路径
    Script := ""
    /**
     * 注册自定义URI Scheme
     * 自定义类属性`Scheme`、`Exe`、`Script`。
     * 默认注册AHK协议。
     */
    Call() {
        RegWrite(Format("URL:{1}", this.Scheme), "REG_SZ", Format("HKCR\{1}", this.Scheme))
        RegWrite("", "REG_SZ", Format("HKCR\{1}", this.Scheme), "URL Protocol")
        if this.Script {
            RegWrite(Format('"{1}" "{2}" "%1"', this.Exe, this.Script), "REG_SZ", Format("HKCR\{1}\shell\open\command", this.Scheme))
        } else {
            RegWrite(Format('"{1}" "%1"', this.Exe), "REG_SZ", Format("HKCR\{1}\shell\open\command", this.Scheme))
        }
    }
}
;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    if not A_IsAdmin {
        OutputDebug("非管理员权限,无法注册自定义URI方案")
    }
    ahk_scheme := Custom_URI_Scheme()
    ahk_scheme.Script := "echo.ahk"
    ahk_scheme()
}
;@Ahk2Exe-IgnoreEnd
