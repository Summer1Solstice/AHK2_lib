#Requires AutoHotkey v2.0

; 练习迭代
JSON_stringify(obj) {
    if not IsObject(obj) {
        if obj is String {
            return '"' obj '"'
        }
        return obj
    }
    if obj is Array {
        result := "["
        for i in obj {
            result .= JSON_stringify(i) ", "
        }
        result := RTrim(result, ", ")
        return result "]"
    }
    if obj is Map {
        result := "{"
        for k, v in obj {
            result .= JSON_stringify(k) ": " JSON_stringify(v) ", "
        }
        result := RTrim(result, ", ")
        return result . "}"
    }
    if obj is Func {
        return "null"
    }
}