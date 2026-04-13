/************************************************************************
 * @description 修改ssh终端为pwsh或bash
 * @author 
 * @date 2026/04/13
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

if not A_IsAdmin {
    Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
}
reg_key := "HKEY_LOCAL_MACHINE\SOFTWARE\OpenSSH\"
pwsh := "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
bash := "C:/Program Files/Git/bin/bash.exe"
SetSSHTerminal(Terminal) {
    if not FileExist(Terminal) {
        throw "not found Terminal"
    }
    loop reg reg_key {
        if A_LoopRegName = "DefaultShell" {
            MsgBox "修改前：" RegRead()
            RegWrite(Terminal)
            MsgBox "修改后：" RegRead()
            break
        }
    }

}
; SetSSHTerminal(pwsh)