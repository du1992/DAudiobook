//
//  DPictureViewController.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPictureModel.h"
#import "DPictureView.h"
#import "D3DScrollView.h"
#import "ToolForPictureDetail.h"
#import "DPictureDetailModel.h"

@interface DPictureViewController : UIViewController<UIScrollViewDelegate>
@property(nonatomic,strong)DPictureModel *pictureModel;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)__block NSMutableArray *array;
@property(nonatomic,strong)D3DScrollView *scrollViewTwo;
@end
