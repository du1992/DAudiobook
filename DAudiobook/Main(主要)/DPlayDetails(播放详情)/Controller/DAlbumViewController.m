//
//  DAlbumViewController.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/26.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DAlbumViewController.h"
#import "DAlbumViewCell.h"
#import "DAlbumHeadView.h"
#import "DSongModel.h"
#import "DMusicDetailVIewController.h"
#import "DPostViewController.h"
#import "DShareView.h"

@interface DAlbumViewController ()

@property(nonatomic,strong)  DAlbumHeadView    *albumHeadView;
@property(nonatomic, strong) DShareView        *shareView;
@property(nonatomic,strong)  NSMutableArray    *discussArray;

@property(nonatomic,strong)  UIButton*collectionButton;
@end

@implementation DAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackItem];
    [self onHeaderRefreshing];
    
     [self addRightBarButtonItem:[[UIImage imageNamed:@"更多"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    id input =DUserDefaultsGET(kDiscuss);
    self.discussArray=[DRadioModel mj_objectArrayWithKeyValuesArray:input];
    if (!self.discussArray) {
        self.discussArray=[NSMutableArray array];
    }
    DRadioModel *obj=[self.model isEqualRadioModel:self.discussArray];
    if (obj) {
        [self.collectionButton setTitle:@"已收藏" forState:0];
    }
    self.shareView=[[DShareView alloc]initWithFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight)];
    [self.view addSubview:self.shareView];
}
//分享
-(void)rightItemClick{
     [self.shareView show];
    
}
//区头
-(void)initializeTableHeaderView{
    self.albumHeadView=[[DAlbumHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    self.tableView.tableHeaderView = self.albumHeadView;
    [self.albumHeadView setData:self.model];
    
}
//区尾
- (void)initializeTableFooterView
{
    //收藏
    UIButton*collectionButton=[self getBottomButton:[UIColor blackColor] frame:CGRectMake(0, kScreenHeight-40, kScreenWidth/2, 40) image:ImageNamed(@"收藏到歌单") title:@"收藏"];
    [self.view addSubview:collectionButton];
    [collectionButton addTarget:self action:@selector(collectionClick) forControlEvents:UIControlEventTouchUpInside];
    self.collectionButton=collectionButton;
    
   
    
    //讨论
    UIButton*discussButton=[self getBottomButton:AppColor(225,89, 81) frame:CGRectMake(kScreenWidth/2, kScreenHeight-40, kScreenWidth/2, 40) image:ImageNamed(@"评论") title:@"讨论"];
    [self.view addSubview:discussButton];
    [discussButton addTarget:self action:@selector(discussClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel*discussLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-40, 5,40, 20)];
    discussLabel.text   =@"99+";
    discussLabel.font   = AppFont(12);
    discussLabel.textColor=[UIColor whiteColor];
    [discussButton addSubview:discussLabel];
    
}
//收藏
-(void)collectionClick{
    DRadioModel *obj=[self.model isEqualRadioModel:self.discussArray];
    if (obj) {
       [self.discussArray removeObject:obj];
        id input=[DRadioModel mj_keyValuesArrayWithObjectArray:self.discussArray];
        DUserDefaultsSET(input,kDiscuss);
        [self.collectionButton setTitle:@"收藏" forState:0];
    }else{
        [self.discussArray addObject:self.model];
        id input=[DRadioModel mj_keyValuesArrayWithObjectArray:self.discussArray];
        DUserDefaultsSET(input,kDiscuss);
        [self.collectionButton setTitle:@"已收藏" forState:0];
    }
}
//讨论
-(void)discussClick{
    DPostViewController *VC = [[DPostViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

-(UIButton*)getBottomButton:(UIColor*)backgroundColor frame:(CGRect)frame image:(UIImage*)image title:(NSString*)title{
    UIButton*button         = [[UIButton alloc]init];
    button.backgroundColor  = backgroundColor;
    button.titleLabel.font  = AppFont(15);
    [button.imageView setContentMode:UIViewContentModeScaleAspectFill];
    button.frame=frame;
    [button setImage:image forState:0];
    [button setTitle:title forState:0];
    return button;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DAlbumViewCell *cell = [DAlbumViewCell cellWithTableView:tableView];
    DSongModel *model = self.listArray[indexPath.row];
    [cell setData:model];
    return cell;
}


#pragma mark - 表格代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [DPlayerManager defaultManager].musicArray = self.listArray;
    [DPlayerManager defaultManager].index = indexPath.row;
    [[DPlayerManager defaultManager] reloadDataWithIndex:indexPath.row];
    DMusicDetailVIewController*VC=[[DMusicDetailVIewController alloc]init];
    [self presentDropsWaterViewController:VC];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView*topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth,40)];
    UIView*lineView=[[UIView alloc]initWithFrame:CGRectMake(0,39.5,kScreenWidth, 0.5)];
    lineView.backgroundColor=UIColorFromRGBValue(0xe4e3e3);
    [topView addSubview:lineView];
    topView.backgroundColor=[UIColor whiteColor];
    UILabel*readingLabel = [[UILabel alloc]init];
    [topView addSubview:readingLabel];
    readingLabel.font = AppFont(14);
    [readingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.mas_left).offset(15);
        make.centerY.mas_equalTo(topView.mas_centerY).offset(-1);
    }];
    
    readingLabel.textColor=UIColorFromRGBValue(0x4e4d4d);
    readingLabel.text  =@"目录";
    
    
    return topView;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}

#pragma mark - 共享方法
//数据处理
-(void)dataProcessingIsRemove:(BOOL)isRemove input:(id)input{
    if (isRemove) {
        [self.listArray removeAllObjects];
    }
    [self.listArray addObjectsFromArray:[DSongModel mj_objectArrayWithKeyValuesArray:input]];
    [self.tableView  reloadData];
    
}
//获取URL
-(NSString *)getURL{
    return iString(self.model.albumId);
}

@end
