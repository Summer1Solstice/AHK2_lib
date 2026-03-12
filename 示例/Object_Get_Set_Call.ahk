#Requires AutoHotkey v2.0

obj := { _value: 0 }
GSC := {
    Get: (this) => (this._value),
    Set: (this, value) => (this._value := value),
    Call: (this) => (OutputDebug(this._value))
}
obj.DefineProp("value", GSC)
obj.value := 1
obj.value()
OutputDebug(obj.value)
