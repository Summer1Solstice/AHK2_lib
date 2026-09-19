/************************************************************************
 * @description 返回变量的长度，支持 Object、Array、Map、RegExMatchInfo 和 Primitive 类型
 * 存在缺陷，无法获取number的字节长度，只能获取数字字符串的字符长度。
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
Len(var) {
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

/**
 * 返回字符串的字节长度
 * @param var 字符串变量（Primitive 类型）
 * @param {String} encoding 编码类型，默认 "utf-8"。
 * @returns {Integer} string 编码后的字节数。
 */
StrLenByte(var, encoding := "utf-8") {
    if var is Primitive {
        return StrPut(var, encoding) - 1
    } else {
        throw TypeError(Type(var))
    }
}

;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    OutputDebug(len({ a: 1 }) "`n")
    OutputDebug(len(Map(1, 1, 2, 2)) "`n")
    OutputDebug(len([1, 2, 3]) "`n")
    OutputDebug(len("4444") "`n")
    OutputDebug(len(1) "`n")
    OutputDebug(len(1.0) "`n")
    OutputDebug(StrLenByte("你好", "utf-8") "`n")
    OutputDebug(StrLenByte(1234) "`n")
}
;@Ahk2Exe-IgnoreEnd
