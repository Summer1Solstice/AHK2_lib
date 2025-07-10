#Requires AutoHotkey v2.0
#Include 迭代.ahk
/*
*练习：考拉兹猜想
*对于任意正整数n，若n为偶数则除以2，若n为奇数则乘以3加1，重复此过程最终会得到1。
*编写一个函数，实现以下功能：
*1. 输入：正整数n
*2. 输出：从n开始到1的考拉兹序列
*3. 要求：序列中包含n和1
*
*示例：
*输入：6
*输出：[6, 3, 10, 5, 16, 8, 4, 2, 1]
*/
Collatz_Conjecture(n) {
    if not IsInteger(n) or n < 1 {
        return 0
    }
    result := []
    result.Push(n)
    while n != 1 {
        if Mod(n, 2) {
            n := n * 3 + 1
        } else {
            n := n // 2
        }
        result.Push(n)
    }
    return JSON_stringify(result)
}