/************************************************************************
 * @description 用于将Dota2的物品和英雄的搜索别名建立一个对照表
 * @author 
 * @date 2026/04/18
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

class Dota2SearchAliases {
    __New(Path) {
        this.Path := Path
        this.Dict := Map()
        this.output := ""
        this.Flag1Regex := ""
        this.Flag2Regex := ""
    }
    Run() {
        loop read this.Path {
            if RegExMatch(A_LoopReadLine, "i)" this.Flag1Regex, &match) {
                this.Dict.Set(match[1], match[2])
            } else if RegExMatch(A_LoopReadLine, "i)" this.Flag2Regex, &match) {
                if this.Dict.Has(match[1]) {
                    this.output .= Format("|{1}|{2}|`n", this.Dict.Get(match[1]), match[2])
                } else if this.Dict.Has(match[1] ":n") {
                    this.output .= Format("|{1}|{2}|`n", this.Dict.Get(match[1] ":n"), match[2])
                } else {
                    OutputDebug match[1] " not found`n"
                }
            }
        }
        return this.output
    }
}
Store := Dota2SearchAliases("resource\localization\abilities_schinese.txt")
Store.output := "|物品名|搜索关键词|`n| --- | --- |`n"
Store.Flag1Regex := '^\t+"(?:DOTA_Tooltip_Ability_item_|npc_dota_hero_)(.*?)(?<!__name_alias)"\t+"(.*?)"$'
Store.Flag2Regex := '^\t+"DOTA_SearchAlias_Ability_item_(.*?)"\t+"(.*?)"$'
FileAppend(Store.Run(), "Store.txt", "utf-8")

Hero := Dota2SearchAliases("resource\localization\dota_schinese.txt")
Hero.Dict := Store.Dict
Hero.output := "|英雄名|搜索关键词|`n| --- | --- |`n"
Hero.Flag1Regex := "^Dota2Dota2Dota2$"
Hero.Flag2Regex := '^\t+"npc_dota_hero_(.*?)__name_alias"\t+"(.*?)"$'
FileAppend(Hero.Run(), "Hero.txt", "utf-8")