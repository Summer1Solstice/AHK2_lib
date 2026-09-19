/************************************************************************
 * @description 根据输入的百分比浮点数返回屏幕像素
 * @author 
 * @date 2026/09/19
 * @version 0.0.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 计算屏幕坐标
 * @param pX 0-1之间的百分比，0表示左上角，1表示右下角
 * @param pY 垂直方向的百分比，0表示顶部，1表示底部
 * @returns {Array} 包含x和y坐标的数组
 */
PercentPixel(pX?, pY?) {
    static x := A_ScreenWidth, y := A_ScreenHeight
    pX := pX ?? 0
    pY := pY ?? 0
    if pX < 0 or pX > 1 or pY < 0 or pY > 1 {
        throw TypeError("pX and pY must be between 0 and 1")
    }
    return [Floor(x * pX), Floor(y * pY)]
}
;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    for i in PercentPixel(0.5, 0.5)
        OutputDebug(i "`n")
    ToolTip("PercentPixel(0.5, 0.5)", PercentPixel(0.5, 0.5))
    SetTimer(ToolTip, -3000)
}
;@Ahk2Exe-IgnoreEnd
