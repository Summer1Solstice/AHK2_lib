/************************************************************************
 * @date 2025/05/08
 * @version 3.0.0
 ***********************************************************************/
/**
 * 将数字转换为中文汉字
 * 
 * 支持整数、浮点数（建议以字符串形式传入）以及金额格式转换。
 * 
 * @param num 要转换的数字，可以是整数或浮点数。由于浮点数精度问题，建议以字符串形式传入
 * @param {Integer} flag 转换标志，默认为 0
 *        可选值：
 *          0: 小写（如“一二三”）
 *          1: 大写（如“壹贰叁”）
 *          2: 小写金额（如“一元二角三分厘四毫”，小数部分最多保留四位）
 *          3: 大写金额（如“壹元贰角叁分厘肆毫”，小数部分最多保留四位）
 * @returns {String} 转换后的中文数字字符串
 */
Num2HanZi(num, flag := 0) {
    /*
    功能：
    参数：
        n:
        flag:
    返回值：
        转换后的中文数字字符串
    */
    ; 定义数字映射表和数位列表
    if flag & 1 {      ; 大写
        figure_map := Map("0", "零", "1", "壹", "2", "贰", "3", "叁", "4", "肆", "5", "伍", "6", "陆", "7", "柒", "8", "捌", "9", "玖")
        digit_place_list := ["", "拾", "佰", "仟", "万", "拾", "佰", "仟", "亿", "拾", "佰", "仟", "万", "拾", "佰", "仟", "万"]
    } else {          ; 小写
        figure_map := Map("0", "〇", "1", "一", "2", "二", "3", "三", "4", "四", "5", "五", "6", "六", "7", "七", "8", "八", "9", "九")
        digit_place_list := ["", "十", "百", "千", "万", "十", "百", "千", "亿", "十", "百", "千", "万", "十", "百", "千", "万"]
    }
    decimal_point_pos := InStr(num, ".")      ; 查找小数点位置
    if decimal_point_pos {
        integer := SubStr(num, 1, decimal_point_pos - 1)  ; 整数部分
        decimal := SubStr(num, decimal_point_pos + 1)  ; 小数部分
    } else {
        integer := num  ; 整数部分
        decimal := ""  ; 小数部分
    }
    if integer {
        integer := LTrim(integer, "0")  ; 去除整数部分的前导零
        integer_length := StrLen(integer)  ; 整数部分长度
        if integer_length > 16 {  ; 超过16位，返回空字符串
            return ""
        }
        integer_length += 1  ; 修正长度
        static digit_place_if_list := [0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]  ; 数位判断列表
        integer_result := ""  ; 整数部分结果
        loop parse integer {
            integer_result .= figure_map[A_LoopField]  ; 映射数字
            digit_place := integer_length - A_Index  ; 计算数位
            if A_LoopField or digit_place_if_list[digit_place] {  ; 非零或万、亿
                integer_result .= digit_place_list[digit_place]  ; 加上数位
            }
        }
    } else {
        integer_result := StrReplace(integer, "0", figure_map["0"])
    }

    if decimal {  ; 处理小数部分
        if flag & 2 {  ; 金额
            decimal := SubStr(decimal, 1, 4)  ; 截取前四位小数
            decimal_point := integer ? "元" : ""  ; 小数点
            static decimal_digit_place_list := ["角", "分", "厘", "毫"]  ; 小数位
            decimal_result := ""  ; 小数部分结果
            loop parse decimal {
                decimal_result .= figure_map[A_LoopField]  ; 映射数字
                if A_LoopField != "0" {  ; 非零
                    decimal_result .= decimal_digit_place_list[A_Index]  ; 加上数位
                }
            }
        } else {  ; 普通
            decimal_point := "点"  ; 小数点
            loop parse decimal {  ; 循环处理小数部分
                decimal_result .= figure_map[A_LoopField]  ; 映射数字
            }
        }
    } else {  ; 没有小数部分
        decimal_point := ""  ; 小数点
        decimal_result := ""  ; 小数部分结果
        if flag & 2 and integer {  ; 金额且有整数部分
            decimal_point := "元整"  ; 元整
        }
    }
    ; 统一处理多余的零
    zero := flag & 1 ? "零" : "〇"  ; 零
    ; 整数部分的零处理
    if integer or flag & 2 {  ; 有整数部分或金额
        integer_result := RTrim(integer_result, zero)  ; 去除末尾的零
    }
    integer_result := RegExReplace(integer_result, zero "{2,}", zero)  ; 合并多余的零
    integer_result := StrReplace(integer_result, zero "万", "万")  ; 零万
    integer_result := StrReplace(integer_result, zero "亿", "亿")  ; 零亿
    integer_result := StrReplace(integer_result, "亿万", "亿")  ; 亿万
    ; 小数部分的零处理
    if decimal {  ; 有小数部分
        decimal_result := RTrim(decimal_result, zero)  ; 去除末尾的零
        if flag & 2 {  ; 金额
            if not integer
                decimal_result := LTrim(decimal_result, zero)  ; 去除开头的零
            decimal_result := RegExReplace(decimal_result, zero "{2,}", zero)  ; 合并多余的零
        }
    }
    result := integer_result . decimal_point . decimal_result  ; 合并整数和小数部分
    return result
}

if A_ScriptName = "数字转汉字.ahk" {
    ; r := "1234567812345678.876543218765432"
    for f in [0, 1, 2, 3] {
        timelist := []
        loop 100 {
            loop_count := 100
            time1 := A_TickCount
            loop loop_count {
                r := Random(1.0, 9999999999999999)
                Num2HanZi(r, f)
            }
            time2 := A_TickCount
            timelist.push((time2 - time1) / loop_count)
        }
        sum := 0
        for i in timelist {
            sum += i
        }
        OutputDebug "flag:" f " 平均用时:" Round(sum / timelist.Length, 4) "ms`n"
    }
}