/************************************************************************
 * @description 合并两个缓冲对象为一个新缓冲对象
 * @date 2026/04/13
 * @version 0.0.1
 * @learn https://learn.microsoft.com/zh-cn/windows-hardware/drivers/ddi/wdm/nf-wdm-rtlcopymemory
 * @learn https://learn.microsoft.com/zh-cn/windows/win32/devnotes/rtlmovememory
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 合并两个缓冲对象
 * @param buf1 
 * @param buf2 
 * @returns {Buffer} 合并后的新缓冲对象
 */
MergeBuffer(buf1, buf2) {
    bfs := Buffer(buf1.Size + buf2.Size)
    DllCall("RtlCopyMemory", "Ptr", bfs.Ptr, "Ptr", buf1.Ptr, "Uint", buf1.Size)
    DllCall("RtlCopyMemory", "Ptr", bfs.Ptr + buf1.Size, "Ptr", buf2.Ptr, "Uint", buf2.Size)
    return bfs
}
;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    buf1 := Buffer(1)
    buf2 := Buffer(1)
    StrPut("h", buf1, 1, "utf-8")
    StrPut("i", buf2, 1, "utf-8")
    OutputDebug(StrGet(MergeBuffer(buf1, buf2), "utf-8"))
}
;@Ahk2Exe-IgnoreEnd
