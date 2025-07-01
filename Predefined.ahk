#Requires AutoHotkey v2.0
/** 为Windows的C++数据类型预定义字节长度
 * @description 预定义字节长度
 * @learn Windows 数据类型 https://learn.microsoft.com/zh-cn/windows/win32/winprog/windows-data-types
 * @learn 数据类型范围 https://learn.microsoft.com/zh-cn/cpp/cpp/data-type-ranges?view=msvc-170
 */
class DTypes {  ; 数据来源：https://github.com/jNizM/AutoHotkey_MSDN_Types
    static ATOM := { Type: "ATOM", TypeA: "UShort", Size: 2 }
    static BOOL := { Type: "BOOL", TypeA: "Int", Size: 4 }
    static BOOLEAN := { Type: "BOOLEAN", TypeA: "UChar", Size: 1 }
    static BYTE := { Type: "BYTE", TypeA: "UChar", Size: 1 }
    static CCHAR := { Type: "CCHAR", TypeA: "Char", Size: 1 }
    static CHAR := { Type: "CHAR", TypeA: "Char", Size: 1 }
    static COLORREF := { Type: "COLORREF", TypeA: "UInt", Size: 4 }
    static DWORD := { Type: "DWORD", TypeA: "UInt", Size: 4 }
    static DWORD32 := { Type: "DWORD32", TypeA: "UInt", Size: 4 }
    static DWORD64 := { Type: "DWORD64", TypeA: "Int64", Size: 8 }
    static DWORDLONG := { Type: "DWORDLONG", TypeA: "Int64", Size: 8 }
    static DWORD_PTR := { Type: "DWORD_PTR", TypeA: "UPtr", Size: 8 }
    static FLOAT := { Type: "FLOAT", TypeA: "Float", Size: 4 }
    static HACCEL := { Type: "HACCEL", TypeA: "Ptr", Size: 8 }
    static HALF_PTR := { Type: "HALF_PTR", TypeA: "Short (32) | Int (64)", Size: 4 }
    static HANDLE := { Type: "HANDLE", TypeA: "Ptr", Size: 8 }
    static HBITMAP := { Type: "HBITMAP", TypeA: "Ptr", Size: 8 }
    static HBRUSH := { Type: "HBRUSH", TypeA: "Ptr", Size: 8 }
    static HCOLORSPACE := { Type: "HCOLORSPACE", TypeA: "Ptr", Size: 8 }
    static HCONV := { Type: "HCONV", TypeA: "Ptr", Size: 8 }
    static HCONVLIST := { Type: "HCONVLIST", TypeA: "Ptr", Size: 8 }
    static HCURSOR := { Type: "HCURSOR", TypeA: "Ptr", Size: 8 }
    static HDC := { Type: "HDC", TypeA: "Ptr", Size: 8 }
    static HDDEDATA := { Type: "HDDEDATA", TypeA: "Ptr", Size: 8 }
    static HDESK := { Type: "HDESK", TypeA: "Ptr", Size: 8 }
    static HDROP := { Type: "HDROP", TypeA: "Ptr", Size: 8 }
    static HDWP := { Type: "HDWP", TypeA: "Ptr", Size: 8 }
    static HENHMETAFILE := { Type: "HENHMETAFILE", TypeA: "Ptr", Size: 8 }
    static HFILE := { Type: "HFILE", TypeA: "Int", Size: 8 }
    static HFONT := { Type: "HFONT", TypeA: "Ptr", Size: 8 }
    static HGDIOBJ := { Type: "HGDIOBJ", TypeA: "Ptr", Size: 8 }
    static HGLOBAL := { Type: "HGLOBAL", TypeA: "Ptr", Size: 8 }
    static HHOOK := { Type: "HHOOK", TypeA: "Ptr", Size: 8 }
    static HICON := { Type: "HICON", TypeA: "Ptr", Size: 8 }
    static HINSTANCE := { Type: "HINSTANCE", TypeA: "Ptr", Size: 8 }
    static HKEY := { Type: "HKEY", TypeA: "Ptr", Size: 8 }
    static HKL := { Type: "HKL", TypeA: "Ptr", Size: 8 }
    static HLOCAL := { Type: "HLOCAL", TypeA: "Ptr", Size: 8 }
    static HMENU := { Type: "HMENU", TypeA: "Ptr", Size: 8 }
    static HMETAFILE := { Type: "HMETAFILE", TypeA: "Ptr", Size: 8 }
    static HMODULE := { Type: "HMODULE", TypeA: "Ptr", Size: 8 }
    static HMONITOR := { Type: "HMONITOR", TypeA: "Ptr", Size: 8 }
    static HPALETTE := { Type: "HPALETTE", TypeA: "Ptr", Size: 8 }
    static HPEN := { Type: "HPEN", TypeA: "Ptr", Size: 8 }
    static HRESULT := { Type: "HRESULT", TypeA: "Int", Size: 4 }
    static HRGN := { Type: "HRGN", TypeA: "Ptr", Size: 8 }
    static HRSRC := { Type: "HRSRC", TypeA: "Ptr", Size: 8 }
    static HSZ := { Type: "HSZ", TypeA: "Ptr", Size: 8 }
    static HWINSTA := { Type: "HWINSTA", TypeA: "Ptr", Size: 8 }
    static HWND := { Type: "HWND", TypeA: "Ptr", Size: 8 }
    static INT := { Type: "INT", TypeA: "Int", Size: 4 }
    static INT16 := { Type: "INT16", TypeA: "Short", Size: 2 }
    static INT32 := { Type: "INT32", TypeA: "Int", Size: 4 }
    static INT64 := { Type: "INT64", TypeA: "Int64", Size: 8 }
    static INT8 := { Type: "INT8", TypeA: "Char", Size: 1 }
    static INT_PTR := { Type: "INT_PTR", TypeA: "Ptr", Size: 8 }
    static LANGID := { Type: "LANGID", TypeA: "UShort", Size: 2 }
    static LCID := { Type: "LCID", TypeA: "UInt", Size: 4 }
    static LCTYPE := { Type: "LCTYPE", TypeA: "UInt", Size: 4 }
    static LGRPID := { Type: "LGRPID", TypeA: "UInt", Size: 4 }
    static LONG := { Type: "LONG", TypeA: "Int", Size: 4 }
    static LONG32 := { Type: "LONG32", TypeA: "Int", Size: 4 }
    static LONG64 := { Type: "LONG64", TypeA: "Int64", Size: 8 }
    static LONGLONG := { Type: "LONGLONG", TypeA: "Int64", Size: 8 }
    static LONG_PTR := { Type: "LONG_PTR", TypeA: "Ptr", Size: 8 }
    static LPARAM := { Type: "LPARAM", TypeA: "Ptr", Size: 8 }
    static LPBOOL := { Type: "LPBOOL", TypeA: "Ptr", Size: 8 }
    static LPBYTE := { Type: "LPBYTE", TypeA: "Ptr", Size: 8 }
    static LPCOLORREF := { Type: "LPCOLORREF", TypeA: "Ptr", Size: 8 }
    static LPCSTR := { Type: "LPCSTR", TypeA: "Ptr", Size: 8 }
    static LPCTSTR := { Type: "LPCTSTR", TypeA: "Ptr", Size: 8 }
    static LPCVOID := { Type: "LPCVOID", TypeA: "Ptr", Size: 8 }
    static LPCWSTR := { Type: "LPCWSTR", TypeA: "Ptr", Size: 8 }
    static LPDWORD := { Type: "LPDWORD", TypeA: "Ptr", Size: 8 }
    static LPHANDLE := { Type: "LPHANDLE", TypeA: "Ptr", Size: 8 }
    static LPINT := { Type: "LPINT", TypeA: "Ptr", Size: 8 }
    static LPLONG := { Type: "LPLONG", TypeA: "Ptr", Size: 8 }
    static LPSTR := { Type: "LPSTR", TypeA: "Ptr", Size: 8 }
    static LPTSTR := { Type: "LPTSTR", TypeA: "Ptr", Size: 8 }
    static LPVOID := { Type: "LPVOID", TypeA: "Ptr", Size: 8 }
    static LPWORD := { Type: "LPWORD", TypeA: "Ptr", Size: 8 }
    static LPWSTR := { Type: "LPWSTR", TypeA: "Ptr", Size: 8 }
    static LRESULT := { Type: "LRESULT", TypeA: "Ptr", Size: 8 }
    static PBOOL := { Type: "PBOOL", TypeA: "Ptr", Size: 8 }
    static PBOOLEAN := { Type: "PBOOLEAN", TypeA: "Ptr", Size: 8 }
    static PBYTE := { Type: "PBYTE", TypeA: "Ptr", Size: 8 }
    static PCHAR := { Type: "PCHAR", TypeA: "Ptr", Size: 8 }
    static PCSTR := { Type: "PCSTR", TypeA: "Ptr", Size: 8 }
    static PCTSTR := { Type: "PCTSTR", TypeA: "Ptr", Size: 8 }
    static PCWSTR := { Type: "PCWSTR", TypeA: "Ptr", Size: 8 }
    static PDWORD := { Type: "PDWORD", TypeA: "Ptr", Size: 8 }
    static PDWORD32 := { Type: "PDWORD32", TypeA: "Ptr", Size: 8 }
    static PDWORD64 := { Type: "PDWORD64", TypeA: "Ptr", Size: 8 }
    static PDWORDLONG := { Type: "PDWORDLONG", TypeA: "Ptr", Size: 8 }
    static PDWORD_PTR := { Type: "PDWORD_PTR", TypeA: "Ptr", Size: 8 }
    static PFLOAT := { Type: "PFLOAT", TypeA: "Ptr", Size: 8 }
    static PHALF_PTR := { Type: "PHALF_PTR", TypeA: "Short (32) | Int (64)", Size: 8 }
    static PHANDLE := { Type: "PHANDLE", TypeA: "Ptr", Size: 8 }
    static PHKEY := { Type: "PHKEY", TypeA: "Ptr", Size: 8 }
    static PINT := { Type: "PINT", TypeA: "Ptr", Size: 8 }
    static PINT16 := { Type: "PINT16", TypeA: "Ptr", Size: 8 }
    static PINT32 := { Type: "PINT32", TypeA: "Ptr", Size: 8 }
    static PINT64 := { Type: "PINT64", TypeA: "Ptr", Size: 8 }
    static PINT8 := { Type: "PINT8", TypeA: "Ptr", Size: 8 }
    static PINT_PTR := { Type: "PINT_PTR", TypeA: "Ptr", Size: 8 }
    static PLCID := { Type: "PLCID", TypeA: "Ptr", Size: 8 }
    static PLONG := { Type: "PLONG", TypeA: "Ptr", Size: 8 }
    static PLONG32 := { Type: "PLONG32", TypeA: "Ptr", Size: 8 }
    static PLONG64 := { Type: "PLONG64", TypeA: "Ptr", Size: 8 }
    static PLONGLONG := { Type: "PLONGLONG", TypeA: "Ptr", Size: 8 }
    static PLONG_PTR := { Type: "PLONG_PTR", TypeA: "Ptr", Size: 8 }
    static POINTER_32 := { Type: "POINTER_32", TypeA: "Int", Size: "" }
    static POINTER_64 := { Type: "POINTER_64", TypeA: "Int64", Size: "" }
    static POINTER_SIGNED := { Type: "POINTER_SIGNED", TypeA: "Ptr", Size: "" }
    static POINTER_UNSIGNED := { Type: "POINTER_UNSIGNED", TypeA: "UPtr", Size: "" }
    static PSHORT := { Type: "PSHORT", TypeA: "Ptr", Size: 8 }
    static PSIZE_T := { Type: "PSIZE_T", TypeA: "Ptr", Size: 8 }
    static PSSIZE_T := { Type: "PSSIZE_T", TypeA: "Ptr", Size: 8 }
    static PSTR := { Type: "PSTR", TypeA: "Ptr", Size: 8 }
    static PTBYTE := { Type: "PTBYTE", TypeA: "Ptr", Size: 8 }
    static PTCHAR := { Type: "PTCHAR", TypeA: "Ptr", Size: 8 }
    static PTSTR := { Type: "PTSTR", TypeA: "Ptr", Size: 8 }
    static PUCHAR := { Type: "PUCHAR", TypeA: "Ptr", Size: 8 }
    static PUHALF_PTR := { Type: "PUHALF_PTR", TypeA: "UShort (32) | UInt (64)", Size: 8 }
    static PUINT := { Type: "PUINT", TypeA: "Ptr", Size: 8 }
    static PUINT16 := { Type: "PUINT16", TypeA: "Ptr", Size: 8 }
    static PUINT32 := { Type: "PUINT32", TypeA: "Ptr", Size: 8 }
    static PUINT64 := { Type: "PUINT64", TypeA: "Ptr", Size: 8 }
    static PUINT8 := { Type: "PUINT8", TypeA: "Ptr", Size: 8 }
    static PUINT_PTR := { Type: "PUINT_PTR", TypeA: "UPtr", Size: 8 }
    static PULONG := { Type: "PULONG", TypeA: "Ptr", Size: 8 }
    static PULONG32 := { Type: "PULONG32", TypeA: "Ptr", Size: 8 }
    static PULONG64 := { Type: "PULONG64", TypeA: "Ptr", Size: 8 }
    static PULONGLONG := { Type: "PULONGLONG", TypeA: "Ptr", Size: 8 }
    static PULONG_PTR := { Type: "PULONG_PTR", TypeA: "UPtr", Size: 8 }
    static PUSHORT := { Type: "PUSHORT", TypeA: "Ptr", Size: 8 }
    static PVOID := { Type: "PVOID", TypeA: "Ptr", Size: 8 }
    static PWCHAR := { Type: "PWCHAR", TypeA: "Ptr", Size: 8 }
    static PWORD := { Type: "PWORD", TypeA: "Ptr", Size: 8 }
    static PWSTR := { Type: "PWSTR", TypeA: "Ptr", Size: 8 }
    static QWORD := { Type: "QWORD", TypeA: "Int64", Size: "" }
    static SC_HANDLE := { Type: "SC_HANDLE", TypeA: "Ptr", Size: 8 }
    static SC_LOCK := { Type: "SC_LOCK", TypeA: "Ptr", Size: 8 }
    static SERVICE_STATUS_HANDLE := { Type: "SERVICE_STATUS_HANDLE", TypeA: "Ptr", Size: 8 }
    static SHORT := { Type: "SHORT", TypeA: "Short", Size: 2 }
    static SIZE_T := { Type: "SIZE_T", TypeA: "UPtr", Size: 8 }
    static SSIZE_T := { Type: "SSIZE_T", TypeA: "Ptr", Size: 8 }
    static TBYTE := { Type: "TBYTE", TypeA: "UChar (A) | UShort (U)", Size: 1 }
    static TCHAR := { Type: "TCHAR", TypeA: "Char (A) | UShort (U)", Size: 1 }
    static UCHAR := { Type: "UCHAR", TypeA: "UChar", Size: 1 }
    static UHALF_PTR := { Type: "UHALF_PTR", TypeA: "UShort (32) | UInt (64)", Size: 4 }
    static UINT := { Type: "UINT", TypeA: "UInt", Size: 4 }
    static UINT16 := { Type: "UINT16", TypeA: "UShort", Size: 2 }
    static UINT32 := { Type: "UINT32", TypeA: "UInt", Size: 4 }
    static UINT64 := { Type: "UINT64", TypeA: "Int64", Size: 8 }
    static UINT8 := { Type: "UINT8", TypeA: "UChar", Size: 1 }
    static UINT_PTR := { Type: "UINT_PTR", TypeA: "UPtr", Size: 8 }
    static ULONG := { Type: "ULONG", TypeA: "UInt", Size: 4 }
    static ULONG32 := { Type: "ULONG32", TypeA: "UInt", Size: 4 }
    static ULONG64 := { Type: "ULONG64", TypeA: "Int64", Size: 8 }
    static ULONGLONG := { Type: "ULONGLONG", TypeA: "Int64", Size: 8 }
    static ULONG_PTR := { Type: "ULONG_PTR", TypeA: "UPtr", Size: 8 }
    static USHORT := { Type: "USHORT", TypeA: "UShort", Size: 2 }
    static USN := { Type: "USN", TypeA: "Int64", Size: 8 }
    static VOID := { Type: "VOID", TypeA: "Ptr", Size: 8 }
    static WCHAR := { Type: "WCHAR", TypeA: "UShort", Size: 2 }
    static WORD := { Type: "WORD", TypeA: "UShort", Size: 2 }
    static WPARAM := { Type: "WPARAM", TypeA: "UPtr", Size: 8 }
}
/** 为Windows的结构预定义成员起始位置和长度
 * @description 预定义结构
 */
class Struct {
    static SYSTEMTIME := {
        wYear: { Start: 0, Size: 2, TypeA: "UShort" },
        wMonth: { Start: 2, Size: 2, TypeA: "UShort" },
        wDayOfWeek: { Start: 4, Size: 2, TypeA: "UShort" },
        wDay: { Start: 6, Size: 2, TypeA: "UShort" },
        wHour: { Start: 8, Size: 2, TypeA: "UShort" },
        wMinute: { Start: 10, Size: 2, TypeA: "UShort" },
        wSecond: { Start: 12, Size: 2, TypeA: "UShort" },
        wMilliseconds: { Start: 14, Size: 2, TypeA: "UShort" },
        Size: 16
    }
    static TIME_ZONE_INFORMATION := {
        Bias: { Start: 0, Size: 4, TypeA: "Int" },
        StandardName: { Start: 4, Size: 64, TypeA: "UShort" },
        StandardDate: { Start: 68, Size: 16, TypeA: "Struct" },
        StandardBias: { Start: 84, Size: 4, TypeA: "Int" },
        DaylightName: { Start: 88, Size: 64, TypeA: "UShort" },
        DaylightDate: { Start: 152, Size: 16, TypeA: "Struct" },
        DaylightBias: { Start: 168, Size: 4, TypeA: "Int" },
        Size: 172
    }
}