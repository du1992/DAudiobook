//
//  DLeftMenuViewController.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/20.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DLeftMenuViewController.h"
#import "DMenuModel.h"
#import "DSideMenuTableViewCell.h"
#import "DAllControllersTool.h"
#import "DMenuHeadView.h"
#import "DPlayMusicView.h"
#import "DMeViewController.h"
#import "DNavigationController.h"
#import "DMusicDetailVIewController.h"

@interface DLeftMenuViewController ()

@property (nonatomic,strong) DMenuHeadView  *menuHeadView;
@property (nonatomic,strong) DPlayMusicView *playMusicView;

@end

@implementation DLeftMenuViewController
- (void)viewDidAppear:(BOOL)animated {
    [self.menuHeadView.timer fire];
    [self.menuHeadView refreshvView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.menuHeadView.timer invalidate];
    self.menuHeadView.timer = nil;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.top =-MenuHeadViewTopDistance;
    [self.tableView setContentInset:contentInset];
}

-(void)initializeData{
    
    [self.listArray  addObjectsFromArray:[DMenuModel getMenuModeldataArry]];
    [self.tableView  reloadData];
    
}
//区头
-(void)initializeTableHeaderView{
     self.menuHeadView.frame=CGRectMake(0, 0, kScreenWidth,200+MenuHeadViewTopDistance);
     self.tableView.tableHeaderView = self.menuHeadView;
     WEAKSELF
     self.menuHeadView.headerViewBlock = ^{
        DMeViewController *VC = [[DMeViewController alloc] init];
        DNavigationController*NVC = [[DNavigationController alloc] initWithRootViewController:VC];
        [weakSelf presentDropsWaterViewController:NVC];
       };
}
//区尾
- (void)initializeTableFooterView
{
    //设置尾部播放音乐视图
    [self.playMusicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(60);
    }];
    
    WEAKSELF
    self.playMusicView.bottomMusicBlock = ^(void) {
        if ([DPlayerManager defaultManager].musicArray.count) {
            DMusicDetailVIewController*VC=[[DMusicDetailVIewController alloc]init];
            [weakSelf presentDropsWaterViewController:VC];
        }else{
             [weakSelf.view showLoadingMeg:@"未选择音乐" time:kDefaultShowTime];
        }
    };
  
    
}
//加载刷新控件
-(void)initializeRefresh{

}
- (void)setupNavItem
{
}

#pragma mark  - UITableViewDelegate-回调
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DSideMenuTableViewCell *cell = [DSideMenuTableViewCell cellWithTableView:tableView];
    DMenuModel *model = self.listArray[indexPath.row];
    [cell setData:model];
    return cell;
}
 //点击对应的cell切换对应的视图控制器
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DMenuModel *model = self.listArray[indexPath.row];
    [DAllControllersTool createViewControllerWithIndex:model];
    
}

#pragma mark - 懒加载
- (DMenuHeadView *)menuHeadView
{
    if (!_menuHeadView) {
        _menuHeadView = [[DMenuHeadView alloc] init];
        [self.view addSubview:_menuHeadView];
    }
    return _menuHeadView;
}
- (DPlayMusicView *)playMusicView
{
    if (!_playMusicView) {
        _playMusicView= [[DPlayMusicView alloc]init];
         [self.view addSubview:_playMusicView];
    }
    return _playMusicView;
}


@end
