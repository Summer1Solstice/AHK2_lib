#Requires AutoHotkey v2.0

stringify(val) {
    if val is Primitive {
        if val is String {
            return '"' val '"'
        }
        return val
    }
    if val is Array {
        result := "["
        for i in val {
            result .= stringify(i) ", "
        }
        result := RTrim(result, ", ")
        return result "]"
    }
    if val is Map {
        result := "{"
        for k, v in val {
            result .= stringify(k) ": " stringify(v) ", "
        }
        result := RTrim(result, ", ")
        return result "}"
    }
    if val is Func {
        return val.name "()"
    }
    if val is Object {
        result := "{"
        for k, v in val.OwnProps() {
            result .= stringify(k) ": " stringify(v) ", "
        }
        result := RTrim(result, ", ")
        return result "}"
    }
}
Debug(val) {
    OutputDebug stringify(val) '`n'
}