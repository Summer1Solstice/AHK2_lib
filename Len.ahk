#Requires AutoHotkey v2.0

/**
 * 返回变量的长度，支持 Array、Map、RegExMatchInfo 和 Primitive 类型
 * @param var 
 * @returns {Integer | bool} 
 */
len(var) {
    if var is Array {
        return var.Length
    }
    if var is Map {
        return var.Count
    }
    if var is RegExMatchInfo {
        return var.Count
    }
    if var is Primitive {
        return StrLen(var)
    }
    return false
}