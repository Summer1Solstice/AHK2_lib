/************************************************************************
 * @description `A_Args` 命令行参数解析，如何使用？请看文件末尾的示例。
 * @author 
 * @date 2026/05/25
 * @version 0.0.3
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * A_Args 解析
 * @param description 描述
 * @param version 版本号
 */
class ArgsParse {
    __New(description, version) {
        this.__help := description
        this.__help_k := "`n关键词参数:"
        this.__help_k .= "`n    -v, --version: 显示版本号"
        this.__help_k .= "`n    -h, --help: 显示帮助信息"
        this.__help_p := "`n位置参数:"
        this.__version := A_ScriptName " " version
    }
    __regex := "S)^(?P<key>(?P<prefix>-{1,2})(?P<name>\w+))(?P<eq>=?)(?P<value>.*?)$"
    __keyword := Map()
    __keyword.CaseSense := false
    __position := []
    __AddObjectProp(value, argument, alias?) {
        this.%argument% := value
        if alias ?? 0 {
            this.%alias% := value
        }
    }
    /**
     * 添加关键词参数
     * @param argument 参数名
     * @param alias 别名
     * @param default 默认值
     * @param help 帮助文本
     */
    AddKeywordArgument(argument, alias?, default?, help?) {
        if RegExMatch(argument, this.__regex, &match) {
            key := match["name"]
            IsSet(default) ? this.%key% := default : ""
        } else {
            throw "参数: " argument " 定义格式错误"
        }
        if IsSet(alias) {
            if RegExMatch(alias, this.__regex, &m) {
                k := m["name"]
                this.__keyword.Set(alias, this.__AddObjectProp.Bind(this, , key, k))
                IsSet(default) ? this.%k% := default : ""
            } else {
                throw "别名参数: " alias " 定义格式错误"
            }
        }
        this.__keyword.Set(argument, this.__AddObjectProp.Bind(this, , key, k?))
        if help ?? 0 {
            this.__help_k .= "`n    " argument
            if alias ?? 0 {
                this.__help_k .= ", " alias
            }
            this.__help_k .= ": " help
        }
    }
    /**
     * 添加位置参数
     * @param argument 参数名
     * @param alias 别名
     * @param default 默认值
     * @param help 帮助文本
     */
    AddPositionArgument(argument, alias?, default?, help?) {
        if RegExMatch(argument, "^[\w-]+$") {
            IsSet(default) ? this.%argument% := default : ""
        } else {
            throw "参数: " argument " 定义格式错误"
        }
        if IsSet(alias) {
            if RegExMatch(alias, "^[\w-]+$") {
                IsSet(default) ? this.%alias% := default : ""
            } else {
                throw "别名参数: " alias " 定义格式错误"
            }
        }
        this.__position.InsertAt(1, this.__AddObjectProp.Bind(this, , argument, alias?))
        if help ?? 0 {
            this.__help_p .= "`n    " argument
            if alias ?? 0 {
                this.__help_p .= ", " alias
            }
            this.__help_p .= ": " help
        }
    }

    /**
     * 解析 A_Args
     */
    ParseArgs() {
        if not A_Args.Length {
            return
        }
        Print(text) {
            try {
                FileAppend(text, "*")
            } catch {
                MsgBox(text)
            }
            Exit()
        }
        skip := false
        for i in A_Args {
            if i = "-h" or i = "--help" {
                Print(this.__help . this.__help_k . this.__help_p)
            } else if i = "-v" or i = "--version" {
                Print(this.__version)
            }
            if skip {
                skip := false
                continue
            }
            if RegExMatch(i, this.__regex, &match) {
                key := match["key"]
                if not this.__keyword.Has(key) {
                    throw "无效关键词参数: " i
                }
                if match["eq"] {
                    this.__keyword[key](match["value"])
                } else {
                    this.__keyword[key](A_Args[A_Index + 1])
                    skip := true
                }
            } else {
                if not this.__position.Length {
                    throw "多余的位置参数: " i
                }
                key := this.__position.Pop()
                key(i)
            }
        }
    }
}
/*
A_Args := [4, "--abc", "1", "-d=2", "--cos=3", 5]
args := ArgsParse("A_Args 解析", "V0.0.1")
args.AddKeywordArgument("--abc", "-a", "abc", "ABC")
args.AddKeywordArgument("--cos", "-c", "cos", "COS")
args.AddKeywordArgument("--def", "-d", "def", "DEF")
args.AddPositionArgument("pos", "p", 0, "POS")
args.AddPositionArgument("pos2", "p2", 0, "POS2")
args.ParseArgs()
OutputDebug args.a ; 1
OutputDebug args.d  ; 2
OutputDebug args.c  ; 3
OutputDebug args.p  ; 4
OutputDebug args.p2 ; 5
*/
