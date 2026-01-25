#Requires AutoHotkey v2.0

p := DllCall("GetEnvironmentStrings")
str := StrGet(p, "utf-8")
o := str
len := StrLen(str) + 1
while 1 {
    if not StrGet(p + len + 1, "utf-8") {
        break
    }
    str := StrGet(p + len, "utf-8")
    o .= "`n" str
    len += StrLen(str) + 1
}

FileAppend(o, "temp.txt")
DllCall("FreeEnvironmentStringsW", "ptr", p)