/************************************************************************
 * @description 原始值基于AutoHotkey的原生`if`判断返回布尔值，
 * `Array`, `Map`, `Object`，基于元素数量和属性数量`if`判断返回布尔值。
 * @author Summer1Solstice
 * @date 2026/06/01
 * @version 0.0.1
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 转为布尔值
 * @param var 
 * @returns {Integer} 
 */
Bool(var) {
    switch Type(var) {
        case "Array": return var.Length ? true : false
        case "Map": return var.Count ? true : false
        case "String":
            if IsNumber(var) {
                return var ? true : false
            } else {
                switch StrLower(var) {
                    case "true": return true
                    case "false": return false
                    default: return var ? true : false
                }
            }
        case "Integer": return var ? true : false
        case "Float": return var ? true : false
        case "Object": return ObjOwnPropCount(var) ? true : false
        default:
            throw TypeError("Bool() expects a value of type Integer, Float, String, Array, Map, Object.", , "And you're sending in " Type(var))
    }
}