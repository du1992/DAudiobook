//
//  DShareView.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/17.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DShareView : UIView

@property (nonatomic, copy) void (^shareResult) (NSString *);

@property (nonatomic, strong) UIView         *bgControll;
@property (nonatomic, strong) NSMutableArray    *buttonArray;

-(void)showInView:(UIView *)view ;


@end
