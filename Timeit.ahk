/************************************************************************
 * @description 高精度的计时模块，传入一个函数，输出单次运行的平均耗时。
 * 如果函数需要传入参数,请使用
 * ```AutoHotkey
 * fn := foo.Bind("args")  ; 函数
 * fn1() => classobj.foo("arg")    ; 类实例方法
 * ```
 * @author 
 * @date 2026/04/13
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

Timeit(fn, count := 1) {
    if not (fn is Func) {
        throw "not Func"
    }
    DllCall("QueryPerformanceFrequency", "Int64*", &freq := 0)
    result := []
    loop count {
        DllCall("QueryPerformanceCounter", "Int64*", &CounterBefore := 0)
        fn()
        DllCall("QueryPerformanceCounter", "Int64*", &CounterAfter := 0)
        result.Push((CounterAfter - CounterBefore) / freq * 1000)
    }
    diff := 0
    if result.Length > 1 {
        for i in result {
            diff += i
        }
        diff /= result.Length
    } else {
        diff := result[1]
    }
    units := "ms"
    switch {
        case diff < 1: units := "µs", diff *= 1000
        case diff > 1000: units := "s", diff /= 1000
    }
    OutputDebug(Format("{1}: {2} {3}`n", fn.Name ? fn.Name : "Fat arrow function", diff, units))
}