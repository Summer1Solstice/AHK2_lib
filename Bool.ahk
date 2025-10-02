#Requires AutoHotkey v2.0

/**
 * 转为布尔值
 * @param var 
 * @returns {Integer} 
 */
Bool(var) {
    switch Type(var) {
        case "Integer": return var ? true : false
        case "Float": return var ? true : false
        case "String": return var ? true : false
        case "Array": return var.Length ? true : false
        case "Map": return var.Count ? true : false
        case "Object": return ObjOwnPropCount(var) ? true : false
        default: throw TypeError("Bool() expects a value of type Integer, Float, String, Array, Map, Object.", , "And you're sending in " Type(var))
    }
}