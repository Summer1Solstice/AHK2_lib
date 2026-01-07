/************************************************************************
 * @description 带gui的鼠标序列动作，实现了鼠标移动<mm>鼠标点击<mc>的实现
 * @date 2025/09/13
 * @version 1.0.0
 ***********************************************************************/
#Requires AutoHotkey v2.0
FileEncoding("CP0")
CoordMode("Mouse", "Screen")

; 前置工作-检查
ConfigFileName := A_ScriptName ".ini"
if not FileExist(ConfigFileName) {
    if MsgBox("缺少配置文件，是否创建！", "提示", "okcancel") = "ok" {
        FileAppend("[config]`nSepTime=100`nLoopCount=1`nNowPlan=example`n[example]`nLoopCount=-1`nmm 0,0`n100,100"
            , ConfigFileName)
    } else {
        ExitApp()
    }
}
; 变量初始化
VarInit() {
    global
    SectionList := StrSplit(IniRead(ConfigFileName), "`n")
    NowPlan := IniRead(ConfigFileName, "config", "NowPlan")
    SepTime_g := IniRead(ConfigFileName, "config", "SepTime")
    LoopCount_g := IniRead(ConfigFileName, "config", "LoopCount")
}
VarInit()
NowEditPlan := NowPlan
on_off := true
window := true
; 创建窗口:
MainGui := Gui("-MinimizeBox")
LV := MainGui.AddListView("xm Grid Section", ["方案名", "状态"])
EditBar := MainGui.AddEdit("xm y+35 r10 wp ", IniRead(ConfigFileName, NowPlan))
LV.GetPos(, , , &h), h := h + 6
QH := MainGui.AddButton("xs ys+" h, "切换方案")
BC := MainGui.AddButton("x+5", "保存方案")
MainGui.AddButton("x+5", "退出").OnEvent("Click", (*) => (ExitApp()))
NowEditTip := MainGui.AddText("x+5 yp+5 w87", "↓" NowEditPlan "↓")
ModifyNowEditTip := (value) => (NowEditTip.Value := "↓" value "↓")
; 创建右键菜单
ContextMenu := Menu()
ContextMenu.Add("新建方案", NewPlan)
ContextMenu.Add("删除方案", DeletePlan)
ContextMenu.Add("重命名方案", RenamePlan)
; 操作菜单
LV.OnEvent("ContextMenu", ShowContextMenu)
ShowContextMenu(LV, Item, IsRightClick, X, Y)  ; 响应右键或 Apps 键.
{
    ; 在所提供的 X 和 Y 坐标处显示菜单.
    ; 这些应该被使用, 因为即使用户按了 Apps 键, 它们也能提供正确的坐标:
    ContextMenu.Show(X, Y)
}
; 新建方案
NewPlan(*) {
    if MsgBox("是否新建一个方案？", "提示", "okcancel") = "ok" {
        NewPlanName := InputBox("请输入方案名", "新建方案")
        if NewPlanName.Value = "" {
            MsgBox("方案名不能为空")
            return
        } else if NewPlanName.Value = "config" {
            MsgBox("方案名不能为 config")
            return
        }
        IniWrite("", ConfigFileName, NewPlanName.Value)
        LVAddPlan()
    }
}
; 删除方案
DeletePlan(*) {
    plan := LV.GetText(LV.GetNext(0, "F"))
    if MsgBox("是否删除方案 " plan, "提示", "okcancel") = "ok" {
        IniDelete(ConfigFileName, plan)
        LVAddPlan()
    }
}
; 重命名方案
RenamePlan(*) {
    plan := LV.GetText(LV.GetNext(0, "F"))
    if plan = "config" {
        MsgBox("你不能重命名 config")
        return
    }
    if plan = "方案名" or plan = "状态" {
        return
    }
    NewPlanName := InputBox("请输入方案名", "重命名方案", , plan)
    if NewPlanName.Value = "" {
        MsgBox("方案名不能为空")
    }
    text := IniRead(ConfigFileName, plan)
    IniWrite(text, ConfigFileName, NewPlanName.Value)
    if NowPlan = plan {
        global NowPlan := NewPlanName.Value
        IniWrite(NewPlanName.Value, ConfigFileName, "config", "NowPlan")
    }
    if Trim(NowEditTip.Value, "↓") = plan {
        ModifyNowEditTip(NewPlanName.Value)
    }
    IniDelete(ConfigFileName, plan)
    LVAddPlan()
}

; 方案被单击时切换下方编辑栏的内容
LV.OnEvent("Click", ChangeTheEditingBar)
ChangeTheEditingBar(LV, RowNumber) {
    text := LV.GetText(RowNumber)
    if text = "方案名" {
        return
    }
    EditBar.Value := IniRead(ConfigFileName, text)
    global NowEditPlan := text
    ModifyNowEditTip(NowEditPlan)
}
; 方案切换
QH.OnEvent("Click", SwitchPlan)
SwitchPlan(*) {
    plan := LV.GetText(LV.GetNext(0, "F"))
    if plan = "config" {
        MsgBox("你不能切换到 config")
        return
    }
    if plan = "方案名" or plan = "状态" {
        return
    }
    global NowPlan := LV.GetText(LV.GetNext(0, "F"))
    IniWrite(NowPlan, ConfigFileName, "config", "NowPlan")
    LVAddPlan()
}
; 修改方案后保存
BC.OnEvent("Click", SavePlan)
SavePlan(*) {
    if NowEditPlan = "" {
        MsgBox("请选择一个方案")
        return
    }
    IniDelete(ConfigFileName, NowEditPlan)
    IniWrite(EditBar.Value, ConfigFileName, NowEditPlan)
    LVAddPlan()
}

; 添加/刷新方案
LVAddPlan() {
    VarInit()
    LV.Delete()
    for i in SectionList {
        if i = NowPlan {
            LV.Add(, i, " ✔ ")
        } else {
            LV.Add(, i)
        }
    }
    LV.ModifyCol()
    LV.ModifyCol(1, "autohdr")
}
LVAddPlan()
MainGui.Show()

F1:: {
    global on_off := true
    ActionList := []
    Ago := ""
    text := IniRead(ConfigFileName, NowPlan)
    loop parse text, "`n" {
        Field := StrReplace(Trim(A_LoopField, " "), ",", ", ")
        if InStr(Field, "=") {
            temp := StrSplit(Field, "=")
            switch StrLower(temp[1]) {
                case "septime": SepTime := temp[2]
                case "loopcount": LoopCount := temp[2]
            }
        } else {
            temp := StrSplit(Field, [", ", " "])
            if temp.Length = 1 {
                switch temp[1] {
                    case "mm": Ago := "MouseMove"
                    case "mc": Ago := "MouseClick"
                }
                continue
            }
            switch i := StrLower(temp.RemoveAt(1)) {
                case "mm": ActionList.Push(["MouseMove", temp*]), Ago := "MouseMove"
                case "mc": ActionList.Push(["MouseClick", temp*]), Ago := "MouseClick"
                default: ActionList.Push([Ago, i, temp*])
            }
        }
    }
    while true {
        for i in ActionList {
            if not on_off {
                return 0
            }
            var := i.Clone()
            Command := var.RemoveAt(1)
            %Command%(var*)
            Sleep SepTime ?? SepTime_g
        }
        lc := LoopCount ?? LoopCount_g
        if (lc > 0) and (--lc = 0) {
            break
        }
    }
    return 1
}
F2:: {
    global on_off := false
    ToolTip("停止")
    SetTimer (*) => (ToolTip), -3000
}
F3:: {
    if NowEditPlan {
        MouseGetPos(&x, &y)
        EditBar.Value .= "`n" x "," y
    }
}
F4::
WindowSwitch(flag, *) {
    global window
    if flag = "F4" {
        if window {
            MainGui.Hide()
        } else {
            MainGui.Show()
            MainGui.Restore()
        }
    }
    window := !window
}
MainGui.OnEvent("Close", WindowSwitch)