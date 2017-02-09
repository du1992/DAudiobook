//
//  DBaseViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.
//  所有子模块的父类

#import "DBaseViewController.h"

@interface DBaseViewController ()<MJRefreshBaseViewDelegate>

@end
static dispatch_queue_t _queue;
@implementation DBaseViewController

+(dispatch_queue_t)queue{
    if (!_queue) {
        _queue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);//创建串行队列
    }
    return _queue;
}
#pragma mark 懒加载 数据存储数组
-(NSMutableArray *)newsData{
    if (nil ==_newsData) {
        self.newsData=[NSMutableArray array];
    }
    return _newsData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _page=2;
    UINib *nib = [UINib nibWithNibName:@"DNewsCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"newsCell"];
    self.tableView.rowHeight=160;
    self.tableView.contentInset=UIEdgeInsetsMake(10, 0, 50, 0);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self setupRefreshView];
}

/**
 *  集成刷新控件
 */
- (void)setupRefreshView
{
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    // 自动进入刷新状态
    //    [header beginRefreshing];
    self.header = header;
    
    // 2.上拉刷新(上拉加载更多数据)
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
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
    } else { // 下拉刷新
        [self loadNewData];
        //结束刷新
        [self.footer endRefreshing];
    }
}
#pragma mark 下拉刷新
-(void)loadNewData{
    __unsafe_unretained typeof(self) selfVC=self;
    __block NSMutableArray *mutArray=nil;
    
//    [GMDCircleLoader startInView:selfVC.view animated:YES];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        mutArray=[NSMutableArray array];
        NSArray *array= [DHotsDataTool hotsData:self.htmlUrl];
        if (nil !=array) {
            for (NSDictionary *dict in array) {
                DNews *new=[DNews newsWithDict:dict];
                [mutArray addObject:new];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //获取新数据
                NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",self.newsData];
                NSArray * theNewest = [mutArray filteredArrayUsingPredicate:filterPredicate];
                
                if (theNewest.count>0) {
                    //放入当前数组中
                    NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, theNewest.count)];
                    [selfVC.newsData insertObjects:theNewest atIndexes:indexSet];
//                    [GMDCircleLoader hideFromView:self.view animated:YES];
                    [selfVC.tableView reloadData];
                }
                [selfVC.header endRefreshing];
            });
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [GMDCircleLoader stopInView:self.view animated:YES];
                [selfVC.header endRefreshing];
                
            });
            
        }
    });
    
}
#pragma mark 上拉刷新
-(void)loadMoreData{
    
    __unsafe_unretained typeof(self) selfVC=self;
    __block NSArray *array=nil;
    [self dispathLoad:^{
        NSMutableArray *mutArray=[NSMutableArray array];
        array= [DHotsDataTool hotsData:self.htmlUrl];
        if(nil != array){
            for (NSDictionary *dict in array) {
                DNews *new=[DNews newsWithDict:dict];
                [mutArray addObject:new];
            }
            [selfVC.newsData addObjectsFromArray:mutArray];
        }
    } mainQueue:^{
        if (array.count>0) {
            [selfVC.tableView reloadData];
            _page++;
        }
        [selfVC.footer endRefreshing];
    }];
    
}
#pragma mark 封装异步加载请求
-(void)dispathLoad:(void (^)())block mainQueue:(void (^)())mainBlock{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        block();
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            mainBlock();
        });
        
    });
    
}

-(void)viewFirstLoadWithURL:(NSString *)url{
    
    __unsafe_unretained typeof(self) selfVC=self;
    _page=2;
    self.newsData=nil;
//    [GMDCircleLoader hideFromView:self.view animated:YES];
//    [GMDCircleLoader setOnView:self.view withTitle:@"正在拼命加载..." animated:YES];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    dispatch_queue_t queue=[DBaseViewController queue];
    dispatch_async(queue, ^{
        // 处理耗时操作的代码块...
        NSArray *array= [DHotsDataTool hotsData:url];
        if (nil !=array) {
            for (NSDictionary *dict in array) {
                DNews *new=[DNews newsWithDict:dict];
                [selfVC.newsData addObject:new];
            }
            
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
//                [GMDCircleLoader hideFromView:selfVC.view animated:YES];
                 selfVC.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
                [selfVC.tableView reloadData];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [selfVC.tableView reloadData];
//                [GMDCircleLoader stopInView:selfVC.view animated:YES];
            });
            
        }
        
    });
    
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.newsData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DNewsCell *cell=[DNewsCell cellWithTableView:tableView];
    if (self.newsData.count) {
        cell.news=self.newsData[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.newsData.count) {
        DNews *news=self.newsData[indexPath.row];
        DHotsDetailViewController *hotsController=[[DHotsDetailViewController alloc] init];
        DNavigationController *nav=[[DNavigationController alloc] initWithRootViewController:hotsController];
        hotsController.linkUrl=news.linkUrl;
        nav.modalPresentationStyle=UIModalPresentationPopover;
        [self presentViewController:nav animated:YES completion:nil];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    
}

- (void)dealloc
{
    // 释放内存
    [self.header free];
    [self.footer free];
}

@end
