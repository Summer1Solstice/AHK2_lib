#Requires AutoHotkey v2.0
#Include <XZ\RunWait>
/*哈希算法: MD2 MD4 MD5 SHA1 SHA256 SHA384 SHA512*/
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