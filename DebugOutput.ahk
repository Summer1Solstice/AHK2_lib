#Requires AutoHotkey v2.0

Debug(val) {
    JSON_stringify(val) {
        if val is Primitive {
            if val is String {
                return '"' val '"'
            }
            return val
        }
        if val is Array {
            result := "["
            for i in val {
                result .= JSON_stringify(i) ", "
            }
            result := RTrim(result, ", ")
            return result "]"
        }
        if val is Map {
            result := "{"
            for k, v in val {
                result .= JSON_stringify(k) ": " JSON_stringify(v) ", "
            }
            result := RTrim(result, ", ")
            return result . "}"
        }
        if val is Func {
            return val.name "()"
        }
    }
    OutputDebug JSON_stringify(val) '`n'
}