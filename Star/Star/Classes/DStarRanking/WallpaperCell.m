//
//  Wallpaper.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "WallpaperCell.h"
#import "Macro.h"
#import "UIImageView+WebCache.h"

@implementation WallpaperCell

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

//创建cell上显示的控件
-(void)setupSubviews
{
    self.imgView=[[UIImageView alloc]initWithFrame:self.bounds];
    [self.contentView addSubview:_imgView];
   self.label=[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40)];
    _imgView.contentMode=UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds=YES;
    _label.backgroundColor=[UIColor lightTextColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font=[UIFont systemFontOfSize:13.0];
    _label.numberOfLines=2;
    
    _imgView.layer.cornerRadius=8;
    _imgView.layer.masksToBounds=YES;
    _imgView.clipsToBounds = YES;
    _imgView.layer.borderWidth =0.5;
    _imgView.layer.borderColor = RGB(81, 41, 23).CGColor;
    
    self.contentView.layer.cornerRadius=8;
    self.contentView.layer.masksToBounds=YES;
    self.contentView.clipsToBounds = YES;
    
    [self.contentView addSubview:_label];
    
}




@end
