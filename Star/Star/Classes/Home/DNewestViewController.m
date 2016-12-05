//
//  DNewestViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.
//   热门

#import "DNewestViewController.h"
#import "SDCycleScrollView.h"
#import "DHeaderScrollTool.h"
#import "DHotHeaderDetailViewController.h"
@interface DNewestViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)__block NSMutableArray *imgArray;
@property (nonatomic,strong)__block NSMutableArray *titleArray;
@property (nonatomic,strong)__block NSMutableArray *linkArray;
@property (nonatomic,strong)__block SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong)__block  NSArray *headerData;
@end

@implementation DNewestViewController
-(NSMutableArray *)imgArray{
    if (nil ==_imgArray) {
        self.imgArray=[NSMutableArray array];
    }
    return _imgArray;
}
-(NSMutableArray *)titleArray{
    if (nil ==_titleArray) {
        self.titleArray=[NSMutableArray array];
    }
    return _titleArray;
}
-(NSMutableArray *)linkArray{
    if (nil ==_linkArray) {
        self.linkArray=[NSMutableArray array];
    }
    return _linkArray;
}
-(void)viewFirstLoad{
    [self addObserver:self forKeyPath:@"headerData" options:NSKeyValueObservingOptionNew context:nil];
    
    [self viewFirstLoadWithURL:kHotsUrl];
    
    if (self.tableView.visibleCells.count>0) {
//        [GMDCircleLoader hideFromView:self.view animated:YES];
    }
    
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    self.imgArray=nil;
    self.titleArray=nil;
    self.linkArray=nil;
    if (self.headerData.count>0) {
        for (NSDictionary *dict in self.headerData) {
            NSString *imgUrl=dict[@"imgUrl"];
            NSURL *url=[NSURL URLWithString:imgUrl];
            NSString *title=dict[@"title"];
            NSString *linkUrl=dict[@"linkUrl"];
            [self.imgArray addObject:url];
            [self.titleArray addObject:title];
            [self.linkArray addObject:linkUrl];
        }
        NSArray *imagesURL=self.imgArray;
        NSArray *titles=self.titleArray;
        CGFloat w = self.view.bounds.size.width;
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 280, w, 180) imageURLsGroup:imagesURL];
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView.delegate = self;
        cycleScrollView.titlesGroup = titles;
        self.cycleScrollView=cycleScrollView;
        [self.view sendSubviewToBack:self.tableView.tableHeaderView];
        self.tableView.tableHeaderView =cycleScrollView;
        [self.view sendSubviewToBack:self.tableView.tableHeaderView];
    }
    
}
-(void)dealloc{
    [self removeObserver:self forKeyPath:@"imgArray"];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self viewFirstLoad];
    [self setupHeaderView];
}
-(void)setupHeaderView{
    [self.tableView reloadData];
    __unsafe_unretained typeof(self) selfVC=self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *array=[DHeaderScrollTool headerPhotos:@"http://www.mingxing.com/"];
        if (array.count>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                selfVC.headerData =array;
            });
        }
    });
    
}
#pragma mark 下拉刷新
-(void)loadNewData{
    self.htmlUrl=kHotsUrl;
    [super loadNewData];
    self.headerData=nil;
    [self setupHeaderView];
}
#pragma mark 上拉刷新
-(void)loadMoreData{
    self.htmlUrl=[NSString stringWithFormat:@"%@index_%ld.html",kHotsUrl,_page];
    [super loadMoreData];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DHotHeaderDetailViewController *hotHeader=[[DHotHeaderDetailViewController alloc] init];
    DNavigationController *nav=[[DNavigationController alloc] initWithRootViewController:hotHeader];
    hotHeader.linkUrl=self.linkArray[index];
    
    nav.modalPresentationStyle=UIModalPresentationPopover;
    [self presentViewController:nav animated:YES completion:nil];
    //    [self.navigationController pushViewController:hotHeader animated:YES];
}
@end
