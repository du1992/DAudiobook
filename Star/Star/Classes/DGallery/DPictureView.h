//
//  DPictureView.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPictureModel.h"
#import "DPictureDetailModel.h"

@interface DPictureView : UIView

//页面布局
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,retain)DPictureModel *pictureModel;
@property(nonatomic,strong)DPictureDetailModel *pictureDetailModel;
@end
