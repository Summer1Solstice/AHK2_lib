/************************************************************************
 * @description `A_Args` 命令行参数解析，仅支持以下形式的参数：
 * - `-k` or `--key`    定义格式
 * - `-k 0` or `--key 0`    可解析
 * - `-k=1` or `--key=1`    可解析
 * @author 
 * @date 2026/05/25
 * @version 0.0.2
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
        this.__help .= "`n    -v --version: 显示版本号"
        this.__help .= "`n    -h --help: 显示帮助信息"
        this.__version := A_ScriptName " " version
    }
    __regex := "S)^(?P<key>(?P<prefix>-{1,2})(?P<name>\w+))(?P<eq>=?)(?P<value>.*?)$"
    __Args := Map()
    __Args.CaseSense := false

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
    AddArgument(argument, alias?, default?, help?) {
        if RegExMatch(argument, this.__regex, &match) {
            key := match["name"]
            (default ?? 0) ? this.%key% := default : ""
        } else {
            throw "参数: " argument " 定义格式错误"
        }
        if (alias ?? 0) {
            if RegExMatch(alias, this.__regex, &m) {
                k := m["name"]
                this.__Args.Set(alias, this.__AddObjectProp.Bind(this, , key, k))
                (default ?? 0) ? this.%k% := default : ""
            } else {
                throw "别名参数: " alias " 定义格式错误"
            }
        }
        this.__Args.Set(argument, this.__AddObjectProp.Bind(this, , key, k?))
        if help ?? 0 {
            this.__help .= "`n    " argument
            if alias ?? 0 {
                this.__help .= " " alias
            }
            this.__help .= ": " help
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
                Print(this.__help)
            } else if i = "-v" or i = "--version" {
                Print(this.__version)
            }
            if skip {
                skip := false
                continue
            }
            if RegExMatch(i, this.__regex, &match) {
                key := match["key"]
                if not this.__Args.Has(key) {
                    throw "无效参数: " i
                }
                if match["eq"] {
                    this.__Args[key](match["value"])
                } else {
                    this.__Args[key](A_Args[A_Index + 1])
                    skip := true
                }
            }
        }
    }
}
/*
A_Args := ["-a", "1", "-d=2", "--cos=3","-h"]
args := ArgsParse("A_Args 解析", "V0.0.1")
args.AddArgument("--abc", "-a", "abc", "ABC")
args.AddArgument("--cos", "-c", "cos", "COS")
args.AddArgument("--def", "-d", "def", "DEF")
args.ParseArgs()