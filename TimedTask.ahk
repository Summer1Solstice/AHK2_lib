/************************************************************************
 * @description 定时任务，通过派生类创建实例。
 * @author 
 * @date 2026/04/13
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0
#Include <XZ\CustomVars>

class TimedTask {
    ; 多久后执行
    Seconds := 0, Minutes := 0, Hours := 0, Days := 0
    ; 基准时间
    BaseTime := A_Now
    ; 启动时间
    StartTime := 0
    ; 检测间隔
    TimerPeriod := 100
    ; 计算启动时间
    __CalculateTime(Now := this.BaseTime) {
        if not IsTime(Now) {
            throw "Invalid time"
        }
        for i in ["Seconds", "Minutes", "Hours", "Days"] {
            Now := DateAdd(Now, this.%i%, i)
        }
        this.StartTime := Now
    }
    ; 定时器
    __Timer() {
        if DateDiff(A_Now, this.StartTime, "Seconds") >= 0 {
            this.onTask()
            this.Close()
        }
    }
    Close() => SetTimer(this.Timer, 0)
    ; 运行
    Run() {
        if not this.HasMethod("onTask") {
            throw "onTask is not defined"
        }
        this.__CalculateTime()
        this.Timer := ObjBindMethod(this, "__Timer")
        Text := FormatTime(this.StartTime " T0 R")
        Text .= (DateDiff(A_Now, this.StartTime, "Seconds") >= 0) ? "`n启动时间早于当前时间，任务将立即启动！" : ""
        if MsgBox(Text, "Run Time", 1) = "OK" {
            SetTimer(this.Timer, this.TimerPeriod)
        } else {
            MsgBox("User Canceled")
        }
    }
}

; 示例 1天1时1分1秒后执行
class example extends TimedTask {
    Days := 1
    Hours := 1
    Minutes := 1
    Seconds := 1
    onTask() {
        MsgBox("Task Completed")
    }
}
; e := example()
; e.Run()
