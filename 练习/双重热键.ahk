#Requires AutoHotkey v2.0

InstallKeybdHook
^o:: {
    HotIf((*) => true)
    Hotkey("^a", obsidian_add, "On")
    KeyWait("ctrl")
    Hotkey("^a", "off")
    obsidian_add(*) {
        Hotkey("^a", "off")
        OutputDebug "obsidian_add"
    }
}
; 存在优先级问题, Ctrl+a优先级会非常低