#Requires AutoHotkey v2.0
#Include <XZ\SplitPath2Object>

if A_Args.Length == 0 {
    throw "请指定玩家ID"
}
PalyerId := A_Args[1]

BackupPath := EnvGet("USERPROFILE") . "\Downloads\"  ; 备份路径
GameId := "570"
BackupPath .= GameId
if not RegExMatch(RegRead("HKCR\steam\shell\open\command\"), '"(.*?)"', &Match) {
    throw "未找到Steam安装路径"
}
Dota2Config := Format("{1}\userdata\{2}\{3}", SplitPath2Object(Match[1]).Dir, PalyerId, GameId)
if not InStr(FileExist(Dota2Config), "D") {
    throw Dota2Config " 不存在"
}
if InStr(FileExist(BackupPath), "D") {
    FileRecycle(BackupPath)
}
DirCopy(Dota2Config, BackupPath)