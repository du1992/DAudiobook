//
//  DHeadView.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/1/30.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "DHeadView.h"
#import "UIImage+LevelView.h"
#import "Macro.h"

#define kIconView_W 40
#define kIconView_H 40
#define kTimeInterval 30
@interface DHeadView ()
@property(nonatomic, strong) UIButton       *coverBtn;
@property(nonatomic, strong) UIImageView    *iconView;
@property(nonatomic, strong) UILabel        *nameLable;
@property(nonatomic, strong) UIImageView    *levelView;
@property(nonatomic, strong) UIImageView    *qrView;
@property(nonatomic, strong) UILabel        *infoLabel;
@property(nonatomic, strong) UIScrollView   *backView;
@property(nonatomic, strong) UIImageView    *scrollImageView;


@end



@implementation DHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    //    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    //    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    UITapGestureRecognizer *tapThree = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    UITapGestureRecognizer *tapFour = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    UITapGestureRecognizer *tapFive = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    UITapGestureRecognizer *tapSix = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    UITapGestureRecognizer *tapSeven = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    
    self.clipsToBounds = YES;
    
    self.backView = [[UIScrollView alloc] init];
    self.backView.backgroundColor = [UIColor redColor];
    self.backView.bounces = NO;
    self.backView.showsVerticalScrollIndicator = NO;
    self.backView.showsHorizontalScrollIndicator = NO;
    self.backView.translatesAutoresizingMaskIntoConstraints = NO;
    //    self.backView.userInteractionEnabled = YES;
    //    [self.backView addGestureRecognizer:tapOne];
    self.backView.tag = 10006;
    [self addSubview:self.backView];
    
    self.scrollImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2012.jpg"]];
    self.scrollImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.scrollImageView.clipsToBounds = YES;
    self.scrollImageView.tag = 10000;
    //    self.scrollImageView.userInteractionEnabled = YES;
    //    [self.backView addGestureRecognizer:tapTwo];
    [self.backView addSubview:self.scrollImageView];
    
    
    self.coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.coverBtn addTarget:self action:@selector(coverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.coverBtn];
    
    
    self.qrView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    self.qrView.contentMode = UIViewContentModeScaleAspectFit;
    self.qrView.tag = 10001;
    self.qrView.userInteractionEnabled = YES;
    [self.qrView addGestureRecognizer:tapThree];
    [self addSubview:self.qrView];
    
    self.iconView = [[UIImageView alloc] init];
    self.iconView.image = [UIImage imageNamed:@"小熊明星资讯"];
    self.iconView.layer.cornerRadius = kIconView_W/2;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.borderWidth = 2;
    self.iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconView.tag = 10002;
    self.iconView.userInteractionEnabled = YES;
    [self.iconView addGestureRecognizer:tapFour];
    [self addSubview:self.iconView];
    
    self.nameLable = [[UILabel alloc] init];
    self.nameLable.text = @"小熊资讯";
    self.nameLable.textColor = [UIColor whiteColor];
    self.nameLable.font = kFount(32);
    self.nameLable.tag = 10003;
    self.nameLable.userInteractionEnabled = YES;
    [self.nameLable addGestureRecognizer:tapFive];
    [self addSubview:self.nameLable];
    
//    self.levelView = [[UIImageView alloc] initWithImage:[UIImage levelViewWithLevelCount:187]];
//    self.levelView.contentMode = UIViewContentModeScaleAspectFit;
//    self.levelView.tag = 10004;
//    self.levelView.userInteractionEnabled = YES;
//    [self.levelView addGestureRecognizer:tapSix];
//    [self addSubview:self.levelView];
    
    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.textColor = [UIColor whiteColor];
    self.infoLabel.textAlignment = NSTextAlignmentLeft;
    self.infoLabel.font = [UIFont systemFontOfSize:15];
    self.infoLabel.text = @"享受生活，让自己静下来";
    self.infoLabel.userInteractionEnabled = YES;
    self.infoLabel.tag = 10005;
    [self.infoLabel addGestureRecognizer:tapSeven];
    [self addSubview:self.infoLabel];
    
    
}

- (void)coverBtnClick:(UIButton *)sender {
    if (self.headerViewBlock) {
        self.headerViewBlock(@"个人信息");
    }
}

- (void)tapEvent:(UITapGestureRecognizer *)tap {
    if (!self.headerViewBlock) {
        return;
    }
    if (tap.view.tag == 10001) {
        self.headerViewBlock(@"我的二维码");
    } else if (tap.view.tag == 10005) {
        self.headerViewBlock(@"编辑签名");
    } else {
        self.headerViewBlock(@"个人信息");
    }
}

- (NSTimer *)timer {
    __weak typeof(self) weakSelf = self;
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
            [UIView animateWithDuration:kTimeInterval * 0.5 animations:^{
                weakSelf.backView.contentOffset = CGPointMake(0, 700);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:kTimeInterval * 0.5 animations:^{
                    weakSelf.backView.contentOffset = CGPointMake(0, 0);
                }];
            }];
        }];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)setUesrName:(NSString *)uesrName {
    _uesrName = uesrName;
    self.nameLable.text = uesrName;
}
- (void)setUserIcon:(UIImage *)userIcon {
    _userIcon = userIcon;
    self.iconView.image = userIcon;
}
- (void)setUserInfo:(NSString *)userInfo {
    _userInfo = userInfo;
    self.infoLabel.text = userInfo;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof(self) weekSelf = self;
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weekSelf);
        make.height.mas_equalTo(300);
    }];
    
    [self.scrollImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(weekSelf.backView);
    }];
    [self.qrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weekSelf).offset(40);
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.right.mas_equalTo(weekSelf).offset(-20);
    }];
    
    [self.coverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weekSelf.qrView.mas_bottom).offset(25);
        make.left.mas_equalTo(weekSelf).offset(20);
        make.size.mas_equalTo(CGSizeMake(kIconView_W, kIconView_H));
    }];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weekSelf.iconView);
        make.left.mas_equalTo(weekSelf.iconView.mas_right).offset(10);
        make.width.mas_equalTo(320 - 20 - kIconView_W - 20);
    }];
    
    [self.levelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weekSelf.iconView);
        make.top.mas_equalTo(weekSelf.iconView.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(16 * 15, 16));
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weekSelf.iconView);
        make.width.mas_equalTo(280);
        make.height.mas_offset(20);
        make.bottom.mas_equalTo(weekSelf).offset(-15);
    }];
    
    
}



@end
