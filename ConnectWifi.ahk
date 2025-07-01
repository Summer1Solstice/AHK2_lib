#Requires AutoHotkey v2.0
#Include RunWait.ahk

/**
 * 连接Wi-Fi
 * @param SSID Wi-Fi的名字
 * @returns {Integer} 0:成功 1:未找到 2:已连接
 */
ConnectWifi(SSID) {
    command := "netsh wlan show interface | findstr SSID"   ; 获取当前Wi-Fi名称
    commandA := "netsh wlan show networks"
    if InStr(RunWaitOne(command), SSID) {
        return 2
    }
    if not InStr(RunWaitOne(commandA), SSID) {
        return 1
    }
    Run A_ComSpec " /C netsh wlan connect name=" SSID, , "min"    ; 连接Wi-Fi
    return 0
}