# 小熊有声书

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![GitHub last commit](https://img.shields.io/github/last-commit/kevindcw/DAudiobook.svg)](https://github.com/kevindcw/DAudiobook/commits/master)
[![GitHub repo size in bytes](https://img.shields.io/github/repo-size/kevindcw/DAudiobook.svg?colorB=fa5b19)](https://github.com/kevindcw/DAudiobook)



## 效果图：
目前主要是有菜单页面，音乐播放，视频播放，文字段子，论坛讨论和图片美图这几个大的板块：

<p align="center">
  <img width="200" src="Screenshots/1.png" hspace="30px" />
  <img width="200" src="Screenshots/2.png" hspace="30px" />
  <img width="200" src="Screenshots/3.png" hspace="30px" />
</p>

<p align="center">
  <img width="200" src="Screenshots/4.png" hspace="30px" />
  <img width="200" src="Screenshots/5.png" hspace="30px" />
  <img width="200" src="Screenshots/6.png" hspace="30px" />
</p>

## 用到的第三方SDK：
Bmob后端云       （主要用于，用户的登录注册和论坛的发布）
Bmob推送         （用于推送信息到手机）
Bugly腾讯         (腾讯bug收集， 用于收集和分析应用的卡顿和崩溃，以及用户的留存)
友盟              (用于第三方登录和分享，如QQ，微信等)
腾讯广告           (应用内加广告，增加个人开发者收入)


## 代码结构：
好多方法的实现，都是放在根视图里了
![](https://upload-images.jianshu.io/upload_images/3323633-e0768bf22ed2d983.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

#### 1.应用内加广告
虽然在App中加入广告来盈利是比较低级的商业化方式，但对于个人开发者或者小团队开发者来说也是个不错的选择，
基本上应用的广告收入都是按展示和点击计算的，各种广告联盟都有自己的SDK，直接引用就行了。
如果用户有好多是国外的，可以使用[谷歌GoogleAdMob](https://apps.admob.com/),但是访问得要梯子，而且是用美金结算的，只有超过100刀才会给你。
如果只是国内的话可以用[腾讯广告](https://e.qq.com/ads/400/?from=02_PINZHUANpcssBbt),结算属于比较快的，一月一结没有金额限制。
腾讯广告后台详情，基本上是没有怎么理会过
![腾讯广告后台](https://upload-images.jianshu.io/upload_images/3323633-37a80a65c00e1858.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

广告形式主要有：
开屏广告，原生广告，横幅广告，插页广告，视频广告；
开屏广告和原生广告用户体验好，大厂用的比较多，其它的用户体验都比较差

![横幅广告](https://upload-images.jianshu.io/upload_images/3323633-bd6c4e06b6ea8856.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

![插页广告](https://upload-images.jianshu.io/upload_images/3323633-eb69d0b81d2e24f4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

## 2 数据接口：
因为好多数据都是在网上抓的，怕失效都存在本地了，在LocalData文件夹下。
因为没有服务器（当然会搭服务器的小哥可以跳过），网上有好多免费的API数据接口，大家可以找一下看看有没有需要的。
当然也可以使用各种的云服务，最稳定的应该属于[腾讯云](https://cloud.tencent.com/)和[阿里云](https://www.aliyun.com/)了，但是比较贵。

免费的也有，像是[bmob后端云](http://www.bmob.cn/)或者是[LeanCloud](https://leancloud.cn/)（不过免费版有很多限制）

我现在用的[bmob后端云](http://www.bmob.cn/)，控制台效果：
![后端云控制台](https://upload-images.jianshu.io/upload_images/3323633-43e7efc5993eede3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)
具体实现代码奉上
```
       //注册key
        [Bmob registerWithAppKey:BmobAppkey];
 //登录
            [BmobUser loginWithUsernameInBackground:@"用户名" password:@"登录密码"  block:^(BmobUser *user, NSError *error) {
         if (user) {
                   登录成功
                    
                } else {
                   登录失败
                  
                }
            }];

```
```
         BmobUser *bUser = [[BmobUser alloc] init];
            bUser.username=views.username.textField.text;//名字
            bUser.password=views.password.textField.text;//密码
            [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
               @"注册成功"
                } else {
                @"注册失败"
                }
            }];

```
具体数据的增删改查，看文档吧这里就不细讲了

实在不行的话可以使用抓包工具来寻找自己需要的数据，[工具下载奉上](https://pan.baidu.com/s/1pL97kKV)

## 第三步 用户第三方登录分享：
用户第三方登录分享(不需要的可以跳过去)
 [新浪开发平台地址](http://open.weibo.com/index.php)
[腾讯开放平台地址](http://open.qq.com/)
[微信开发平台地址](https://open.weixin.qq.com/cgi-bin/applist?t=manage/list&lang=zh_CN&token=5746e9ad32edacb33fed1070fdd0623ca2fbd6d4)
注册提交资料就行，注意微信提交审核的官网要正规点，不然审核不过，随便搭个好看点的静态页面吧。
SDK可以单独集成，也可以使用第三方，推荐使用[友盟](http://www.umeng.com/)，使用简单点而且加入友盟统计的时候方便点
![依赖库.png](http://upload-images.jianshu.io/upload_images/3323633-9864aeae164b78b5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

## 第四步 应用统计：
集成友盟统计（不需要的可以跳过）
集成友盟统计可以分析流量来源、内容使用、用户属性和行为数据，可以知道用户干了什么

```
    //初始化SDK
   //设置友盟Appkey
    [UMSocialData setAppKey:UmengAppkey];
    //使用友盟统计
    UMConfigInstance.appKey = UmengAppkey;
    UMConfigInstance.channelId = @"App Store";//来源
    [MobClick startWithConfigure:UMConfigInstance];

```
设置用户的属性，这样用户做的事件就可以携带着这些属性，传的样式是字典
```
//设置超级属性
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:user.idString, @"uid",user.nickName,@"name",user.gender, @"sex", nil];
    [DplusMobClick registerSuperProperty:dic];
    
```
统计页面
```
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"首页"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"首页"];
}

```
自定义事件,数量统计，比如可以统计充值按钮被点击的多少下
```
 @param  eventId 网站上注册的事件Id.
 @param  label 分类标签。不同的标签会分别进行统计，方便同一事件的不同标签的对比,为nil或空字符串时后台会生成和eventId同名的标签.
 @param  accumulation 累加值。为减少网络交互，可以自行对某一事件ID的某一分类标签进行累加，再传入次数作为参数。
[MobClick event:@"kaola_props"];//传定义的ID

```
## 第五步：bug收集
用过的感觉腾讯bugly界面好看点，友盟方便点直接友盟统计就可以收集到。其实也没啥好说的，腾讯bugly也可以统计，友盟统计也可以收集bug，感觉都差不多。
![腾讯bugly.png](http://upload-images.jianshu.io/upload_images/3323633-65ce6e61bc8d899a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

## 第六步：消息推送
现状推送的第三方SDK很多，像友盟推送，极光推送，信鸽消息推送等等，个人感觉极光推送是最快的（也有可能是自己的错觉，个人看法）
####1.创建推送证书
![创建推送证书1.png](http://upload-images.jianshu.io/upload_images/3323633-ad51b2926ae02b58.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

![创建推送证书2.png](http://upload-images.jianshu.io/upload_images/3323633-c5045cf6048ba19e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

####2.导入SDK将SDK包解压
在Xcode中选择“Add files to 'Your project name'...”，将解压后的lib子文件夹（包含JPUSHService.h、jpush-ios-x.x.x.a，jcore-ios-x.x.x.a）添加到你的工程目录中。

 ####3.使用
极光推送可以设置标签和别名达到个性化单独推送的效果，比如单独推送某人，或者按地区推送。 具体实现自己看[极光开发者文档吧](https://docs.jiguang.cn/jpush/client/iOS/ios_api/)太多了，不细写了，

####4.点击推送控制跳转的页面
在networkDidReceiveMessage函数里处理得到的参数，
来确定跳转的页面
注意设置角标，不过好像第一次点进角标不会消失，再点才会，好像简书的也是这样（不知道是不是错觉）
```
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (userInfos==nil) {
        userInfos =userInfo ;
//        通知方法回调：接受自定义消息 
        [self networkDidReceiveMessage:userInfos];
    }
    
    [JPUSHService handleRemoteNotification:userInfo];
    [JPUSHService setBadge:0];// 设置角标(到服务器)
   
    
}


```
