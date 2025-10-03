#Requires AutoHotkey v2.0

/**
 * 转为布尔值
 * @param var 
 * @returns {Integer} 
 */
Bool(var) {
    if var is Primitive {
        return var ? true : false
    } else if var is Array {
        return var.Length ? true : false
    } else if var is Map {
        return var.Count ? true : false
    } else if var is Object {
        return ObjOwnPropCount(var) ? true : false
    } else {
        throw TypeError("Bool() expects a value of type Integer, Float, String, Array, Map, Object.", , "And you're sending in " Type(var))
    }
}