/************************************************************************
 * @description 单位换算工具类，包含数值、单位分离方法，乘法除法方法，浮点数格式化方法。
 * 具体如何换算，请自行定义代码逻辑。
 * @author Summer1Solstice
 * @date 2026/05/03
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

class ConvertUtils {
    ; 拆分数值和单位
    Split(i) {
        RegExMatch(i, "([0-9.]+)([a-zA-Z]+)", &match)
        return { Num: match[1], unit: StrLower(match[2]) }
    }
    ; 乘法
    Mul(a, b) => (this.Fmt(a * b))
    ; 除法
    Div(a, b) => (this.Fmt(a / b))
    ; 浮点数格式化，去除多余的零，转整数
    Fmt(i) {
        i := Round(i, 15)
        i_L := StrSplit(i, ".")
        result := i_L[1]
        if i_L[2] != 0 {
            result .= "." RTrim(i_L[2], 0)
        }
        return result
    }
}
class ConvertLength extends ConvertUtils {
    _to_ := Map(
        "mm", [this.Div.Bind(this, , 1000), this.Mul.Bind(this, , 1000)],
        "cm", [this.Div.Bind(this, , 100), this.Mul.Bind(this, , 100)],
        "m", [this.Div.Bind(this, , 1), this.Mul.Bind(this, , 1)],
        "km", [this.Mul.Bind(this, , 1000), this.Div.Bind(this, , 1000)],
    )
    call(i) {
        Num := this.Split(i)
        unit := Num.unit
        Num := Num.Num
        m :=  this._to_[unit][1](Num)
        result := {}
        for k,v in this._to_{
            result.%k% := v[2](m)
        }
        return result
    }
}
