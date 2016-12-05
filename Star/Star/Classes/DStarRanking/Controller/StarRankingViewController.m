//
//  StarRankingViewController.m
//  Star
//
//  Created by JUNE_EN on 15/5/30.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "StarRankingViewController.h"
#import "RankingsCell.h"
#import "RankingTool.h"
#import "Ranking.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+ZN.h"
#import "DNavigationController.h"
#import "StarInfoViewController.h"
#import "MJRefresh.h"
#import "RankingMoreTool.h"
#import "Macro.h"



@interface StarRankingViewController ()<UITabBarDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>
@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, weak) MJRefreshHeaderView *header;

@property(nonatomic,strong)__block NSMutableArray *starData;
@property (nonatomic,weak) UITableView *customTableView;
@property (nonatomic,assign) int number;
@end

@implementation StarRankingViewController

-(NSMutableArray *)starArray{
    if (nil ==_starArray) {
        self.starArray=[NSMutableArray array];
    }
    return _starArray;
}

-(NSMutableArray *)starData{
    if (_starData == nil ) {
        _starData=[NSMutableArray array];
    }
    return _starData;
}

-(void)loadView{
    
    UIView *view=[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view=view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self isUrlStrin];
    [self setupTableView];
    [self setupRefreshView];
    self.customTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _number=1;
    //加载数据
    [self   loadMoreData];
    //设置颜色
    self.view.backgroundColor=[UIColor whiteColor];
    
    
}

/**
 *  集成刷新控件
 */
- (void)setupRefreshView
{
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.customTableView;
    header.delegate = self;
    // 自动进入刷新状态
    //    [header beginRefreshing];
    self.header = header;
    
    // 2.上拉刷新(上拉加载更多数据)
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.customTableView;
    footer.delegate = self;
    self.footer = footer;

}

/**
 *  刷新控件进入开始刷新状态的时候调用
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新
        [self loadMoreData];
    } else {
        // 下拉刷新
        self.number=2;
        [self loadMoreData];
        //结束刷新
        [self.footer endRefreshing];
    }
}

#pragma mark 刷新
-(void)loadMoreData{
    
    __block  NSString *str=nil;
    if (_number>1) {
        NSRange range= [_urlString rangeOfString:@".html"];
        str=[_urlString stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"_%d.html",_number]];
        
    }else{

        str=_urlString;
    }
    self.number++;
    __unsafe_unretained typeof(self) selfVC=self;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *mutArray=[NSMutableArray array];
        NSArray *array= [RankingMoreTool rankingMore:str];
        if (array!=nil) {
            for (int i=0; i<array.count;i++) {
                if (i>=10) {
                    NSDictionary *dict=array[i];
                    Ranking *ranking=[Ranking rankingWithDict:dict];
                    [mutArray addObject:ranking];
                }
            }
            [self.starData addObjectsFromArray:mutArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                [selfVC.customTableView reloadData];
                [selfVC.footer endRefreshing];
            });
        }else{
           [selfVC.footer endRefreshing];
        }
    });
    
}

-(void)setupTableView{
    UITableView *tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0,WIDTH , HEIGHT) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=90;
    
    //注册
    [tableView registerNib:[UINib nibWithNibName:@"RankingsCell" bundle:nil] forCellReuseIdentifier:@"ranking"];
    [self.view addSubview:tableView];
    self.customTableView=tableView;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.starData.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankingsCell *cell =[RankingsCell cellWithTableView:tableView];
    Ranking *ranking=self.starData[indexPath.row];
    if (ranking) {
        ranking.chart=[NSString stringWithFormat:@"%0.2ld",indexPath.row+1];
        if ((indexPath.row)+1==1) {
            ranking.chartColor=RGB(173, 79, 93);
            cell.imgView.layer.borderColor = RGB(173, 79, 93).CGColor;
        }else if ((indexPath.row)+1==2){
            ranking.chartColor=RGB(218,160, 75);
            cell.imgView.layer.borderColor = RGB(218,160, 75).CGColor;
        }else if ((indexPath.row)+1==3){
            ranking.chartColor=RGB(152,189, 0);
            cell.imgView.layer.borderColor = RGB(152,189, 0).CGColor;
        }else{
            ranking.chartColor=RGB(135,135, 135);
            cell.imgView.layer.borderColor = RGB(135,135, 135).CGColor;
        }
        cell.ranking=ranking;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.starData.count) {
       Ranking *ranking=self.starData[indexPath.row];
        StarInfoViewController *starInfo=[[StarInfoViewController alloc] init];
        starInfo.linkUrl=ranking.linkUrl;
        starInfo.starName=ranking.name;
        starInfo.ranking=ranking;
        [self.navigationController pushViewController:starInfo animated:YES];
    }
}
-(void)isUrlStrin{
    if ([self.title isEqualToString:@"内地排名"]) {
        self.urlString=kChinaUrl;
    }else if ([self.title isEqualToString:@"港台排名"]) {
        self.urlString=kHongTaiUrl;
    }else if ([self.title isEqualToString:@"日韩排名"]) {
        self.urlString=kJapanReaUrl;
    }else if ([self.title isEqualToString:@"欧美排名"]) {
        self.urlString=kEuropeAmerUrl;
    }
   
}
- (void)dealloc
{
    // 释放内存
    [self.header free];
    [self.footer free];
}
@end
