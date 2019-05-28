//
//  DShareView.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/27.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DShareView : DView

@property (nonatomic, copy) void (^shareResult) (NSString *);

@property (nonatomic, strong) UIView         *bottomView;
@property (nonatomic, strong) NSMutableArray *buttonArray;

/**
 *  点击按钮弹出
 */
-(void)show;



@end

NS_ASSUME_NONNULL_END
