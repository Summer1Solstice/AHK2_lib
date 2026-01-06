#Requires AutoHotkey v2.0

obj := { _value: 0 }
GSC := { get: (this) => (this._value)
    , set: (this, value) => (this._value := value)
    , call: (this) => (OutputDebug(this._value))
}
obj.DefineProp("value", GSC)
obj.value := 1
obj.value()