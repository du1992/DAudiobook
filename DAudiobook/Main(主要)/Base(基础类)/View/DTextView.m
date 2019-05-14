//
//  DTextView.m
//  InterstellarNotes
//
//  Created by DUCHENGWEN on 2019/1/12.
//  Copyright © 2019年 liujiliu. All rights reserved.
//

#import "DTextView.h"

@interface DTextView()<UITextViewDelegate,UIScrollViewDelegate>
{
   
  
}
@end


@implementation DTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
      return self;
}

- (void)createUI{
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_top).offset(0);
        make.left.mas_equalTo(self.textView.mas_left).offset(0);
        make.height.mas_equalTo(39);
    }];
    
   
    
}



#pragma mark --- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    /**
     *  设置占位符
     */
    if (textView.text.length == 0) {
        self.placeholderLabel.hidden=NO;
     
    }else{
        self.placeholderLabel.hidden=YES;
    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.textViewDidEndEditingBlock) {
        self.textViewDidEndEditingBlock(textView.text);
    }
}


#pragma mark --- 懒加载控件
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.delegate = self;
        [self addSubview:_textView];
    }
    return _textView;
}

- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.font = [UIFont systemFontOfSize:16];
        _placeholderLabel.textColor = UIColorFromRGBValue(0xb3b3b3);
        [self addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}



@end
