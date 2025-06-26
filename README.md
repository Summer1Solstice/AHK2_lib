# AHK2_lib

# 包含脚本
### Date.ahk
此脚本定义了 `Date` 类，封装了 UTC 历元、UTC 时间戳（秒和毫秒）、时区偏移量以及本地日期时间等日期时间相关属性，方便进行日期时间操作。TODO

### DebugOutput.ahk
为原始值添加`Debug`方法，``OutputDebug(this "`n")``

### FormatLog.ahk
生成包含时间、日志级别、脚本名、函数名和说明的格式化日志文本的 AutoHotkey 函数。

### IniParser.ahk
提供 `Parse` 和 `Stringify` 静态方法，用于解析 INI 字符串为 `Map` 对象，以及将 `Map` 对象转换为 INI 字符串。

### join.ahk
将数组元素连接为一个字符串，元素之间使用指定的分隔符。

### organize .ahk
将当前目录下的所有.ahk文件按照文件名排序，并生成一个新的README.md文件，包含每个脚本的标题和说明。

### Predefined.ahk
为Windows的C++数据类型预定义字节长度。TODO

### RegExGlobalMatch.ahk
提供对字符串进行全局正则匹配的功能，返回包含所有匹配项（RegExMatchInfo 对象）的数组。

### Repeat.ahk
重复指定文本指定次数，并返回最终结果字符串。

### RunHidden.ahk
运行指定的命令并隐藏窗口，借助 `WScript.Shell` 实现。

### RunWait.ahk
提供执行单条或多条命令并返回输出的 AutoHotkey 函数，基于 `WScript.Shell` 实现。

### (String|Array|Map)Plus.ahk
`#Include`其他(库|脚本)的聚合文件。
被引入的文件通常自带对原生(对象|原始值)扩展的`DefineProp`语句。

### 如何扩展Array和String.ahk
展示了为 `Array` 和 `String` 原型添加属性和方法的多种方式，方便对原生对象进行功能扩展。

### 数字转汉字.ahk
阿拉伯数字转中文大/小写汉字。

### 星星评级.ahk
输入整数，输出表示星级的字符串。

### 正则搜索并替换.ahk
对字符串进行批量正则搜索并替换的 AutoHotkey 函数。

