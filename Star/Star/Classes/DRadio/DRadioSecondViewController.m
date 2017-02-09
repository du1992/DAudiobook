//
//  DRadioSecondViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/7.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "DRadioSecondViewController.h"
#import "DRadioSecondHeaderView.h"
#import "Macro.h"
#import "UIBarButtonItem+Helper.h"
#import "Business.h"
#import "DRadioSecondRadioInfo.h"
#import "DRadioSecondListModel.h"
#import "DRadioThirdViewController.h"
#import "RadioSecondCell.h"
#import "userinfo.h"
#import "DRadioViewController.h"
@interface DRadioSecondViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
@property (nonatomic,strong) UITableView *radioTableView;
@property (nonatomic,strong) DRadioSecondHeaderView *headerView;
@property (nonatomic,strong) NSMutableArray *TopdataSource;
@property (nonatomic,strong) NSMutableArray *tableViewSource;
@property (nonatomic,strong) NSString *contentid;
@property(nonatomic,assign)NSInteger number;
@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, weak) MJRefreshHeaderView *header;
@end

@implementation DRadioSecondViewController

- (void)passContentidForRadio:(NSString *)contentid
{
    if (![contentid isKindOfClass:[NSNull class]]) {
        self.contentid = contentid;
    }
}

#pragma mark -
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.radioTableView];
    self.headerView = [[DRadioSecondHeaderView alloc] initWithFrame:CGRectMake(0, 0,WIDTH , HEIGHT * 0.4)];
    self.radioTableView.tableHeaderView = self.headerView;
    self.radioTableView.tableFooterView = [[UIView alloc] init];
//    [self  setupRefreshView];
    self.number=1;
    [self creatURLRequest];
    
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedBack:)];
    
}
-(void)didClickedBack:(UIBarButtonItem *)item{
  [self.navigationController popViewControllerAnimated:YES];
    
}
//-(void)didClickedBack:(UIBarButtonItem *)item{
//     [self dismissViewControllerAnimated:YES completion:nil];
//    
//}
#pragma mark - 网络请求
- (void)creatURLRequest
{
    NSDictionary *params = @{
                             @"radioid":self.contentid,
                             @"start":@(self.number),
                             @"limit":@"10",
                             @"client":@"2",
                             };
    
    [[Business sharedInstance] getRadioSecond:RadioSecondUrl params:params succ:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSDictionary *dataDic = responseObject[@"data"];
        [self.TopdataSource addObject: [DRadioSecondRadioInfo mj_objectWithKeyValues:dataDic[@"radioInfo"]]];
        NSMutableArray *array = [DRadioSecondListModel mj_objectArrayWithKeyValuesArray:dataDic[@"list"]];
        [self.tableViewSource addObjectsFromArray:array];
        
        self.headerView.radioInfo = [self.TopdataSource firstObject];
        
        [self.radioTableView reloadData];
     
        
        
    } fail:^(NSString *error) {
        
        
    }];
}
/**
 *  集成刷新控件
 */
- (void)setupRefreshView
{
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.radioTableView;
    header.delegate = self;
    // 自动进入刷新状态
    //    [header beginRefreshing];
    self.header = header;
    
    // 2.上拉刷新(上拉加载更多数据)
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.radioTableView;
    footer.delegate = self;
    self.footer = footer;
    
}

/**
 *  刷新控件进入开始刷新状态的时候调用
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        // 上拉刷新
        self.number ++;
        [self creatURLRequest];
        [self.footer endRefreshing];
    } else {
        // 下拉刷新
        [self.tableViewSource removeAllObjects];
        self.number=1;
        [self creatURLRequest];
        [self.header endRefreshing];
    }
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewSource.count;
}


#pragma mark - 表格代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioSecondCell *cell = [RadioSecondCell cellWithtableView:tableView];
    cell.radioListModel = self.tableViewSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRadioSecondListModel *model = self.tableViewSource[indexPath.row];
    DRadioThirdViewController *thirdVC = [[DRadioThirdViewController alloc] init];
    DRadioSecondRadioInfo *info = [self.TopdataSource firstObject];
    [thirdVC passModel:model andName:info.userinfo.uname];
    [self.navigationController pushViewController:thirdVC animated:YES];
   
}



#pragma mark -
#pragma mark - 懒加载
- (UITableView *)radioTableView
{
    if (!_radioTableView) {
        _radioTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _radioTableView.delegate = self;
        _radioTableView.dataSource = self;
        _radioTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _radioTableView;
}

- (NSMutableArray *)TopdataSource
{
    if (!_TopdataSource) {
        _TopdataSource = [NSMutableArray array];
    }
    return _TopdataSource;
}

- (NSMutableArray *)tableViewSource
{
    if (!_tableViewSource) {
        _tableViewSource = [NSMutableArray array];
    }
    return _tableViewSource;
}


@end
