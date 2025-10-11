#Requires AutoHotkey v2.0

Timeing() {
    static TimeAgo := 0
    if TimeAgo {
        time := A_TickCount - TimeAgo
        if time >= 1000 {
            time := Round(time / 1000,3)
            time .= "s"
        } else {
            time .= "ms"
        }
        TimeAgo := 0
        OutputDebug time
    } else {
        TimeAgo := A_TickCount
    }
}