#Requires AutoHotkey v2.0

Brainfuck(Code, MomorySize := 100) {
    ; 初始化变量
    CodeList := []  ; 创建代码列表
    CodePtr := 1    ; 代码指针
    MemoryPtr := 1  ; 内存指针
    output := ""    ; 创建输出变量
    Bracket := []   ; 创建括号列表
    BracketMap := Map() ; 创建括号映射
    MemoryCells := []       ; 创建内存
    MemoryCells.Length := MomorySize    ; 初始化内存
    MemoryCells.Default := 0    ; 初始化内存
    CodeList := StrSplit(RegExReplace(Code, "[^+\-,.<>\[\]]"))  ; 创建代码列表

    ; 创建括号映射
    for i in CodeList {
        if i = "[" {
            Bracket.Push(A_Index)
        } else if i = "]" {
            if Bracket.Length = 0 {
                throw Error()
            }
            left := Bracket.Pop()
            right := A_Index
            BracketMap.Set(left, right)
            BracketMap.Set(right, left)
        }
    }
    Bracket := ""   ; 删除括号列表
    ; 运行代码
    while CodePtr <= CodeList.Length {
        switch CodeList[CodePtr] {
            case "+":
                MemoryCells[MemoryPtr] := MemoryCells.Get(MemoryPtr) + 1 & 255
            case "-":
                MemoryCells[MemoryPtr] := MemoryCells.Get(MemoryPtr) - 1 & 255
            case "<":
                MemoryPtr -= 1
            case ">":
                MemoryPtr += 1
            case ",":
                text := InputBox()
                MemoryCells[MemoryPtr] := Ord(SubStr(text.Value, 1, 1))
            case ".":
                output .= Chr(MemoryCells.Get(MemoryPtr))
            case "[":
                if not MemoryCells.Get(MemoryPtr) {
                    CodePtr := BracketMap.Get(CodePtr)
                }
            case "]":
                if MemoryCells.Get(MemoryPtr) {
                    CodePtr := BracketMap.Get(CodePtr)
                }
        }
        CodePtr += 1
    }
    return output
}

if A_ScriptName = "Brainfuck.ahk" {
    text := "
(
//printf("hello world")

++++++++++
[
    >+++++++
    >++++++++++
    >+++
    >+
    <<<<-
]
>++.
>+.
+++++++..
+++.
>++.
<<+++++++++++++++.
>.
+++.
------.
--------.
>+.
>.
)"

    OutputDebug(Brainfuck(text))
}