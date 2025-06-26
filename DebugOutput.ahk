#Requires AutoHotkey v2.0

class DebugOutput {
    static __New() {
        (Object.Prototype.DefineProp)(Primitive.Prototype, "Debug", { call: Debug })
        Debug(this) => OutputDebug(this "`n")
    }
}