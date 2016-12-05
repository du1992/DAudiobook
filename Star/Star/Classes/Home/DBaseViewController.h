//
//  DBaseViewController.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHotsDetailTool.h"
#import "DNewsCell.h"
#import "DNews.h"
#import "Macro.h"
#import "DHotsDataTool.h"
#import "MJRefresh.h"
#import "DLodingView.h"
#import "DNavigationController.h"
#import "DHotsDetailViewController.h"
#import "UIViewController+ZN.h"


typedef  void (^HasData)();
@interface DBaseViewController : UITableViewController
{
    //网页第几页
    __block NSUInteger _page;
}
@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, weak) MJRefreshHeaderView *header;

@property (nonatomic,strong) NSMutableArray *newsData;
@property (nonatomic,weak) HasData hasData;
@property (nonatomic,copy) NSString *htmlUrl;
@property (nonatomic,strong) DLodingView *lodingView;
+(dispatch_queue_t)queue;
-(void)loadNewData;
-(void)loadMoreData;

-(void)viewFirstLoadWithURL:(NSString *)url;
@end

