#Requires AutoHotkey v2.0

/**
 * 鼠标连点器类 - 提供按键自动点击和长按功能
 * @param Key 要自动操作的按键名称
 * @param Mode 操作模式 ("click"，"c" 或 "hold"，"h")
 */
class AutoClicker {
    __New(Key, Mode) {
        this.key := Trim(Key, "{}")
        switch Mode, 0 {
            case "c": this.Call2(0)
            case "click": this.Call2(0)
            case "h": this.Call2(1)
            case "hold": this.Call2(1)
            default: throw "Invalid Mode, please use Click or Hold."
        }
    }
    Call2(n) {
        if n {
            this.Call := this.Hold, this.SendKey := Send.Bind("{" this.key " Down}")
        } else {
            this.Call := this.Click, this.SendKey := Send.Bind("{" this.key "}")
        }
    }
    flag := false
    Click() {
        if this.flag {
            this.flag := false
            SetTimer(this.SendKey, 0)
            SetTimer((*) => (ToolTip()), -100)
        } else {
            this.flag := true
            SetTimer(this.SendKey, 100)
            ToolTip(this.key " 连点", 0, 0)
        }
    }
    Hold() {
        if this.flag {
            this.flag := false
            Send "{" this.key " Up}"
            SetTimer(this.SendKey, 0)
            SetTimer((*) => (ToolTip()), -100)
        } else {
            this.flag := true
            SetTimer(this.SendKey, 100)
            ToolTip(this.key " 按住", 0, 0)
        }
    }
}