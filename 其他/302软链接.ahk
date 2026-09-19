#Requires AutoHotkey v2.0
#Include <XZ\SplitPath2Object>

if not SourceFile := FileSelect("1", , "选择源文件", "*.exe") {  ; 选择源文件
    ExitApp
}
FileObj := SplitPath2Object(SourceFile)
if not LinkDir := FileSelect("D2", , "选择软链接目录") {  ; 选择软链接存放目录
    ExitApp
}

if SplitPath2Object(LinkDir).Drive != FileObj.Drive {
    ExitApp 1
}
SetWorkingDir(LinkDir)
if FileExist(FileObj.FileName) {
    FileRecycle(FileObj.FileName)
}
comm := Format('mklink "{3}" "{2}"', LinkDir, SourceFile, FileObj.FileName)
OutputDebug comm
Run(A_ComSpec " /c " comm)