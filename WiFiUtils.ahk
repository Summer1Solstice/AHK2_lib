/************************************************************************
 * @description Wi-Fi工具函数
 * @author Summer1Solstice
 * @date 2026/04/13
 * @version 0.0.1
 ***********************************************************************/

#Requires AutoHotkey v2.0
#Include RunCmd.ahk

/**
 * 连接Wi-Fi
 * @param SSID Wi-Fi的名字
 * @returns {Integer} 0:成功 1:未找到 2:已连接
 * @protected
 */
ConnectWifi(SSID) {
    ; command := "netsh wlan show interface | findstr SSID"   ; 获取当前Wi-Fi名称
    ; commandA := "netsh wlan show networks"  ; 获取可见Wi-Fi名称
    ; commandB := "netsh wlan disconnect" ; 断开Wi-Fi
    if WiFiCurrent() = SSID {   ; 已连接
        return 2
    }
    if not WiFiExist(SSID) {  ; 未找到
        return 1
    }
    Run A_ComSpec " /C netsh wlan connect name=" SSID, , "Hide"    ; 连接Wi-Fi
    return 0
}

/**
 * 连接Wi-Fi
 * @param SSID Wi-Fi的名字
 * @returns {Integer} 0:成功 1:未找到 2:已连接
 */
WiFiConnect(SSID) {
    return ConnectWifi(SSID)
}

/**
 * 获取可见的Wi-Fi名称列表
 * @returns {Array} 可见的Wi-Fi名称列表
 */
WiFiList() {
    command := "netsh wlan show networks"   ; 获取可见Wi-Fi的名称
    result := []
    Pos := 1
    str := RunWaitOne(command)
    while RegExMatch(str, "m)^SSID\s*\d+\s*:\s(.+)$", &match, Pos) {
        result.Push(match[1])
        Pos := match.Pos + match.Len
    }
    return result
}

/**
 * 检查Wi-Fi是否存在
 * @param SSID Wi-Fi的名字  
 * @returns {String} Wi-Fi的名称 或 空字符串
 */
WiFiExist(SSID) {
    for i in WiFiList() {
        if i = SSID {
            return SSID
        }
    }
    return ""
}


/**
 * 获取当前连接的Wi-Fi名称
 * @returns {String | unset} 当前连接的Wi-Fi名称 或 unset
 */
WiFiCurrent() {
    if RegExMatch(RunWaitOne("netsh wlan show interface | findstr SSID"),
        "m)^\s+SSID\s+:\s(.+)$",
        &match) {
        return match[1]
    }
    return ""
}

/**
 * 断开当前连接的Wi-Fi
 */
WiFiDisconnect() {
    Run A_ComSpec " /C netsh wlan disconnect", , "Hide"
}

;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {

}
;@Ahk2Exe-IgnoreEnd
