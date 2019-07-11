//
//  DTableViewController.m
//  InterstellarNotes
//
//  Created by DUCHENGWEN on 2019/1/9.
//  Copyright © 2019年 liujiliu. All rights reserved.
//

#import "DTableViewController.h"
#import "DBaseRequest.h"
#import "MMDrawerBarButtonItem.h"
#import "UIBarButtonItem+Helper.h"
#import "UIViewController+MMDrawerController.h"
#import "DAllControllersTool.h"


#import "GDTMobBannerView.h"



@interface DTableViewController ()<UITableViewDelegate,UITableViewDataSource,GDTMobBannerViewDelegate>{
     CGFloat _startDragY;
     GDTMobBannerView *bannerView;
}

@end

@implementation DTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeData];
    [self initializeTableView];
    [self initializeTableHeaderView];
    [self initializeTableFooterView];
//    [self initializeRefresh];
    
    [self setupNavItem];
    
}
-(void)initializeData{
    
}
-(void)initializeTableView{
    self.tableView=[UITableView new];
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
//区头
-(void)initializeTableHeaderView{
    
}
//区尾
- (void)initializeTableFooterView
{
    
}
//加载刷新控件
-(void)initializeRefresh{
    WEAKSELF
    // 1.下拉刷新
    MJRefreshHeader *header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf                    onHeaderRefreshing];
        [weakSelf.tableView.mj_header    endRefreshing];
    }];
    self.tableView.mj_header = header;
  
    
    // 2.上拉刷新(上拉加载更多数据)
    MJRefreshBackNormalFooter*footer =[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(onFooterRefreshing)];
    self.tableView.mj_footer = footer;
    self.tableView.mj_footer.hidden = NO;
   
}

- (void) setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated{
   
    [self contentOffsetChanged:contentOffset];
}

- (void) setContentOffset:(CGPoint)contentOffset{
  
    [self contentOffsetChanged:contentOffset];
}
- (void) contentOffsetChanged:(CGPoint)contentOffset{
    //判断是向下划
   
}
#pragma mark - 上啦
- (void)onFooterRefreshing{
    [self queryRecommendUserData:NO];
}
#pragma mark - 下啦
- (void)onHeaderRefreshing{
    [self queryRecommendUserData:YES];
}
#pragma mark - j
-(void)endNetworkRequest{
      [self.tableView.mj_footer    endRefreshing];
     [self.indicatorAnimationView removeAllAnimation];
      self.isRefresh=NO;
}
- (void)queryRecommendUserData:(BOOL)resetRequstData{
    if (self.isRefresh) {
        [self endNetworkRequest];
        return;
    }
    self.isRefresh=YES;
    if (resetRequstData) {
        self.page=0;
    }else{
        [self.indicatorAnimationView startAllAnimation];
    }
    WEAKSELF
    [DBaseRequest POST:[self getURL] parameters:[self getJSON] block:^(id  _Nullable input, NSError * _Nullable error) {
        if (!error) {
             [self dataProcessingIsRemove:resetRequstData input:input];
        }else{
              [self.view showLoadingMeg:kNetWorkError time:kDefaultShowTime];
        }
         [weakSelf endNetworkRequest];
    }];
    
   
}
//数据处理
-(void)dataProcessingIsRemove:(BOOL)isRemove input:(id)input{
   
}
//获取参数
-(NSMutableDictionary *)getJSON{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[self.pageModel pageOutput]];
    [dic setObject:@"1" forKey:@"type"];
    return dic;
}
//获取URL
-(NSString *)getURL{
    return @"";
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 200;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (DPageModel *)pageModel {
    if (_pageModel == nil) {
        _pageModel = [[DPageModel alloc]init];
        _pageModel.page  = 1;
        _pageModel.count = 10;
    }
    return _pageModel;
}

#pragma mark - 设置导航栏
- (void)setupNavItem
{
    //设置导航栏唤醒抽屉按钮
    MMDrawerBarButtonItem *leftItem = [MMDrawerBarButtonItem itemWithNormalIcon:@"menu" highlightedIcon:nil target:self action:@selector(leftDrawerButtonPress)];
    //设置紧挨着左侧按钮的标题按钮
    MMDrawerBarButtonItem *titleItem = [MMDrawerBarButtonItem itemWithTitle:[self getMenuTitle] target:self action:@selector(leftDrawerButtonPress)];
    
    self.navigationItem.leftBarButtonItems = @[leftItem,titleItem];
}
- (void)leftDrawerButtonPress
{
    [[DAllControllersTool shareOpenController].drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
//获取菜单title
-(NSString *)getMenuTitle{
    return @"";
}



#pragma mark - 广告
-(void)GDTadvertising{
    
    bannerView = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,40)
                                                  appId:GDTAppkey placementId:GDTPlacementIdD];
    
  if (IS_OS_7_OR_LATER) {
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    
    bannerView.delegate = self;
    bannerView.currentViewController = self;
    //    bannerView.isAnimationOn = NO;
    bannerView.showCloseBtn = YES;
    bannerView.isGpsOn = YES;
    [bannerView loadAdAndShow];
    [self.view addSubview:bannerView];
}

// 请求广告条数据成功后调用
//
// 详解:当接收服务器返回的广告数据成功后调用该函数
- (void)bannerViewDidReceived
{
   self.tableView.frame = CGRectMake(0, 40, kScreenWidth, kScreenHeight-40);
   NSLog(@"banner Received");
}

/**
 *  banner条被用户关闭时调用
 *  详解:当打开showCloseBtn开关时，用户有可能点击关闭按钮从而把广告条关闭
 */
- (void)bannerViewWillClose{
   self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}

// 请求广告条数据失败后调用
//
// 详解:当接收服务器返回的广告数据失败后调用该函数
- (void)bannerViewFailToReceived:(NSError *)error
{
    NSLog(@"banner failed to Received : %@",error);
}

// 广告栏被点击后调用
//
// 详解:当接收到广告栏被点击事件后调用该函数
- (void)bannerViewClicked
{
    NSLog(@"banner clicked");
}

// 应用进入后台时调用
//
// 详解:当点击下载或者地图类型广告时，会调用系统程序打开，
// 应用将被自动切换到后台
- (void)bannerViewWillLeaveApplication
{
    NSLog(@"banner leave application");
}







@end
