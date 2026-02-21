#Requires AutoHotkey v2.0
#Include RunCmd.ahk
/**
 * 计算文件的哈希值
 * 使用系统CertUtil命令行工具计算指定文件的哈希值
 * 
 * @param file 要计算哈希值的文件路径
 * @param HashAlgorithm 哈希算法类型，支持MD2 MD4 MD5 SHA1 SHA256 SHA384 SHA512
 * @returns {String} 返回指定文件的哈希值字符串
 */
GetFileHash(file, HashAlgorithm) {
    command := Format('CertUtil -hashfile "{1}" {2}', file, HashAlgorithm)
    list := StrSplit(RunWaitOne(command), "`r`n")
    return list[2]
}
md2sum := GetFileHash.Bind(,"MD2")
md4sum := GetFileHash.Bind(,"MD4")
md5sum := GetFileHash.Bind(,"MD5")
sha1sum := GetFileHash.Bind(,"SHA1")
sha256sum := GetFileHash.Bind(,"SHA256")
sha384sum := GetFileHash.Bind(,"SHA384")
sha512sum := GetFileHash.Bind(,"SHA512")