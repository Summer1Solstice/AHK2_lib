#Requires AutoHotkey v2.0
#Include <XZ\Range>

/**
 * 生成2-max之间的质数
 * @param max 
 * @returns {Array} 
 */
Prime(max) {
    list := []
    list.Length := max
    list.Default := true
    list[1] := false
    for i in range(2, Floor(Sqrt(max)) + 1) {
        if list[i] {
            for i in range(i * i, max + 1, i) {
                list[i] := false
            }
        }
    }
    result := []
    loop max {
        if list.Get(A_Index) {
            result.Push(A_Index)
        }
    }
    return result
}