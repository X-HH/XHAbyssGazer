# XHAbyssGazer

### 逆向过程

1. AppStore下载正版应用进行砸壳；
2. 使用工具（如MonkeyDev）进行重签名；
3. 使用静态分析工具Hopper或者IDA进行汇编，伪代码静态分析，使用Reveal，Lookin（笔者推荐，非常好用）进行UI层分析。
4. 动态调试（LLDB，Xcode等），找到关键的函数，控件进行破解；
5. Xcode结合MonkeyDev进行关键类，关键方法hook，执行自定义内容。


### 保证iOS应用安全的解决方案
本demo提供了应用安全防护的一套方案，包括如何进行主动探测，如何监听异常。

常用的安全保护措施有如下几种：


* 越狱设备检测

* 证书有效性验证
> 1. 防Charles等抓包工具

* 数据加密
> 1. 本地数据加密
> 2. 网络请求数据加密
> 3. 字符串加密
    
* 动态保护，防止动态调试、反注入
> 1. 反调试
> 2. 防止hook
> 3. 完整性校验，BundleID校验

本demo目前做了证书有效性验证，反调试，反注入的功能，后续继续添加防hook，完整性校验等内容，具体的方案业界也已经有对应的方案。本demo旨在提供一套安全防护的操作方案。

### 项目介绍
* XHAbyssGazerTaskEngine：任务执行引擎，常驻线程定时任务，执行定义的任务
> 1. 开启常驻线程
> 2. 开启定时器
> 3. 定时任务，创建tasks，执行tasks

* XHAbyssGazerHooker：hook网络请求，监听证书内容，按照白名单校验证书的正确性。用户需要选择合适的策略，进行数据上报或者激进的退出程序（不建议）。

* XHAbyssGazerSecurityTask：证书校验

* XHAbyssGazerAgainstDebugTask：反调试
> 1. ptrace
> 2. sysctl

* XHAbyssGazerAgainstInjectTask：反注入
> _dyld_image_count,_dyld_get_image_name

* XHAbyssGazerAgainstHookTask：反hook后续实现
