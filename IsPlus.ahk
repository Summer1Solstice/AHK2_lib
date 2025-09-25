#Requires AutoHotkey v2.0

/**
 * 判断值是否为布尔值
 * @param val 
 * @returns {Integer} 
 */
IsBool(val) {
    if val {
        return true
    }
    return false
}

/**
 * 判断值是否为质数
 * @param val 
 * @returns {Integer} 
 */
IsPrime(val) {
    if val <= 1 {
        return false
    }
    if val = 2 or val = 3 {
        return true
    }
    if not Mod(val, 2) {
        return false
    }

    max := Floor(Sqrt(val)) + 1
    OutputDebug max "`n"
    divisor := 3
    while divisor <= max {
        if not Mod(val, divisor) {
            return false
        }
        divisor += 2
    }
    return true
}