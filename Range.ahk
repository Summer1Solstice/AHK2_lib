/************************************************************************
 * @description Python range()的AutoHotkey实现;
 * 继承Python，数组索引从0开始、左闭右开的特性
 ***********************************************************************/
#Requires AutoHotkey v2.0

/**
 * AutoHotkey风格的序列生成器，包含开始值和结束值
 * @param {Integer} start 开始值
 * @param {Integer} stop 结束值
 * @param {Integer} step 步长
 */
rangeA(start, stop?, step := 1) {
    if not IsSet(stop)
        stop := start, start := 1

    if !IsNumber(start) or !IsNumber(stop) or !IsNumber(step)
        throw TypeError("参数必须为数字")
    if step = 0
        throw ValueError("步长不能为 0 ")
    if (start > stop and step > 0) or (start < stop and step < 0)
        throw ValueError("起始值和停止值与步长方向不一致")

    range_add(&i) {
        i := start
        start += step
        return i <= stop
    }
    range_sub(&i) {
        i := start
        start += step
        return i => stop
    }
    return step > 0 ? range_add : range_sub
}

/**
 * 左闭右开区间序列生成器
 * @param {Integer} start 开始值
 * @param {Integer} stop 结束值
 * @param {Integer} step 步长
 */
range(start, stop?, step := 1) {
    if not IsSet(stop)
        stop := start, start := 0

    if !IsNumber(start) or !IsNumber(stop) or !IsNumber(step)
        throw TypeError("参数必须为数字")
    if step = 0
        throw ValueError("步长不能为 0 ")
    if (start > stop and step > 0) or (start < stop and step < 0)
        throw ValueError("起始值和停止值与步长方向不一致")

    range_add(&i) {
        i := start
        start += step
        return i < stop
    }
    range_sub(&i) {
        i := start
        start += step
        return i > stop
    }
    return step > 0 ? range_add : range_sub
}