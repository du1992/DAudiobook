//
//  DBaseCollectionViewController.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWallpaperCell.h"
#import "DPictureModel.h"
#import "ToolOfPhotos.h"
#import "Macro.h"
#import "DPictureViewController.h"
#import "MJRefresh.h"
#import "UIViewController+ZN.h"
@interface DBaseCollectionViewController : UICollectionViewController<MJRefreshBaseViewDelegate>
{
    //网页第几页
    __block NSUInteger _page;
}
@property(nonatomic,strong)NSMutableArray *array;
@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic,copy) NSString *htmlUrl;
@property(nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

-(void)loadNewData;
-(void)loadMoreData;
@end
