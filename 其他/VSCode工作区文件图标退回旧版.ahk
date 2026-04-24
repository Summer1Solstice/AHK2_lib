#Requires AutoHotkey v2.0

PathA := EnvGet("LOCALAPPDATA") "\Programs\Microsoft VS Code\"
PathB := ""
PathC := "\resources\app\resources\win32\"
loop files PathA "*", "D" {
    if A_LoopFileName ~= "^\w{9,}" {
        PathB := A_LoopFileName
        break
    }
}
Path := Format("{1}{2}{3}", PathA, PathB, PathC)
SetWorkingDir(Path)
FileRecycle("code.ico")
FileCopy("default.ico", "code.ico")