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
#import "DJokesViewController.h"
#import "DPictureViewController.h"
#import "DVideoPlayerViewController.h"
#import "DPostViewController.h"
#import "DShareView.h"
#import "DiscussViewController.h"


@interface DMeViewController ()
@property(nonatomic, strong) DShareView        *shareView;
@property(nonatomic, strong) BAGridView        *gridView;
@property(nonatomic, strong) BAGridView_Config *ba_GridViewConfig;
@property(nonatomic, strong) NSMutableArray  <BAGridItemModel *> *gridDataArray;


@property (nonatomic, strong) UIView           *tableHeaderView;
@end

@implementation DMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的";
    [self addBackItem];
    
    self.shareView=[[DShareView alloc]initWithFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight)];
    [self.view addSubview:self.shareView];
  
}
-(void)backAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//区头
-(void)initializeTableHeaderView{
   self.tableView.tableHeaderView = self.tableHeaderView;
    
}
//区尾
- (void)initializeTableFooterView
{
    WEAKSELF
    self.gridView = [BAGridView ba_creatGridViewWithGridViewConfig:self.ba_GridViewConfig block:^(BAGridItemModel *model, NSIndexPath *indexPath) {
        [weakSelf didSelectRowAtIndexPath:indexPath];
    }];
    self.gridView.frame=CGRectMake(0, 0,kScreenWidth, kScreenHeight/4*3);
    self.tableView.tableFooterView = self.gridView;
}
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     switch (indexPath.row) {
            
        
         case 0:
         {
             //段子
             DJokesViewController *VC = [[DJokesViewController alloc] init];
             [self.navigationController pushViewController:VC animated:YES];
         }
        break;
            
         case 1:
         {
             //图片
             DPictureViewController *VC = [[DPictureViewController alloc] init];
             [self.navigationController pushViewController:VC animated:YES];
         }
         break;
            
         case 2:
         {
             //视频
             DVideoPlayerViewController *VC = [[DVideoPlayerViewController alloc] init];
             [self.navigationController pushViewController:VC animated:YES];
         }
             break;
             
         
         case 3:
         {
             //论坛
             DPostViewController *VC = [[DPostViewController alloc] init];
             [self.navigationController pushViewController:VC animated:YES];
         }
             break;
         
         case 4:
         {
             //分享
             [self.shareView show];
             
        }
             break;
             
         case 5:
         {
             //收藏
             DiscussViewController *VC = [[DiscussViewController alloc] init];
             [self.navigationController pushViewController:VC animated:YES];
         }
             break;
             
            
        default:
            break;
            
    }
    
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
        _ba_GridViewConfig.scrollEnabled = YES;
        // 是否显示分割线
        _ba_GridViewConfig.showLineView = YES;
        // item：分割线颜色，默认：BAKit_Color_Gray_11【BAKit_Color_RGB(248, 248, 248)】
        _ba_GridViewConfig.ba_gridView_lineColor = BAKit_Color_Gray_10_pod;
        // item：每行 item 的个数，默认为4个
        _ba_GridViewConfig.ba_gridView_rowCount = 3;
        // item：高度/宽度
        _ba_GridViewConfig.ba_gridView_itemHeight = kScreenHeight/4;
        
        _ba_GridViewConfig.ba_gridView_itemImageInset = 5;
        //  item：title 颜色，默认：BAKit_Color_Black【[UIColor blackColor]】
        //            self.ba_GridViewConfig.ba_gridView_titleColor = BAKit_Color_Black;
        // item：title Font，默认：图文样式下 16，两行文字下（上25，下12）
        _ba_GridViewConfig.ba_gridView_titleFont = [UIFont boldSystemFontOfSize:15];
        // item：背景颜色，默认：BAKit_Color_White
        _ba_GridViewConfig.ba_gridView_backgroundColor = [UIColor whiteColor];
        // item：背景选中颜色，默认：无色
        _ba_GridViewConfig.ba_gridView_selectedBackgroundColor = BAKit_Color_Red_pod;
        _ba_GridViewConfig.dataArray = self.gridDataArray;
    }
    return _ba_GridViewConfig;
}

- (NSMutableArray <BAGridItemModel *> *)gridDataArray
{
    if (!_gridDataArray)
    {
        _gridDataArray = @[].mutableCopy;
        
        NSArray*titleArray=@[@"开心段子",@"图片写真",@"影视视频",@"论坛讨论",@"分享好友",@"我的收藏"];
        
        for (int i=0; i<titleArray.count; i++) {
            BAGridItemModel *model = [BAGridItemModel new];
            model.titleString = titleArray[i];
            model.imageName   = titleArray[i];
            [_gridDataArray addObject:model];
            
        }
    }
    return _gridDataArray;
}
@end
