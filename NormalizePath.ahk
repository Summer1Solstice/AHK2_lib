#Requires AutoHotkey v2.0

NormalizePath(path) {
    cc := DllCall("GetFullPathName", "str", path, "uint", 0, "ptr", 0, "ptr", 0, "uint")
    buf := Buffer(cc * 2)
    DllCall("GetFullPathName", "str", path, "uint", cc, "ptr", buf, "ptr", 0)
    return StrGet(buf)
}