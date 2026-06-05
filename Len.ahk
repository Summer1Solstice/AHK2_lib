/************************************************************************
 * @description 返回变量的长度，支持 Object、Array、Map、RegExMatchInfo 和 Primitive 类型
 * @author Summer1Solstice
 * @date 2026/04/13
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 返回变量的长度/元素个数，支持多种数据类型
 * 
 * 支持的数据类型：
 * - Array: 返回数组元素个数 (var.Length)
 * - Map: 返回键值对个数 (var.Count)
 * - String: 返回字符串长度 (StrLen(var))
 * - Integer: 返回数字字符长度 (StrLen(var))
 * - Float: 返回浮点数字符长度 (StrLen(var))
 * - Object: 返回对象自有属性个数 (ObjOwnPropCount(var))
 * 
 * @param var 需要获取长度的变量
 * @returns {Integer} 变量的长度或元素个数
 * @throws TypeError 当变量类型不被支持时抛出异常
 */
len(var) {
    switch Type(var) {
        case "Array": return var.Length
        case "Map": return var.Count
        case "String": return StrLen(var)
        case "Integer": return StrLen(var)
        case "Float": return StrLen(var)
        case "Object": return ObjOwnPropCount(var)
        default: throw TypeError(Type(var))
    }
}

;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    OutputDebug(len([1]))
    OutputDebug(len(Map(1, 1)))
    OutputDebug(len("1"))
    OutputDebug(len({ a: 1 }))
    OutputDebug(len(1))
    OutputDebug(len(1.0))
}
;@Ahk2Exe-IgnoreEnd
