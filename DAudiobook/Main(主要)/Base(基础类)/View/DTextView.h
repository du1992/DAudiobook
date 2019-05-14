//
//  DTextView.h
//  InterstellarNotes
//
//  Created by DUCHENGWEN on 2019/1/12.
//  Copyright © 2019年 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//------ 完成编辑 -----//
typedef void (^TextViewDidEndEditingBlock)(NSString *text);


@interface DTextView : UIView

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel    *placeholderLabel;
@property (nonatomic, strong) TextViewDidEndEditingBlock textViewDidEndEditingBlock;


@end

NS_ASSUME_NONNULL_END
