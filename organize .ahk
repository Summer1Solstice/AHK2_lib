#Requires AutoHotkey v2.0
FileEncoding("UTF-8-RAW")
file_list := []
loop files "*.ahk" {
    file_list.Push(A_LoopFileName)
}
README := FileRead("README.md")
new_readme := "# AHK2_lib`n`n# 包含脚本`n"
for i in file_list {
    if i ~= "Plus" {
        if skip ?? 0 {
            continue
        }
        RegExMatch(README, "#{2,}\s.*?Plus.*?\s*\n(.+\n)+", &match)
        new_readme .= match[0] "`n"
        skip := 1
        continue
    }
    if RegExMatch(README, "i)#{2,}\s" i "\s*\n(.+\n)+", &match) {
        new_readme .= Format("### {1}`n{2}`n", i, match[1])
    } else {
        new_readme .= Format("### {1}`n`n`n", i)
    }
}
fileobj := FileOpen("README.md", "w")
fileobj.Write(new_readme)
fileobj.Close()