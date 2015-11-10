# cordova-umeng-upate

Cordova友盟动更新插件

# 功能

友盟自动更新插件，详见官方文档。统计分析请见友盟[分析插件](http://github.com/pipitang/cordova-umeng-analytics)

# 安装

1. 运行 ```cordova plugin add https://github.com/pipitang/cordova-umeng-update``` 

2. cordova各种衍生命令行都应该支持，例如phonegap或者ionic。

# 使用方法

## 原则


## API

### 自动更新API

注意：由于苹果商店的限制，友盟不能提供自动更新，所以，以下API无特殊说明，都指的是Android平台。

#### 配置API

请务必在cordova ready中调用配置接口。
这里需要注意的是，

```Javascript
Umeng.Update.config({
    appkey: 'your_app_key', 
    channel: 'your_channel'
}, function () {
    alert("友盟API初始化成功");
}, function (reason) {
    alert("友盟API初始化失败");
});
```

第一个参数为配置对象，appkey和channel必须传入，iOS和Android平台都适用。其它参数只有Android平台可以使用，:updateOnlyWifi,deltaUpdate,updateAutoPopup,richNotification,updateCheckConfig和updateUIStyle，具体参见[友盟自动更新API](http://dev.umeng.com/auto-update/android-doc/customization#1_1). updateUIStyle的值为0或者1，对应STYLE_DIALOG和STYLE_NOTIFICATION。

#### 自动更新[参见](http://dev.umeng.com/auto-update/android-doc/quick-start#1_4)

```Javascript
Umeng.Update.update(function () {
    alert("Success");
}, function (reason) {
    alert("Failed: " + reason);
});
```

#### 手动更新[参见](http://dev.umeng.com/auto-update/android-doc/manually-or-automatically-update#1_2)

```Javascript
Umeng.Update.forceUpdate(function () {
    alert("Success");
}, function (reason) {
    alert("Failed: " + reason);
});
```

#### 静默下载更新[参见](http://dev.umeng.com/auto-update/android-doc/manually-or-automatically-update#1_3)

```Javascript
Umeng.Update.silentUpdate(function () {
    alert("Success");
}, function (reason) {
    alert("Failed: " + reason);
});
```

#### 检查更新(iOS)

```Javascript
Umeng.Update.checkUpdate(storeAppId,{
    title: "亲，版本有自动更新，现在下载吗?",
    ok: "更新",
    cancel: "取消"
},function () {
    alert("Success");
}, function (reason) {
    alert("Failed: " + reason);
});
```

改方法会弹出对话框，提示用户是否下载新版本。注意，改方法只有iOS适用，并且storeAppId为苹果商店的数字串。

# FAQ

Q: Android如何调试？

A: 如果怀疑插件有BUG，请使用tag名称为cordova-umeng-xxxx，xxxx为友盟对应模块的小写名称，例如analytics或者update。

Q: Windows 版本？

A: 这个很抱歉，有个哥们买了Lumia之后一直在抱怨应用太少 ：） 欢迎 pull request.


# TODO

1. 动态拉取依赖库

# 许可证

[MIT LICENSE](http://opensource.org/licenses/MIT)
