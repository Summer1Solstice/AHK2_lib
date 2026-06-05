# AHK2_lib
大部分脚本在单独运行时，会运行用于测试或演示的代码。
其格式如下：
```AutoHotkey
;@Ahk2Exe-IgnoreBegin   ; 编译器指令，忽略以下代码
;如果脚本是从外部文件加载的, 这等同于 A_ScriptFullPath, 除非该行属于脚本的 #Include 文件之一.
if A_LineFile = A_ScriptFullPath {
   ; 测试代码
}
;@Ahk2Exe-IgnoreEnd     ; 编译器指令，忽略代码结束
```
# 包含脚本`n### ArgsParse.ahk
`A_Args` 命令行参数解析，如何使用？请看文件末尾的示例。

### (String|Array|Map)Plus.ahk
`#Include`其他(库|脚本)的聚合文件。
被引入的文件通常自带对原生(对象|原始值)扩展的`DefineProp`语句。

### AutoClicker.ahk
自动连点/按住器

### Bool.ahk
原始值基于AutoHotkey的原生`if`判断返回布尔值，
`Array`, `Map`, `Object`，基于元素数量和属性数量`if`判断返回布尔值。

### Brainfuck.ahk
`Brainfuck`语言的解释器，无视`+-,.<>[]`之外的字符。兼容`UTF-8`编码字符输出。

### CommandLineToArgvW.ahk
命令行参数文本转数组，基于`Shell32\CommandLineToArgvW`。

### ConnectWifi.ahk
连接指定名称的 Wi-Fi 网络。

### ConvertBase.ahk
基于`msvcrt.dll`的进制转换，包含一个`ConvertBase`函数，可进行 2-32 进制转换，
以及`hex`、`bin`、`oct`、`int`四个包装函数。
`IntToBin`、`BinToInt`、`IntToHex`、`HexToInt`，四个AHK原生实现。
`IntTo_`函数通过计算转换 2-62 进制，不遵循常见的进制规范。

### ConvertUtils.ahk
单位换算工具类，包含数值、单位分离方法，乘法除法方法，浮点数格式化方法。
具体如何换算，请自行定义代码逻辑。

### CustomVars.ahk
自定义变量，命名格式仿照AHK内置变量，但是使用`C_`前缀。

### Date.ahk
`FmtTUT`工具类，~~对内置函数`FormatTime`的包装~~。
`Date`、`Time`、`DateTime`、`TimeStamp`，提供日期、时间、日期时间、时间戳相关的派生类。

### FormatLog.ahk
生成包含日期时间、日志等级、函数名和说明的格式化日志文本

### Full2Half.ahk
全角字符、半角字符互转

### GetFileHash.ahk
获取文件hash值

### HowRun.ahk
通过标准输出、`A_DebuggerName`、`A_Args`、控制台附加等方式判断脚本如何运行。

### iniUtils.ahk
类`iniUtils`，包含两个方法`ToObject`将ini转为类中的对象；`ToString` 将对象转为ini格式字符串。

### join.ahk
将数组元素连接为一个字符串，元素之间使用指定的分隔符。

### Len.ahk
返回变量的长度，支持 Object、Array、Map、RegExMatchInfo 和 Primitive 类型

### MergeBuffer.ahk
合并两个缓冲对象为一个新缓冲对象

### NormalizePath.ahk
标准化文件路径

### organize.ahk
脚本概述自动生成脚本

### Predefined.ahk
弃用！
为Windows的C++数据类型预定义字节长度。

### Prime.ahk
`Prime.EulerSieve`求小于n的质数，`Prime.is`判断一个数是否为质数。

### Print.ahk
基于`OutputDebug`将变量字符串化输出到调试控制台。
还包含一个`stringify`函数，用于字符串化变量，不遵守`JSON`规范，
而是尽可能还原能在AHK中直接定义相同变量的文本。

### Radians_Degrees.ahk
角度转弧度、弧度转角度

### Range.ahk
Python range()的AutoHotkey实现;
range()，Python风格，起始值从0开始、左闭右开的特性。
rangeA()，起始值从1开始，闭区间。

### RegExGlobalMatch.ahk
提供对字符串进行全局正则匹配的功能，返回包含所有匹配项（RegExMatchInfo 对象）的数组。

### Repeat.ahk
重复指定文本指定次数，并返回最终结果字符串。

### RunCmd.ahk
提供执行单条或多条命令并返回输出的 AutoHotkey 函数，基于 `WScript.Shell` 实现。
需要手动调用`HideConsoleWindow`来隐藏控制台窗口

### SetSSHTerminal.ahk
修改ssh终端为pwsh或bash

### TextReplaceUtils.ahk
进行多次文本替换的包装函数

### TimedTask.ahk
定时任务，通过派生类创建实例。
简陋，无优化改进计划。

### Timeit.ahk
高精度的计时模块，传入一个函数，输出单次运行的平均耗时。
如果函数需要传入参数,请使用
```AutoHotkey
fn := foo.Bind("args")  ; 函数
fn1() => classobj.foo("arg")    ; 类实例方法
```

### 数字转汉字.ahk
阿拉伯数字转中文大/小写汉字。

### 星星评级.ahk
输入整数，输出表示星级的字符串。

