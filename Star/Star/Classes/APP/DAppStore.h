//
//  DAppStore.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/9.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DAppStore : NSObject<UIAlertViewDelegate>
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    
    UIAlertView *alertViewTest;
    
#else
    
    UIAlertController *alertController;
    
#endif
    
    
}


@property (nonatomic,strong) NSString * myAppID;//appID


- (void)showGotoAppStore:(UIViewController *)VC;
@end
