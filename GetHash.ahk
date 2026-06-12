/************************************************************************
 * @description 通过`BCrypt.dll`计算数据哈希值
 * @author Summer1Solstice
 * @date 2026/06/12
 * @version 0.1.0
 ***********************************************************************/

#Requires AutoHotkey v2.0

/**
 * 计算数据哈希值
 * 使用 BCrypt.dll 计算哈希值；
 * 当重复调用 DLL 时, 通过预先加载此 DLL 文件可以显著改善执行效率.
 * @param input 要计算hash的数据，字符串或缓冲对象。
 * @param HashAlgorithm 哈希算法类型，支持MD2 MD4 MD5 SHA1 SHA256 SHA384 SHA512
 * @returns {String} 返回全小写的哈希值字符串
 */
GetHash(input, HashAlgorithm) {
    if input is Primitive {
        buf := Buffer(StrPut(input, "UTF-8") - 1)
        StrPut(input, buf, "UTF-8")
    } else if input is Buffer {
        buf := input
    } else {
        throw "输入必须是字符串或Buffer对象"
    }
    HashAlgorithm := StrUpper(HashAlgorithm)
    switch HashAlgorithm {
        case "MD2": hashLength := 16
        case "MD4": hashLength := 16
        case "MD5": hashLength := 16
        case "SHA1": hashLength := 20
        case "SHA256": hashLength := 32
        case "SHA384": hashLength := 48
        case "SHA512": hashLength := 64
        default: throw "不支持的Hash算法"
    }
    phAlgorithm := { Ptr: 0, __delete: (this) => (DllCall("bcrypt\BCryptCloseAlgorithmProvider", "ptr", this, "int", 0)) }
    if code := DllCall("bcrypt\BCryptOpenAlgorithmProvider", "ptr*", phAlgorithm, "str", HashAlgorithm, "str", "", "int", 0) {
        throw "获取Hash算法句柄失败; " code
    }
    ; if code := DllCall("bcrypt\BCryptGetProperty",
    ;     "ptr", phAlgorithm,
    ;     "str", "HashDigestLength",
    ;     "ptr*", &hashLength := 0,
    ;     "int", 4,
    ;     "ptr*", &resultSize := 0,
    ;     "int", 0)
    ; {
    ;     throw "获取Hash值长度失败; " code
    ; }
    ResultBuf := Buffer(hashLength)
    if DllCall("bcrypt\BCryptHash",
        "ptr", phAlgorithm,
        "ptr", 0,
        "int", 0,
        "ptr", buf.Ptr,
        "int", buf.Size,
        "ptr", ResultBuf.Ptr,
        "int", hashLength)
    {
        throw "计算Hash失败"
    }
    result := ""
    loop hashLength {
        result .= Format("{1:02x}", NumGet(ResultBuf, A_Index - 1, "Uchar"))
    }
    return result
}

md2sum := GetHash.Bind(, "MD2")
md4sum := GetHash.Bind(, "MD4")
md5sum := GetHash.Bind(, "MD5")
sha1sum := GetHash.Bind(, "SHA1")
sha256sum := GetHash.Bind(, "SHA256")
sha384sum := GetHash.Bind(, "SHA384")
sha512sum := GetHash.Bind(, "SHA512")

;@Ahk2Exe-IgnoreBegin
if A_LineFile = A_ScriptFullPath {
    dict := Map(
        "md2", "d9cce882ee690a5c1ce70beff3a78c77",
        "md4", "aa010fbc1d14c795d86ef98c95479d17",
        "md5", "5eb63bbbe01eeed093cb22bb8f5acdc3",
        "sha1", "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed",
        "sha256", "b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9",
        "sha384", "fdbd8e75a67f29f701a4e040385e2e23986303ea10239211af907fcbb83578b3e417cb71ce646efd0819dd8c088de1bd",
        "sha512", "309ecc489c12d6eb4cc40f50c902f2b4d0ed77ee511a7c7a9bcd3ca86d4cd86f989dd35bc5ff499670da34255b45b0cfd830e81f605dcf7dc5542e93ae9cd76f"
    )
    for k, v in dict {
        if h1 := GetHash("hello world", k) = v {
            OutputDebug "测试通过: " k "`n"
        } else {
            OutputDebug "测试失败: " k "`n"
            OutputDebug h1 "`n"
        }
    }
}
;@Ahk2Exe-IgnoreEnd
