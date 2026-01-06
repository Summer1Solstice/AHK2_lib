foo() {
    Send "{e Down}"
    ; OutputDebug("foo`n")
}
$^e:: {
    static flag := false
    if flag {
        flag := false
        Send "{e Up}"
        SetTimer(foo, 0)
        SetTimer((*) => (ToolTip()), -100)
    } else {
        flag := true
        SetTimer(foo, 100)
        ToolTip flag
    }
}
/*
Ctrl+e按住e键