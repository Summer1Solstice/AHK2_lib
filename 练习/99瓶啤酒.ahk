#Requires AutoHotkey v2.0

lyric1 := "
(
墙上有 {1} 瓶啤酒，{1} 瓶啤酒。
取下一瓶传给大家，墙上还剩 {2} 瓶啤酒。`n`n
)"
lyric2 := "
(
墙上有 1 瓶啤酒，1 瓶啤酒。
取下一瓶传给大家，墙上再也没有啤酒了。`n`n
墙上再也没有啤酒了，再也没有啤酒了。
去商店再买一些吧，墙上又有 99 瓶啤酒啦。
)"
lyrics := ""
beer := 99
while true {
    if beer = 1 {
        lyrics .= Format(lyric2)
        break
    }
    lyrics .= Format(lyric1, beer, beer - 1)
    beer -= 1
}
OutputDebug lyrics