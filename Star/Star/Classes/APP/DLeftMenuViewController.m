//
//  DLeftMenuViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/1/30.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "DLeftMenuViewController.h"
#import "DSideMenuTableViewCell.h"
#import "DHeadView.h"
#import "DPlayMusicView.h"
#import "DAllControllersTool.h"
#import "Macro.h"
#import "DRadioThirdViewController.h"
#import "DNavigationController.h"
#import "DAppStore.h"
@interface DLeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>

/**
 *  UITableView
 */
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArray;

/**
 *  Cell上的图片数组
 */
@property (nonatomic,strong) NSArray *cellImages;
@property (nonatomic,strong) DHeadView *headView;
@property (nonatomic,strong) DPlayMusicView *playMusicView;


@end

@implementation DLeftMenuViewController

#pragma mark -
#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView selectRowAtIndexPath:indexpath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    return _tableView;
}

- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [[NSArray alloc] init];
    }
    return _titleArray;
}

- (NSArray *)cellImages
{
    if (!_cellImages) {
        _cellImages = [[NSArray alloc] init];
    }
    return _cellImages;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    self.titleArray = @[@"视频",@"资讯",@"排行",@"写真",@"电台",@"设置"];
    
    self.cellImages = @[@"视频",@"qfile_mpfile_menu_icon8",@"qrcode_scan_btn_olympic_down",@"qfile_mpfile_menu_icon4",@"qfile_mpfile_menu_icon7",@"tab_buddy_press"];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = RGB(255, 255, 255);
    [self.view addSubview:self.tableView];
    
    //设置头部视图
    DHeadView *headerView = [[DHeadView alloc] init];
    [headerView setBackgroundColor:RGB(255, 255, 255)];
    

    
    [self.view addSubview:headerView];
    self.headView = headerView;
    
    //设置尾部播放音乐视图
    DPlayMusicView *playMusic = [[DPlayMusicView alloc] init];
    playMusic.backgroundColor = RGB(38 , 184, 242);
    [self.view addSubview:playMusic];
    self.playMusicView = playMusic;
    __weak typeof(self)vc = self;
    self.playMusicView.block = ^(DRadioSecondListModel *listModel){
        DRadioThirdViewController *thirdVC = [[DRadioThirdViewController alloc] init];
       DNavigationController*navVC = [[DNavigationController alloc] initWithRootViewController:thirdVC];
        [thirdVC passModel:listModel andName:@""];
        [vc presentViewController:navVC animated:YES completion:nil];
    };
    
    //自动适配
    [self setupConstrain];
}


#pragma mark -
#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DSideMenuTableViewCell *cell = [DSideMenuTableViewCell cellWith:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title = self.titleArray[indexPath.row];
    cell.iconImage = self.cellImages[indexPath.row];

    return cell;
}


#pragma mark -
#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击对应的cell切换对应的视图控制器
    [DAllControllersTool createViewControllerWithIndex:indexPath.row];
    
    
}


#pragma mark -
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}


#pragma mark -
#pragma mark -添加（自动适配）约束
- (void)setupConstrain
{
    __weak typeof(self)vc = self;
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(vc.view.mas_top);
        make.left.equalTo(vc.view.mas_left);
        make.right.equalTo(vc.view.mas_right);
        make.height.mas_equalTo(220);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(vc.headView.mas_bottom);
        make.left.equalTo(vc.view.mas_left);
        make.right.equalTo(vc.view.mas_right);
        make.bottom.equalTo(vc.playMusicView.mas_top);
    }];
    
    [self.playMusicView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(vc.view.mas_left);
        make.right.equalTo(vc.view.mas_right);
        make.bottom.equalTo(vc.view.mas_bottom);
        make.height.mas_equalTo(HEIGHT * 0.1);
    }];
    
}
/**
 * 更改状态栏颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated {
    [self.headView.timer fire];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    BOOL hasin = [defaults boolForKey:@"first"];
    if (!hasin) {
        [defaults setBool:YES forKey:@"first"];
    }else{
        //用户好评系统
        DAppStore *toAppStore = [[DAppStore alloc]init];
        toAppStore.myAppID = @"1182862136";
        [toAppStore showGotoAppStore:self];
    }
    
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.headView.timer invalidate];
    self.headView.timer = nil;
    NSLog(@"%@",@"定时器销毁");
}
@end
