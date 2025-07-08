#Requires AutoHotkey v2.0
; 提供给右键菜单或命令行调用的示例
try {
    switch A_Args.Length {
        case 1: dir := A_Args[1], mode := "F", FilePattern := "*.*"
        case 2: dir := A_Args[1], mode := A_Args[2], FilePattern := "*.*"
        case 3: dir := A_Args[1], mode := A_Args[2], FilePattern := A_Args[3]
        default: throw Error()
    }
    dir := RTrim(dir, "\") . "\"
    files := ListAllFiles(dir, FilePattern, mode)
    ui := Gui()
    ui.SetFont("S12")
    ui.AddEdit("-Wrap ReadOnly -WantReturn R15 W400", files)
    ui.AddButton("Default WP", "复制/copy").OnEvent("Click", (*) => (A_Clipboard := files, ExitApp(0)))
    ui.Show()
} catch {
    MsgBox("
    (
参数错误，请检查参数！

参数1: 目录路径
参数2: 如果为空或省略, 则只包括文件且不递归子文件夹. 否则, 指定一个或多个下列字母:
      •D = 包含目录(文件夹).
      •F = 包含文件. 如果同时省略 F 和 D, 则仅包含文件而不包括目录.
      •R = 递归到子目录(子文件夹). 
    )")
    ExitApp 1
}

ListAllFiles(Dir, FilePattern, mode := "") {
    result := ""
    loop files dir . FilePattern, mode {
        result .= A_LoopFileName "`n"
    }
    return result
}