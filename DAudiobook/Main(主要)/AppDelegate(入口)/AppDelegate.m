//
//  AppDelegate.m
//  SIXRichEditor
//
//  Created by  on 2018/7/29.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import <BmobSDK/Bmob.h>
#import <UMSocialCore/UMSocialCore.h>
#import <Bugly/Bugly.h>
#import "AppDelegate.h"
#import "DAllControllersTool.h"
#import "DMenuModel.h"


@interface AppDelegate ()
@property (retain, nonatomic) GDTSplashAd  *splash;
@property (retain, nonatomic) UIView       *bottomView;
@end

@implementation AppDelegate
//应用将要完成启动
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions{
 
    //云服务器SDK
    [Bmob registerWithAppKey:BmobAppkey];
    //腾讯bug收集
    [Bugly startWithAppId:BuglyAppID];
    
    //第三方分享
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppkey appSecret:WXAppSecret redirectURL:@""];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppkey  appSecret:QQAppSecret redirectURL:@""];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:WBAppkey  appSecret:WBAppSecret redirectURL:@""];
    
    
    [self GDTadvertising];
    return YES;
}
//应用完成启动
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    DMenuModel*menuModel=[DMenuModel new];
    menuModel.menuType=kHotNovelType;
    [DAllControllersTool createViewControllerWithIndex:menuModel];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [DAllControllersTool shareOpenController].drawerController;
    [self.window makeKeyAndVisible];
    
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    
    BmobUser *bUser = [BmobUser currentUser];
    if (!bUser) {
        //对象为空时，可打开用户注册界面
         [DInterfaceUrl userPopupWindow];
        
    }
    
    return YES;
}
// 当应用界面回到活跃Activate状态时
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [GDTTrack activateApp];
    
    NSLog(@"%s", __func__);
}
//广点通广告
-(void)GDTadvertising{
   //开屏广告初始化并展示代码
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        GDTSplashAd *splashAd = [[GDTSplashAd alloc] initWithAppkey:GDTAppkey placementId:GDTPlacementIdK];
        splashAd.delegate = self;//设置代理1ez        //针对不同设备尺寸设置不同的默认图片，拉取广告等待时间会展示该默认图片。
        if ([[UIScreen mainScreen] bounds].size.height >= 568.0f) {
            splashAd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage-568h"]];
        } else {
            splashAd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage"]];
        }
        //设置开屏拉取时长限制，若超时则不再展示广告
        splashAd.fetchDelay = 3;
        //［可选］拉取并展示全屏开屏广告
        //[splashAd loadAdAndShowInWindow:self.window];
        //设置开屏底部自定义LogoView，展示半屏开屏广告
        _bottomView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100)];
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SplashBottomLogo"]];
        [_bottomView addSubview:logo];
        logo.center = _bottomView.center;
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        [splashAd loadAdAndShowInWindow:self.window withBottomView:_bottomView];
        self.splash = splashAd;
        
        
    }
    
    
}

#pragma mark - 接收远程事件
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPause://暂停
            {
                [[DPlayerManager defaultManager] playAndPause];
               
                break;
            }case UIEventSubtypeRemoteControlPlay://播放
            {
                [[DPlayerManager defaultManager] playAndPause];
              
                break;
            }case UIEventSubtypeRemoteControlPreviousTrack://前一首
            {
                [[DPlayerManager defaultManager] playPrevious];
                
                break;
            }case UIEventSubtypeRemoteControlNextTrack://下一首
            {
                [[DPlayerManager defaultManager] playNext];
               
                break;
            }
            default:
                break;
        }
    }
}



@end
