#Requires AutoHotkey v2.0

/*练习：100扇门
*有100扇门排成一排，初始状态都是关闭的。
*第1次，打开所有的门；
*第2次，关闭所有编号为2的倍数的门；
*第3次，切换所有编号为3的倍数的门（开→关，关→开）；
*依此类推，直到第100次，切换第100号门的状态。
*问：最后哪些门是开着的？
*
*答案：
*[1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
*/

doors := []
doors.Default := 0
doors.Length := 100
loop 100 {
    sessions := A_Index, Stepping := A_Index
    while sessions <= 100 {
        if doors.Get(sessions) {
            doors[sessions] := 0
        } else {
            doors[sessions] := 1
        }
        sessions += Stepping
    }
}

for i in doors {
    if i {
        OutputDebug(A_Index " ")
    }
}