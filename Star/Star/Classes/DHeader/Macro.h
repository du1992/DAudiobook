//
//  Macro.h
//  live
//
//  Created by kenneth on 15-7-9.
//  Copyright (c) 2015年 kenneth. All rights reserved.
//

#import "MBProgressHUD.h"
#import "UIView+MBProgressHUD.h"
#import "JPUSHService.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "MJExtension.h"

/*
 ====================================================================================================//尺寸
 */
//获取屏幕 宽度、高度
#define WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kNavigationHeight  self.navigationController.navigationBar.frame.size.height
//平模相对于6的比例
#define SCREEN_SCALE  SCREEN_WIDTH/375.0
#define SCALE ([UIScreen mainScreen].scale)
//状态栏、导航栏、标签栏高度
#define STATUS_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)
#define NAVIGATIONBAR_HEIGHT (self.navigationController.navigationBar.frame.size.height)
#define TABBAR_HEIGHT (self.tabBarController.tabBar.frame.size.height)
#define kMargin 10.0
#define kTitleFont 14.0
#define kDateFont 12.0
#define kDefaultImgH 300.0

/*
 ====================================================================================================//字体大小
 */

#define kFount(a)       [UIFont systemFontOfSize:a]
#define kFountBig       [UIFont systemFontOfSize:16]
#define kFountNormal    [UIFont systemFontOfSize:14]
#define kFountTen       [UIFont systemFontOfSize:10]
#define kFountNormalSmall    [UIFont systemFontOfSize:13]
#define kFountEighteen       [UIFont systemFontOfSize:18]
#define kFountSmall  [UIFont systemFontOfSize:12]

/*
 ====================================================================================================//颜色相关3
 */
#define RGB_COLOR(R,G,B)     [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1]
#define RGBA_COLOR(R,G,B,A)  [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
#define RGB(R,G,B)       [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1]
#define RGBA(R,G,B,A)  [UIColor colorWithRed:(R) green:(G) blue:(B) alpha:(A)]
#define COLOR_RGBA(R,G,B,A)  [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
/** 16进制颜色值，如：#000000 , 注意：在使用的时候hexValue写成：0x000000 */
#define HexColor(hexValue)  [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:1.0]
//字体颜色
#define COLOR_FONT_RED   0xD54A45
#define COLOR_FONT_WHITE 0xFFFFFF
#define COLOR_FONT_LIGHTWHITE 0xEEEEEE
#define COLOR_FONT_DARKGRAY  0x555555
#define COLOR_FONT_GRAY  0x777777
#define COLOR_FONT_LIGHTGRAY  0x999999
#define COLOR_FONT_BLACK 0x000000

// 视图背景颜色
#define navigationBarColor RGBA(52,152, 219,0.5)
#define kLineBackGroundGrayColor RGB(230,230,230)
#define kblueColor          RGB(0,168,255)
#define korangeColor        RGB(251,140,38)
#define kYellowColor        RGB(255,226,2)
#define kBlackColor80       RGB(80,40,24)
#define kBlackColor29       RGB(29,29,38)
#define kBlackColor91       RGB(91,91,91)
#define kGrayColor105       RGB(105,105,105)
#define kGrayColor186       RGB(186,186,186)
#define kGrayColor174       RGB(174,174,175)
#define kGrayColor105       RGB(105,105,105)
#define kHomePageBlackColor               [UIColor colorWithHex:@"#f8f8f8"];
//背景颜色
#define COLOR_BG_GRAY      0xEDEDED
#define COLOR_BG_ALPHABLACK     0x88000000
#define COLOR_BG_ORANGE 0xf69e21
#define COLOR_BG_ALPHARED  0x88D54A45
#define COLOR_BG_LIGHTGRAY 0xEEEEEE
#define COLOR_BG_ALPHAWHITE 0x55FFFFFF
#define COLOR_BG_WHITE     0xFFFFFF
#define COLOR_BG_DARKGRAY     0xAFAEAE
#define COLOR_BG_RED       0xD54A45
#define COLOR_BG_BLUE      0x4586DA
#define COLOR_BG_CLEAR     0x00000000

//rbg转UIColor(16进制)
#define RGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA16(rgbaValue) [UIColor colorWithRed:((float)((rgbaValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbaValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbaValue & 0xFF))/255.0 alpha:((float)((rgbaValue & 0xFF000000) >> 24))/255.0]

#define Padding 13
#define Placholder [UIImage imageNamed:@"2012"]

/*
 ====================================================================================================//个人资料
 */


//友盟
#define UmengAppkey @"584503b645297d6e0e0004c6"
#define WXAppkey    @"wx53ed0e60138aa498"
#define QQAppkey    @"1105893514"
#define WBAppkey    @"3733899087"
#define WXAppSecret @"f86c46b2a02872e740bba901f3ef3a92"
#define QQAppSecret @"OnXqfRncSSAEmnIK"
#define WBAppSecret @"f6b748e2857904dcaa15bd17266a4180"

//极光
#define JPAppkey  @"3a251660858ce26b82cc6866"
#define JPchannel @""

//商店
#define StoreAppID @"1182862136"





/*
 ====================================================================================================//URL网络连接
 */

/**
 *  最新URL
 */
#define kHotsUrl @"http://news.67.com/zixun/"
/**
 *  爆料URL
 */
#define kGossipUrl @"http://news.67.com/scandal/"
/**
 *  私密URL
 */
#define kSecretsUrl @"http://www.67.com/www/miwen/"
/**
 *  八卦URL
 */
#define kPeachUrl @"http://news.67.com/taose/"
/**
 *  娱乐URL
 */
#define kCarnetioUrl @"http://news.67.com/rouse/"
/**
 *  黑色URL
 */
#define kBlackUrl @"http://news.67.com/heise/"
/**
 *  写真RUL
 */
#define WallpaperUrl @"http://tuku.mingxing.com/mxbz/"
/**
 *  现场RUL
 */
#define SceneUrl @"http://tuku.mingxing.com/hdxc/"
/**
 *  剧照RUL
 */
#define StillsUrl @"http://tuku.mingxing.com/ysjz/"
/**
 *  壁纸RUL
 */
#define PortraitUrl @"http://tuku.mingxing.com/mxxz/"
/**
 *  内地排名
 */
#define kChinaUrl @"http://www.mingxing.com/list/neidi/index.html"
/**
 *  港台排名
 */
#define kHongTaiUrl @"http://www.mingxing.com/list/gangtai/index.html"
/**
 *  日韩排名
 */
#define kJapanReaUrl @"http://www.mingxing.com/list/rihan/index.html"
/**
 *  欧美排名
 */
#define kEuropeAmerUrl @"http://www.mingxing.com/list/oumei/index.html"
/**
 *  天气接口
 */
#define weatherUrl @"https://free-api.heweather.com/v5/forecast"
/**
 *  视频接口
 */
#define videoListUrl(Pages)  [NSString stringWithFormat:@"http://c.m.163.com/nc/video/list/V9LG4B3A0/y/%d-10.html",(Pages-1)*10]

/**
 *  电台
 */
#define radioUrl @"http://api2.pianke.me/ting/radio"
/**
 *  电台详情
 */
#define RadioSecondUrl @"http://api2.pianke.me/ting/radio_detail"

/*
 
 
 ====================================================================================================//数据
 */






