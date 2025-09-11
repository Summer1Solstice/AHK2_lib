/************************************************************************
 * @description 
 * @todo ui基本写完，接下来写工作逻辑
 * @date 2025/09/10
 * @version 0.0.5
 ***********************************************************************/
#Requires AutoHotkey v2.0
FileEncoding("CP0")
CoordMode("Mouse", "Screen")

; 前置工作-检查
ConfigFileName := A_ScriptName ".ini"
if not FileExist(ConfigFileName) {
    if MsgBox("缺少配置文件，是否创建！", "提示", "okcancel") = "ok" {
        FileAppend("[config]`nSepTime=100`nLoopCount=-1`nNowPlan=示例`n[示例]`nLoopCount=-1`nmm 0,0`n100,100"
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
    NowEditPlan := ""
    on_off := true
    window := true
}
VarInit()
; 创建窗口:
MainGui := Gui("-MinimizeBox")
LV := MainGui.AddListView("xm Grid Section", ["方案名", "状态"])
EditBar := MainGui.AddEdit("xm y+35 r10 wp ", IniRead(ConfigFileName, NowPlan)), NowEditPlan := NowPlan
LV.GetPos(, , , &h), h := h + 6
QH := MainGui.AddButton("xs ys+" h, "切换方案")
BC := MainGui.AddButton("x+5", "保存方案")
MainGui.AddButton("x+5", "退出").OnEvent("Click", (*) => (ExitApp()))
NowEditTip := MainGui.AddText("x+5 yp+5 w87", "↓" NowEditPlan "↓")
; 创建右键菜单
ContextMenu := Menu()
ContextMenu.Add("新建方案", NewPlan)
ContextMenu.Add("删除方案", DeletePlan)
; 操作菜单
LV.OnEvent("ContextMenu", ShowContextMenu)
ShowContextMenu(LV, Item, IsRightClick, X, Y)  ; 响应右键或 Apps 键.
{
    ; 在所提供的 X 和 Y 坐标处显示菜单.
    ; 这些应该被使用, 因为即使用户按了 Apps 键, 它们也能提供正确的坐标:
    ContextMenu.Show(X, Y)
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
    NowEditTip.Value := "↓" NowEditPlan "↓"
}
; 方案切换
QH.OnEvent("Click", SwitchPlan)
SwitchPlan(*) {
    plan := LV.GetText(LV.GetNext(0, "F"))
    if plan = "config" {
        MsgBox("你不能切换到 config")
        return
    } else if plan = "方案名" {
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
    IniWrite(EditBar.Value, ConfigFileName, NowEditPlan)
    LVAddPlan()
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

