//
//  DPublishDraftBottomView.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/26.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DPublishDraftBottomView.h"

#define kCommonBlackColor [UIColor colorWithRed:0.17f green:0.23f blue:0.28f alpha:1.00f]
#define kCommonHighLightRedColor [UIColor colorWithRed:1.00f green:0.49f blue:0.65f alpha:1.00f]

#import "DPublishDraftBottomView.h"
@implementation DCustomTopImageButton
- (instancetype)init {
    self = [super init];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.width * 2 / 3, self.height * 2 / 3.0);
    self.imageView.contentMode = UIViewContentModeCenter;
    self.imageView.centerX = self.width / 2.0;
    self.titleLabel.frame = CGRectMake(0, self.imageView.bottom, self.width, self.height - self.imageView.height);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end






@interface DPublishDraftBottomView ()
/** 图片*/
@property (nonatomic, weak) DCustomTopImageButton *imgBtn;
/** 视频*/
@property (nonatomic, weak) DCustomTopImageButton *videoBtn;
/** 输入字数*/
@property (nonatomic, weak) UILabel *countL;
/** 匿名*/
@property (nonatomic, weak) UIButton *anonymousBtn;
@end

@implementation DPublishDraftBottomView

- (void)setLimitCount:(NSInteger)limitCount {
    _limitCount = limitCount;
    self.countL.text = [NSString stringWithFormat:@"还能输入%ld个字", (long)limitCount];
}

- (DCustomTopImageButton *)imgBtn {
    if (!_imgBtn) {
        DCustomTopImageButton *btn = [DCustomTopImageButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _imgBtn = btn;
        [btn setTitle:@"文本" forState:UIControlStateNormal];
        btn.titleLabel.font = AppFont(12);
        [btn setTitleColor:[UIColor colorWithRed:0.17f green:0.23f blue:0.28f alpha:1.00f] forState:UIControlStateNormal];
        btn.tag = 1;
        [btn setImage:[UIImage imageNamed:@"守护骑士"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imgBtn;
}


- (UIButton *)anonymousBtn {
    if (!_anonymousBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _anonymousBtn = btn;
        [btn setTitle:@"匿名" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"anonymous"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"anonymous_press"] forState:UIControlStateSelected];
        btn.titleLabel.font = AppFont(14);
        [btn setTitleColor:kCommonBlackColor forState:UIControlStateNormal];
        [btn setTitleColor:kCommonHighLightRedColor forState:UIControlStateSelected];
        btn.tag = 3;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _anonymousBtn;
}

- (UILabel *)countL {
    if (!_countL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _countL = label;
        label.font = AppFont(14);
        label.textColor = [UIColor colorWithRed:0.32f green:0.36f blue:0.40f alpha:1.00f];
        label.textAlignment = NSTextAlignmentRight;
    }
    return _countL;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 图片
    CGFloat imgX = 10;
    CGFloat imgY = 10;
    CGFloat imgW = 60;
    CGFloat imgH = self.height - imgY * 2;
    self.imgBtn.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    // 视频
    //    CGFloat videoX = self.imgBtn.right + 20;
    //    CGFloat videoY = 10;
    //    CGFloat videoW = 60;
    //    CGFloat videoH = imgH;
    //    self.videoBtn.frame = CGRectMake(videoX, videoY, videoW, videoH);
    
    // 匿名
    CGFloat anoX = self.width - 60;
    CGFloat anoY = self.height - 50;
    CGFloat anoW = 50;
    CGFloat anoH = 30;
    self.anonymousBtn.frame = CGRectMake(anoX, anoY, anoW, anoH);
    
    // 输入字数
    CGFloat countX = 0;
    CGFloat countY = 0;
    CGFloat countW = self.width - 10;
    CGFloat countH = 14;
    self.countL.frame = CGRectMake(countX, countY, countW, countH);
}

- (void)btnClick:(UIButton *)btn {
    
    btn.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(publishDraftBottomView:didClickItemWithType:)]) {
        [self.delegate publishDraftBottomView:self didClickItemWithType:btn.tag];
    }
}

@end
