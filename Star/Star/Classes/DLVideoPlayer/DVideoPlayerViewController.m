//
//  DLVideoPlayerViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/2.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "DVideoPlayerViewController.h"
#import "VideoDetailViewController.h"
#import "DVideoCell.h"
#import "DVideoPlayer.h"
#import "DVideoItem.h"
#import "Macro.h"
#import "Business.h"
#import "MMDrawerBarButtonItem.h"
#import "UIBarButtonItem+Helper.h"
#import "UIViewController+MMDrawerController.h"

@interface DVideoPlayerViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,MJRefreshBaseViewDelegate>{
    NSIndexPath *_indexPath;
    DVideoPlayer *_player;
    CGRect _currentPlayCellRect;
}

@property (strong, nonatomic) UITableView *videoPlayerTableView;
@property (nonatomic, strong) NSMutableArray *videoArray;
@property(nonatomic,assign)int number;
@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, weak) MJRefreshHeaderView *header;

@end

@implementation DVideoPlayerViewController
- (void)dealloc
{
    // 释放内存
    [self.header free];
    [self.footer free];
}

#pragma mark - lazt loading

- (DVideoPlayer *)player {
    if (!_player) {
        _player = [[DVideoPlayer alloc] init];
        _player.frame = CGRectMake(0, 64, WIDTH, 250);
    }
    return _player;
}

- (NSMutableArray *)videoArray {
    if (!_videoArray) {
        _videoArray = [NSMutableArray array];
    }
    return _videoArray;
}

#pragma mark - life cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setupNavItem];
    
    self.videoPlayerTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:self.videoPlayerTableView];
    
    self.videoPlayerTableView.estimatedRowHeight = 100;
    self.videoPlayerTableView.delegate=self;
    self.videoPlayerTableView.dataSource=self;
    [self  setupRefreshView];
    
    self.number=1;
    [self requstData:videoListUrl(self.number)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_player destroyPlayer];
    _player = nil;
}

#pragma mark - network

-(void)requstData:(NSString*)url {
     NSLog(@"链接======%@",url);
    [[Business sharedInstance] getVideofooterRefresh:url succ:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSLog(@"%@", responseObject);
        NSArray *dataArray = responseObject[@"V9LG4B3A0"];
        for (NSDictionary *dict in dataArray) {
            [self.videoArray addObject:[DVideoItem mj_objectWithKeyValues:dict]];
        }
        [self.videoPlayerTableView reloadData];
        
        
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
    header.scrollView = self.videoPlayerTableView;
    header.delegate = self;
    // 自动进入刷新状态
    //    [header beginRefreshing];
    self.header = header;
    
    // 2.上拉刷新(上拉加载更多数据)
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.videoPlayerTableView;
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
        self.number++;
        [self requstData:videoListUrl(self.number)];
        [self.footer endRefreshing];
    } else {
        // 下拉刷新
        [self.videoArray removeAllObjects];
        self.number=1;
        [self requstData:videoListUrl(self.number)];
        [self.header endRefreshing];
    }
}
- (void)showVideoPlayer:(UITapGestureRecognizer *)tapGesture {
    [_player destroyPlayer];
    _player = nil;
    
    UIView *view = tapGesture.view;
    DVideoItem *item = self.videoArray[view.tag - 100];
    
    _indexPath = [NSIndexPath indexPathForRow:view.tag - 100 inSection:0];
    DVideoCell *cell = [self.videoPlayerTableView cellForRowAtIndexPath:_indexPath];
    
    _player = [[DVideoPlayer alloc] init];
    _player.videoUrl = item.mp4_url;
    [_player playerBindTableView:self.videoPlayerTableView currentIndexPath:_indexPath];
    _player.frame = view.bounds;
    
    [cell.contentView addSubview:_player];
    
    _player.completedPlayingBlock = ^(DVideoPlayer *player) {
        [player destroyPlayer];
        _player = nil;
    };
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DVideoCell *cell = [DVideoCell videoCellWithTableView:tableView];
    DVideoItem *item = self.videoArray[indexPath.row];
    cell.videoItem = item;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoPlayer:)];
    [cell.videoImageView addGestureRecognizer:tap];
    cell.videoImageView.tag = indexPath.row + 100;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    DVideoItem *item = self.videoArray[indexPath.row];
//    VideoDetailViewController *videoDetailViewController = [[VideoDetailViewController alloc] init];
//    videoDetailViewController.videoTitle = item.title;
//    videoDetailViewController.mp4_url = item.mp4_url;
//    [self.navigationController pushViewController:videoDetailViewController animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.videoPlayerTableView]) {
        
        [_player playerScrollIsSupportSmallWindowPlay:YES];
    }
}


#pragma mark - 设置导航栏按钮
- (void)setupNavItem
{
    //设置导航栏唤醒抽屉按钮
    MMDrawerBarButtonItem *leftItem = [MMDrawerBarButtonItem itemWithNormalIcon:@"menu" highlightedIcon:nil target:self action:@selector(leftDrawerButtonPress:)];
    [leftItem setTintColor:[UIColor blackColor]];
    
    //设置紧挨着左侧按钮的标题按钮
    MMDrawerBarButtonItem *titleItem = [MMDrawerBarButtonItem itemWithTitle:@"视频" target:nil action:nil];
    [titleItem setTintColor:[UIColor blackColor]];
    
    self.navigationItem.leftBarButtonItems = @[leftItem,titleItem];
}


- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)item
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
