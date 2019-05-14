//
//  DMeViewController.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/12.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DMeViewController.h"
#import "BAKit_BAGridView.h"
#import "BAGridView_Config.h"
#import "YLImageView.h"
#import "YLGIFImage.h"

@interface DMeViewController ()

@property(nonatomic, strong) BAGridView        *gridView;
@property(nonatomic, strong) BAGridView_Config *ba_GridViewConfig;
@property(nonatomic, strong) NSMutableArray  <BAGridItemModel *> *gridDataArray;


@property (nonatomic, strong) UIView           *tableHeaderView;
@end

@implementation DMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedBack:)];
}

-(void)didClickedBack:(UIBarButtonItem *)item{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//区头
-(void)initializeTableHeaderView{
   self.tableView.tableHeaderView = self.tableHeaderView;
    
}
//区尾
- (void)initializeTableFooterView
{
   self.tableView.tableFooterView = self.gridView;
    
}

- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 130)];
        YLImageView*imageViewbackground = [[YLImageView alloc]init];
        imageViewbackground.contentMode=UIViewContentModeScaleAspectFill;
        imageViewbackground.clipsToBounds = YES;
        imageViewbackground.image=[YLGIFImage imageNamed:@"个人页面动态图.gif"];
        [_tableHeaderView addSubview:imageViewbackground];
        imageViewbackground.frame=CGRectMake(0, 0, kScreenWidth, 130);
    }
    return _tableHeaderView;
}
- (BAGridView_Config *)ba_GridViewConfig {
    if (!_ba_GridViewConfig) {
        _ba_GridViewConfig = [[BAGridView_Config alloc] init];
        _ba_GridViewConfig.gridViewType = BAGridViewTypeImageTitle;
    }
    return _ba_GridViewConfig;
}

- (BAGridView *)gridView
{
    if (!_gridView)
    {
        self.ba_GridViewConfig.scrollEnabled = YES;
        // 是否显示分割线
        self.ba_GridViewConfig.showLineView = YES;
        // item：分割线颜色，默认：BAKit_Color_Gray_11【BAKit_Color_RGB(248, 248, 248)】
        self.ba_GridViewConfig.ba_gridView_lineColor = BAKit_Color_Gray_10_pod;
        // item：每行 item 的个数，默认为4个
        self.ba_GridViewConfig.ba_gridView_rowCount = 3;
        // item：高度/宽度
        self.ba_GridViewConfig.ba_gridView_itemHeight = kScreenHeight/4;
        //        self.ba_GridViewConfig.ba_gridView_itemWidth = kGridView_itemWidth;
        
        // item：图片与文字间距（或者两行文字类型的间距），默认：0
        self.ba_GridViewConfig.ba_gridView_itemImageInset = 5;
        //  item：title 颜色，默认：BAKit_Color_Black【[UIColor blackColor]】
        //            self.ba_GridViewConfig.ba_gridView_titleColor = BAKit_Color_Black;
        // item：title Font，默认：图文样式下 16，两行文字下（上25，下12）
        self.ba_GridViewConfig.ba_gridView_titleFont = [UIFont boldSystemFontOfSize:15];
        // item：背景颜色，默认：BAKit_Color_White
        self.ba_GridViewConfig.ba_gridView_backgroundColor = [UIColor whiteColor];
        // item：背景选中颜色，默认：无色
        self.ba_GridViewConfig.ba_gridView_selectedBackgroundColor = BAKit_Color_Red_pod;
        self.ba_GridViewConfig.dataArray = self.gridDataArray;
        //        self.ba_GridViewConfig.ba_gridView_itemEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        //        self.ba_GridViewConfig.minimumLineSpacing = 10;
        //        self.ba_GridViewConfig.minimumInteritemSpacing = 10;
        
        WEAKSELF
        _gridView = [BAGridView ba_creatGridViewWithGridViewConfig:self.ba_GridViewConfig block:^(BAGridItemModel *model, NSIndexPath *indexPath) {
           
        }];
        _gridView.frame=CGRectMake(0, 0,kScreenWidth, kScreenHeight/4*3);
    }
    return _gridView;
}
- (NSMutableArray <BAGridItemModel *> *)gridDataArray
{
    if (!_gridDataArray)
    {
        _gridDataArray = @[].mutableCopy;
        
        BAGridItemModel *modelA = [BAGridItemModel new];
        modelA.titleString = @"开心段子";
        modelA.imageName = @"开心段子";
        [_gridDataArray addObject:modelA];
        
        
        BAGridItemModel *modelB = [BAGridItemModel new];
        modelB.titleString = @"图片写真";
        modelB.imageName = @"图片写真";
        [_gridDataArray addObject:modelB];
        
        
        BAGridItemModel *modelCC = [BAGridItemModel new];
        modelCC.titleString = @"影视视频";
        modelCC.imageName = @"影视视频";
        [_gridDataArray addObject:modelCC];
        
        
        BAGridItemModel *modelC = [BAGridItemModel new];
        modelC.titleString = @"本地下载";
        modelC.imageName = @"本地下载";
        [_gridDataArray addObject:modelC];
        
        
        BAGridItemModel *modelD = [BAGridItemModel new];
        modelD.titleString = @"意见反馈";
        modelD.imageName = @"意见反馈";
        [_gridDataArray addObject:modelD];
        
        
        //        BAGridItemModel *modelE = [BAGridItemModel new];
        //        modelE.titleString = @"用户协议";
        //        modelE.imageName = @"";
        //        [_gridDataArray addObject:modelE];
        
        BAGridItemModel *modelF = [BAGridItemModel new];
        modelF.titleString = @"评价我们";
        modelF.imageName = @"好评奖励";
        [_gridDataArray addObject:modelF];
        
        BAGridItemModel *modelT = [BAGridItemModel new];
        modelT.titleString = @"分享好友";
        modelT.imageName = @"分享好友";
        [_gridDataArray addObject:modelT];
        
        //        BAGridItemModel *modelQ = [BAGridItemModel new];
        //        modelQ.titleString = @"我的收藏";
        //        modelQ.imageName = @"我的收藏";
        //        [_gridDataArray addObject:modelQ];
        
        //        BAGridItemModel *modelU = [BAGridItemModel new];
        //        modelU.titleString = @"回复交流";
        //        modelU.imageName = @"回复交流";
        //        [_gridDataArray addObject:modelU];
        
        
    }
    return _gridDataArray;
}
@end
