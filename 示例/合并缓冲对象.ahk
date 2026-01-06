#Requires AutoHotkey v2.0

; 创建两个示例缓冲
buffer1 := Buffer(StrPut("AB", "CP0") - 1)
buffer2 := Buffer(StrPut("CD", "CP0") - 1)

; 填充一些示例数据
NumPut("UChar", 65, buffer1, 0)  ; 'A'
NumPut("UChar", 66, buffer1, 1)  ; 'B'
NumPut("UChar", 67, buffer2, 0)  ; 'C'
NumPut("UChar", 68, buffer2, 1)  ; 'D'
OutputDebug(NumGet(buffer1, 1,"int"))
; 合并缓冲
; MergedBuffer := MergeBuffers(buffer1, buffer2)

MergeBuffers(buf1, buf2) {
    ; 创建新的缓冲，大小为两个缓冲之和
    merged := Buffer(buf1.Size + buf2.Size)

    ; 复制第一个缓冲的数据
    DllCall("RtlMoveMemory", "Ptr", merged.Ptr, "Ptr", buf1.Ptr, "UPtr", buf1.Size)

    ; 复制第二个缓冲的数据到合并缓冲的后半部分
    DllCall("RtlMoveMemory", "Ptr", merged.Ptr + buf1.Size, "Ptr", buf2.Ptr, "UPtr", buf2.Size)

    return merged
}
; OutputDebug StrGet(MergedBuffer,,"CP0")