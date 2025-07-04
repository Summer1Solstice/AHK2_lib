#Requires AutoHotkey v2.0

/**
 * 生成一个整数数组
 * 
 * @param start 开始值
 * @param stop 结束值
 * @param {Integer} step 步长
 * @returns {Array} 整数数组
 */
range(start, stop?, step := 1) {
    if not IsSet(stop) {
        stop := start, start := 0
    }
    result := [], V := start
    while V < stop {
        result.Push(V)
        V += step
    }
    return result
}