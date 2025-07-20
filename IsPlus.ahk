#Requires AutoHotkey v2.0

/**
 * 判断值是否为布尔值
 * @param val 
 * @returns {Integer} 
 */
IsBool(val) {
    if val = 1 or val = 0 {
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
    if val = 2 {
        return true
    }
    if not Mod(val, 2) {
        return false
    }
    if val = 3 {
        return true
    }
    if val > 5 and not Mod(val, 5) {
        return false
    }
    min := 3
    Divisor := min
    max := Floor(Sqrt(val))
    while true {
        if not Mod(val, Divisor) {
            return false
        } else {
            if Divisor < max {
                Divisor += 2
            } else if Divisor >= max {
                break
            }
        }
    }
    return true
}