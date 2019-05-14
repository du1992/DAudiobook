//
//  AppDelegate.m
//  SIXRichEditor
//
//  Created by  on 2018/7/29.
//  Copyright © 2018年 liujiliu. All rights reserved.
//

#import "AppDelegate.h"
#import "DAllControllersTool.h"
#import "DMenuModel.h"


@interface AppDelegate ()
@property (retain, nonatomic) GDTSplashAd  *splash;
@property (retain, nonatomic) UIView       *bottomView;
@end

@implementation AppDelegate

//应用完成启动
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    DMenuModel*menuModel=[DMenuModel new];
    menuModel.menuType=kHotNovelType;
    [DAllControllersTool createViewControllerWithIndex:menuModel];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [DAllControllersTool shareOpenController].drawerController;
    [self.window makeKeyAndVisible];
    
    [self GDTadvertising];
    
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


/**
 *  开屏广告成功展示
 */
-(void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}
/**
 *  开屏广告展示失败
 */
-(void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error
{
    //动画结束之后直接进入界面
    
    NSLog(@"%s%@",__FUNCTION__,error);
}
/**
 *  应用进入后台时回调
 *  详解: 当点击下载应用时会调用系统程序打开，应用切换到后台
 */
-(void)splashAdApplicationWillEnterBackground:(GDTSplashAd *)splashAd
{
    //动画结束之后直接进入界面
    //    [DAllControllersTool createViewControllerWithIndex:0];
    NSLog(@"%s",__FUNCTION__);
}
/**
 *  开屏广告点击回调
 */
-(void)splashAdClicked:(GDTSplashAd *)splashAd
{
    //动画结束之后直接进入界面
    //    [DAllControllersTool createViewControllerWithIndex:0];
    NSLog(@"%s",__FUNCTION__);
}
/**
 *  开屏广告将要关闭回调
 */
- (void)splashAdWillClosed:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}
/**
 *  开屏广告关闭回调
 */
-(void)splashAdClosed:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
    _splash = nil;
    //    [DAllControllersTool createViewControllerWithIndex:0];
}
/**
 *  开屏广告点击以后即将弹出全屏广告页
 */
-(void)splashAdWillPresentFullScreenModal:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}
/**
 * 开屏广告剩余时间回调
 */
-(void)splashAdDidDismissFullScreenModal:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}
@end
