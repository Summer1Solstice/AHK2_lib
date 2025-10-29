#Requires AutoHotkey v2.0

Brainfuck(Code, MomorySize := 100) {
    ; 初始化变量
    CodeList := []  ; 创建代码列表
    CodePtr := 1    ; 代码指针
    MemoryPtr := 1  ; 内存指针
    output := []    ; 创建输出变量
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
                throw Error("括号不匹配/Bracket mismatch")
            }
            left := Bracket.Pop()
            right := A_Index
            BracketMap.Set(left, right)
            BracketMap.Set(right, left)
        }
    }
    if Bracket.Length != 0 {
        throw Error("括号不匹配/Bracket mismatch")
    }
    ; 运行代码
    while CodePtr <= CodeList.Length {
        switch CodeList[CodePtr] {
            case "+":
                MemoryCells[MemoryPtr] := MemoryCells.Get(MemoryPtr) + 1 & 255
            case "-":
                MemoryCells[MemoryPtr] := MemoryCells.Get(MemoryPtr) - 1 & 255
            case "<":
                MemoryPtr -= 1
                if MemoryPtr = 0 {
                    throw IndexError("内存指针越界/Memory pointer out of bounds")
                }
            case ">":
                MemoryPtr += 1
                if MemoryPtr = MomorySize {
                    throw IndexError("内存指针越界/Memory pointer out of bounds")
                }
            case ",":
                text := InputBox()
                MemoryCells[MemoryPtr] := Ord(SubStr(text.Value, 1, 1))
            case ".":
                output.Push(MemoryCells.Get(MemoryPtr))
            case "[":
                if not MemoryCells.Get(MemoryPtr) {
                    CodePtr := BracketMap.Get(CodePtr) - 1
                }
            case "]":
                if MemoryCells.Get(MemoryPtr) {
                    CodePtr := BracketMap.Get(CodePtr) - 1
                }
        }
        CodePtr += 1
    }
    buff := Buffer(output.Length, 0)
    for i in output {
        NumPut("uchar", i, buff, A_Index - 1)
    }
    return StrGet(buff, "utf-8")
}

if A_ScriptName = "Brainfuck.ahk" {
    text := "
(
+++++++++++[>++++++>+++++++++>++++++++>++++>+++>+<<<<<<-]>+++
+++.>++.+++++++..+++.>>.>-.<<-.<.+++.------.--------.>>>+.>-.
)"
    text1 := "
    (
228 185 146 乒 146 乓
+++ +++ +++
[>---<-]
+++ ++++
[>>----- -----<<-]
+++++ +++++
[>>>----- ----- -<<<-]
>-.
>-.
>.
<<.
>.
>+.
    )"
    OutputDebug(Brainfuck(text))
}