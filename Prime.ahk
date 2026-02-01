#Requires AutoHotkey v2.0
#Include <XZ\Range>

class Prime {
    static EulerSieve(n) {
        list := []
        list.Length := n
        list.Default := true
        list[1] := false
        Primes := []
        for i in rangeA(2, n) {
            if list[i] {
                Primes.Push(i)
            }
            for p in Primes {
                if i * p > n {
                    break
                }
                list[i * p] := false
                if Mod(i, p) = 0 {
                    break
                }
            }
        }
        return Primes
    }
    static is(p) {
        if p <= 1 {
            return false
        }
        if p = 2 or p = 3 {
            return true
        }
        if not p & 1 {
            return false
        }
        max := Floor(Sqrt(p)) + 1
        divisor := 3
        while divisor <= max {
            if not Mod(p, divisor) {
                return false
            }
            divisor += 2
        }
        return true
    }
}
if A_ScriptName = "Prime.ahk" {
    result := Prime.EulerSieve(100000)
    OutputDebug(result.Length "`n")
    for i in result {
        if not Prime.is(i) {
            OutputDebug(i)
            ExitApp()
        }
    }
}