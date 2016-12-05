//
//  StarInfoViewController.m
//  Star
//
//  Created by JUNE_EN on 15/6/1.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "StarInfoViewController.h"
#import "StarInfoTool.h"
#import "StarSelfInfoTool.h"
#import "UIViewController+ZN.h"
#import "StarInfo.h"
#import "NSString+Extension.h"
#import "StarInfoCell.h"
#import "StarSelfInfo.h"
#import "StarInfoHeaderView.h"
#import "StarDetailViewController.h"
#import "DNavigationController.h"
#import "UIImageView+WebCache.h"
#define kDetailLabelFont [UIFont systemFontOfSize:12]
@interface StarInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)__block NSMutableArray *starInfoData;

@property (weak, nonatomic) IBOutlet StarInfoHeaderView *headerView;

@property (nonatomic,strong) StarSelfInfo *selfInfo;
@end

@implementation StarInfoViewController
-(NSMutableArray *)starInfoData{
    if (nil == _starInfoData) {
        self.starInfoData =[NSMutableArray array];
    }
    return _starInfoData;
}
- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url=[NSURL URLWithString:_ranking.imgUrl];
    _headerView.imgView.contentMode=UIViewContentModeScaleToFill;
    [self.headerView.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"StarSelf"]];
    [self.headerView.backGroundImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"StarSelf"]];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedBack:)];
    self.title=self.starName;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight=50;
    
    __unsafe_unretained typeof(self) selfVC=self;
    [self dispathLoad:^{
        NSArray *dataArray=[StarInfoTool starInfo:selfVC.linkUrl];
        NSDictionary *dict=[StarSelfInfoTool selfInfo:selfVC.linkUrl];
        self.selfInfo=[StarSelfInfo selfInfoWithDict:dict];
        
#warning 当没有返回为空时 提示错误页
        for (NSDictionary *dict in dataArray) {
            StarInfo *starInfo=[StarInfo starInfoWithDict:dict];
            [selfVC.starInfoData addObject:starInfo];
        }
    } mainQueue:^{
        self.headerView.selfInfo=_selfInfo;
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.starInfoData.count==0)return 1;
    return self.starInfoData.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%@ .最新消息",self.starName];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.starInfoData.count==0)return 40;
    StarInfo *info=self.starInfoData[indexPath.row];
    CGSize size=[[UIScreen mainScreen] bounds].size;
    CGSize detailLabelSize=[info.detail sizeWithFont:kDetailLabelFont maxSize:CGSizeMake(size.width*0.4, MAXFLOAT)];
    return detailLabelSize.height+40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StarInfoCell *cell=[StarInfoCell cellWithTableView:tableView];
    StarInfo *info=nil;
    if (self.starInfoData.count!=0) {
        info=self.starInfoData[indexPath.row];
        cell.starInfo=info;
    }else{
        cell.textLabel.text=self.starInfoData.count?@"":@"暂无数据";
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.starInfoData.count) {
        StarInfo *info=self.starInfoData[indexPath.row];
        StarDetailViewController *detail=[[StarDetailViewController alloc] init];
        DNavigationController *nav=[[DNavigationController alloc] initWithRootViewController:detail];
        detail.linkUrl=info.linkUrl;
        [self presentViewController:nav animated:YES completion:nil];
    }
}

-(void)didClickedBack:(UIBarButtonItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)didClickedNextPage:(UIBarButtonItem *)item{
    
}
@end
