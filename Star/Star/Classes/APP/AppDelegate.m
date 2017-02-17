//
//  AppDelegate.m
//  Star
//
//  Created by JUNE_EN on 15/5/25.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "AppDelegate.h"
#import "SDWebImageManager.h"
#import "DIntroductionViewController.h"
#import "AFNetMonitor.h"
#import "UMMobClick/MobClick.h"
#import "Macro.h"
#import "Business.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif
//以下几个库仅作为调试引用引用的
#import <AdSupport/AdSupport.h>
#import <CommonCrypto/CommonDigest.h>
#import "DAllControllersTool.h"
#import "DHomeViewController.h"
#import "DNavigationController.h"
#import "DLaunchingViewController.h"
#import <UMSocialCore/UMSocialCore.h>
@interface AppDelegate ()
@property (nonatomic, strong) DIntroductionViewController *introductionView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    DLaunchingViewController *launchingVC = [[DLaunchingViewController alloc] init];
   
    self.window.rootViewController=launchingVC;
    [self.window makeKeyAndVisible];
    
     
    //审核判断
    [self  auditJudgment];
    //网络判断
    [AFNetMonitor sharedClient];
    //使用友盟统计
    [self initYouMeng:launchOptions];
    //注册极光推送
    [self JPushSDK:launchOptions];
    
    
    return YES;
}
-(void)auditJudgment{
    
    [[Business sharedInstance] getTime:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
    } fail:^(NSString *error) {
        
    }];
    
}


-(void)initYouMeng:(NSDictionary *)launchOptions{
    UMConfigInstance.appKey = UmengAppkey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    //设置 AppKey 及 LaunchOptions
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppkey appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //设置分享到QQ互联的appKey和appSecret
    // U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppkey  appSecret:QQAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:WBAppkey  appSecret:WBAppSecret redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

-(void)JPushSDK:(NSDictionary *)launchOptions{
    
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    // 程序未运行时，接收消息启动app
    
    NSDictionary * userInfos = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    [JPUSHService setBadge:0];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //     * @param isProduction 是否生产环境. 如果为开发状态,设置为 NO; 如果为生产状态,应改为 YES.
    [JPUSHService setupWithOption:launchOptions appKey:JPAppkey
                          channel:@"Publish channel"
                 apsForProduction:YES
            advertisingIdentifier:advertisingId];
    [JPUSHService setDebugMode];
    //接受自定义消息
    
    [JPUSHService setTags:nil alias:@"明星资讯" callbackSelector:nil object:@"明星资讯"];
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:-1];   //清除角标
    [application cancelAllLocalNotifications];
    
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required - 注册极光 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}





- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    // 停止下载所有图片
//    [[SDWebImageManager sharedManager] cancelAll];
//    // 清除内存中的图片
//    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.beijing.lanou.Star" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Star" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Star.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
