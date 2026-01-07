#Requires AutoHotkey v2.0

/**
 * 时间间隔测量函数
 * 
 * 功能：
 * - 第一次调用时记录当前时间戳，作为计时开始点
 * - 第二次调用时计算与第一次调用之间的时间间隔并输出
 * 
 * 时间格式：
 * - 如果间隔 ≥ 1000ms，以秒为单位显示（保留3位小数）+ "s"
 * - 如果间隔 < 1000ms，以毫秒为单位显示 + "ms"
 * 
 * 输出方式：使用 OutputDebug 输出到调试窗口
 * 
 * 使用方式：
 * - 第一次调用：Timeing()  # 开始计时
 * - 第二次调用：Timeing()  # 输出时间间隔并重置
 */
Timeing() {
    static TimeAgo := 0
    if TimeAgo {
        time := A_TickCount - TimeAgo
        if time >= 1000 {
            time := Round(time / 1000,3)
            time .= "s"
        } else {
            time .= "ms"
        }
        TimeAgo := 0
        OutputDebug time "`n"
    } else {
        TimeAgo := A_TickCount
    }
}