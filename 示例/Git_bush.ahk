#Requires AutoHotkey v2.0
command := Format(
    'C:\Program Files\Git\git-bash.exe --cd={1} -c "{2}"'
    , A_ScriptDir
    , "echo 123 > temp.txt"
)
Run(command)