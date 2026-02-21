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
    OutputDebug(Format("{1}: {2} ms`n", fn.Name ? fn.Name : "Fat arrow function", diff))
}