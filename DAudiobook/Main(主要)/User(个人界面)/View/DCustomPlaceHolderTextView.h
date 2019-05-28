//
//  DCustomPlaceHolderTextView.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/25.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DView.h"
NS_ASSUME_NONNULL_BEGIN

@interface DCustomAlertView : UIView
/**
 *  自定义取消按钮点击事件
 *
 *  @param cancelBlock 可选
 */
- (void)setupCancelBlock:(BOOL (^)())cancelBlock;
/**
 *  自定义确定或者自定义按钮点击事件
 *
 *  @param touchBlock 必选
 */
- (void)setupSureBlock:(BOOL (^)())touchBlock;

/**
 *  传nil默认为app window
 */
- (void)showInView:(UIView *)view;

/**
 *  构造方法
 *
 *  @param title  内容
 *  @param cancel 取消 左边
 *  @param sure   确定 右边
 */
- (instancetype)initWithTitle:(NSString *)title cancel:(NSString *)cancel sure:(NSString *)sure;
@end






@class DCustomPlaceHolderTextView;
@protocol DCustomPlaceHolderTextViewDelegate <NSObject>
/** 文本改变回调*/
- (void)customPlaceHolderTextViewTextDidChange:(DCustomPlaceHolderTextView *)textView;
@end

@interface DCustomPlaceHolderTextView : UITextView
@property (nonatomic, weak) id <DCustomPlaceHolderTextViewDelegate> del;
@property (nonatomic,copy) NSString *placehoder;
@property (nonatomic,strong)UIColor *placehoderColor;
@property (nonatomic, assign) CGFloat placeholderTopMargin;
@property (nonatomic, assign) CGFloat placeholderLeftMargin;
@property (nonatomic, strong) UIFont *placeholderFont;
@end

NS_ASSUME_NONNULL_END
