//
//  DPictureView.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "DPictureView.h"
#import "UIImageView+WebCache.h"

@implementation DPictureView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _imgView=[[UIImageView alloc]initWithFrame:CGRectMake(4, 0, CGRectGetWidth(frame)-9, CGRectGetHeight(frame))];
        [self addSubview:_imgView];
        
        _imgView.contentMode=UIViewContentModeScaleAspectFit;
        
        _label=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgView.frame)-30, CGRectGetWidth(frame),30)];
        //字体居中
        _label.textAlignment=NSTextAlignmentCenter;
        //字体白色
        _label.textColor=[UIColor whiteColor];
        _label.numberOfLines=0;
        [_imgView addSubview:_label];
    }
    
    return self;
}


//
-(void)setPictureDetailModel:(DPictureDetailModel *)pictureDetailModel
{
    if (_pictureDetailModel!=pictureDetailModel) {
        //        [GMDCircleLoader setOnView:self withTitle:@"" animated:YES];
        //        [_imgView sd_setImageWithURL:[NSURL URLWithString:pictureDetailModel.imgUrl] placeholderImage:[UIImage imageNamed:@"PhotosPlaceholder.png"] completed:];
        
        [_imgView sd_setImageWithURL:[NSURL URLWithString:pictureDetailModel.imgUrl] placeholderImage:[UIImage imageNamed:@"HotsPlaceHoder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //            [GMDCircleLoader hideFromView:self animated:YES];
        }];
        _label.text=pictureDetailModel.title;
    }
    
}





@end
