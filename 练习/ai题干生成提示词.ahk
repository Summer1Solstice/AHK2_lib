#Requires AutoHotkey v2.0

Prompt := "
(
/*以这种格式给出编程练习题题目，注意使用/**/注释整体内容，请严格依据已有信息作答，杜绝无依据的内容编造。
*不指定不猜想练习使用的编程语言，输出回答时包含在代码块中，删除上述说明。
*练习：大衍总数
*这里写题目，适当换行美化格式方便阅读
*这里写答案，给出方便验证的格式，如JSON等
*/
)"
if RegExMatch(Prompt, "m)^\*练习：(.*?)$", &Title) {
    Title := Title[1]
    A_Clipboard := Prompt
    file_name := Title ".ahk"
    if not FileExist(file_name)
        FileAppend("#Requires AutoHotkey v2.0`n`n", file_name, "UTF-8-RAW `n")
}