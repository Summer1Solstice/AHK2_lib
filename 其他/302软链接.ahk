#Requires AutoHotkey v2.0
#Include <XZ\SplitPath2Object>

if not filedir := FileSelect("D2", , "选择目标目录") {  ; 选择软链接存放目录
    ExitApp
}
dirobj := SplitPath2Object(filedir)
if not filelink := FileSelect("1", filedir, "选择链接文件") {  ; 选择目标链接文件
    ExitApp
}
fileobj := SplitPath2Object(filelink)
if dirobj.Drive != fileobj.Drive {
    ExitApp 1
}
SetWorkingDir(filedir)
if FileExist(filelink) {
    FileRecycle(filelink)
}
comm := Format('mklink "{3}" "{2}"', filedir, filelink, fileobj.FileName)
OutputDebug comm
Run(A_ComSpec " " comm)
