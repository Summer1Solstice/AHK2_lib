/************************************************************************
 * @description `A_Args` 命令行参数解析，如何使用？请看文件末尾的示例。
 * @author 
 * @date 2026/05/25
 * @version 0.1.0
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
        this.__help_k := "`n关键词参数:`n    -v, --version: 显示版本号`n    -h, --help: 显示帮助信息"
        this.__help_p := "`n位置参数:"
        this.__version := A_ScriptName " " version
    }
    __Args := Map()
    __Args.CaseSense := false
    __Position := []
    __AddObjectProp(value, argument, alias?) {
        this.%argument% := value
        if alias ?? 0 {
            this.%alias% := value
        }
    }
    __regex := "S)^(?P<key>(?P<prefix>-{0,2})(?P<name>\w+))(?P<eq>=?)(?P<value>.*?)$"
    /**
     * 添加参数
     * @param argument 参数名；以`-`或`--`开头为关键词参数，否则为位置参数
     * @param alias 别名；位置参数不能有别名，必须与参数名类型相同
     * @param default 默认值
     * @param help 帮助文本
     */
    AddArgument(argument, alias?, default?, help := "") {
        if not RegExMatch(argument, this.__regex, &match) {
            throw "参数格式错误: " . argument
        }
        if match["prefix"] {
            key := match["name"]
        } else {
            key := match["key"]
        }
        IsSet(default) ? this.%key% := default : ""
        if IsSet(alias) {
            if not RegExMatch(alias, this.__regex, &ma) {
                throw "别名参数格式错误: " . alias
            }
            if (match["prefix"] and not ma["prefix"]) or ( not match["prefix"] and ma["prefix"]) {
                throw "关键词参数和位置参数不能同时存在: " . argument . " " . alias
            }
            if not match["prefix"] {
                throw "位置参数不能有别名: " . argument . " " . alias
            }
            if ma["prefix"] {
                k := ma["name"]
                this.__Args[alias] := this.__AddObjectProp.Bind(this, , key, k)
            } else {
                k := ma["key"]
                this.__Position.InsertAt(1, k)
            }
            IsSet(default) ? this.%k% := default : ""
        }
        help := "`n    " . argument . (IsSet(alias) ? (", " . alias . ": ") : ": ") . help
        if match["prefix"] {
            this.__help_k .= help
            this.__Args[argument] := this.__AddObjectProp.Bind(this, , key, k?)
        } else {
            this.__help_p .= help
            this.__Position.InsertAt(1, key)
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
                if this.__Args.Has(match["key"]) {
                    if match["eq"] {
                        this.__Args[match["key"]](match["value"])
                    } else {
                        this.__Args[match["key"]](A_Args[A_Index + 1])
                        skip := true
                    }
                } else {
                    if this.__Position.Length {
                        this.%this.__Position.Pop()% := i
                    } else {
                        Print("无效参数: " . i)
                    }
                }
            }
        }
    }
}
/*
A_Args := [4, "--abc", "1", "-d=2", "--cos=3", 5]
; A_Args := ["-v"]
args := ArgsParse("A_Args 解析", "V0.0.1")
args.AddArgument("--abc", "-a", "abc", "ABC")
args.AddArgument("--def", "-d", "def", "DEF")
args.AddArgument("--cos", "-c", "cos", "COS")
args.AddArgument("p1", , 0, "Position arg 1")
args.AddArgument("p2", , 0, "Position arg 2")
args.ParseArgs()
OutputDebug args.abc
OutputDebug args.a
OutputDebug args.def
OutputDebug args.d
OutputDebug args.cos
OutputDebug args.c
OutputDebug args.p1
OutputDebug args.p2
; */
