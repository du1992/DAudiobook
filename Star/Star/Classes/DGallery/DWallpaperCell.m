//
//  DWallpaper.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "DWallpaperCell.h"
#import "Macro.h"
#import "UIImageView+WebCache.h"

@interface DWallpaperCell ()

@property (nonatomic ,strong) UIImageView *showImageView;
@property (nonatomic,retain) UILabel  *label;

@end

@implementation DWallpaperCell

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 160)];
    self.showImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.showImageView.clipsToBounds = YES;
    self.showImageView.layer.borderWidth =0.5;
    self.showImageView.layer.borderColor = RGB(81, 41, 23).CGColor;
    _label=[[UILabel alloc]initWithFrame:CGRectMake(5,132, WIDTH,30)];
    _label.textColor=[UIColor whiteColor];
    _label.font=[UIFont systemFontOfSize:14];
    
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 130, WIDTH, 30)];
    view.backgroundColor=[UIColor grayColor];
    view.alpha=0.5;
    [self.contentView addSubview:self.showImageView];
    [self.contentView addSubview:view];
    [self.contentView addSubview:self.label];
    
    
}

-(void)setPictureModel:(DPictureModel *)pictureModel
{
    if (_pictureModel!=pictureModel) {
        
        [_showImageView sd_setImageWithURL:[NSURL URLWithString:pictureModel.imgUrl] placeholderImage:[UIImage imageNamed:@"PhotosPlaceholder.png"] completed:nil];
        _label.text=pictureModel.title;
    }
    
}
@end
