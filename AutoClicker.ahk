/************************************************************************
 * @description 自动连点/按住器
 * @author Summer1Solstice
 * @date 2026/04/13
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 鼠标连点器类 - 提供按键自动点击和长按功能。
 * 单参数为连点模式，双参数为按住模式。
 * @param Key1 动作函数
 * @param Key2 动作函数
 */
class AutoClicker {
    __New(Key1, key2?) {
        if not (key1 is Func) {
            throw "AutoClicker: 请传入动作函数"
        }
        this.key1 := Key1
        if key2 ?? 0 {
            if not (key2 is Func) {
                throw "AutoClicker: 请传入动作函数"
            }
            this.key2 := key2
        }
    }
    flag := false

    Call() {
        if this.flag {
            this.flag := false
            this.HasMethod("key2") ? this.key2.Call() : ""
            SetTimer(this.key1, 0)
            ToolTip()
        } else {
            this.flag := true
            SetTimer(this.key1, 100)
            ToolTip("自动按键工作中……", 0, 0)
        }
    }
}