//
//  DiscussViewController.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/27.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DiscussViewController.h"
#import "DAlbumViewController.h"
#import "DRadioModel.h"
#import "DRadioListCell.h"
#import "GDTNativeExpressAd.h"
#import "GDTNativeExpressAdView.h"


@interface DiscussViewController ()<GDTNativeExpressAdDelegete>

// 用于请求原生模板广告，注意：不要在广告打开期间释放！
@property (nonatomic, retain)   GDTNativeExpressAd *nativeExpressAd;
// 存储返回的GDTNativeExpressAdView
@property (nonatomic, retain)       NSArray *expressAdViews;
// 当前展示模板广告的View（开发者可以自己设置）
@property (strong, nonatomic)  UIView *expressAdView;

@end

@implementation DiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
     self.title=@"收藏";
     [self addBackItem];
     [self onHeaderRefreshing];
    
     //拉取自定义广告
    [self  GDTadvertising];
}


#pragma mark - 共享方法
//数据处理
-(void)dataProcessingIsRemove:(BOOL)isRemove input:(id)input{
    if (isRemove) {
        [self.listArray removeAllObjects];
    }
  [self.listArray addObjectsFromArray:[DRadioModel mj_objectArrayWithKeyValuesArray:DUserDefaultsGET(kDiscuss)]];
    [self.tableView  reloadData];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DRadioListCell *cell = [DRadioListCell cellWithTableView:tableView];
    DRadioModel *model = self.listArray[indexPath.row];
    [cell setData:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DRadioModel *model = self.listArray[indexPath.row];
    DAlbumViewController *VC = [[DAlbumViewController alloc] init];
    VC.model=model;
    [self.navigationController pushViewController:VC animated:YES];
    
}



-(void)GDTadvertising{
    self.expressAdView=[[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-90, kScreenHeight-90, 80, 80)];
    [self.view addSubview:self.expressAdView];
    self.expressAdView.backgroundColor=[UIColor yellowColor];
    
    self.nativeExpressAd = [[GDTNativeExpressAd alloc] initWithAppkey:GDTAppkey placementId:GDTPlacementIdY adSize:CGSizeMake(80, 80)];
    self.nativeExpressAd.delegate = self;
    [self.nativeExpressAd loadAd:5];
}

/**
 * 拉取广告成功的回调
 */
- (void)nativeExpressAdSuccessToLoad:(GDTNativeExpressAd *)nativeExpressAd views:(NSArray<__kindof GDTNativeExpressAdView *> *)views
{
    [self.expressAdViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GDTNativeExpressAdView *adView = (GDTNativeExpressAdView *)obj;
        [adView removeFromSuperview];
    }];
    
    self.expressAdViews = [NSArray arrayWithArray:views];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
    
    //vc = [self navigationController];
#pragma clang diagnostic pop
    
    if (self.expressAdViews.count) {
        
        // 取一个GDTNativeExpressAdView
        GDTNativeExpressAdView *expressView =  [self.expressAdViews objectAtIndex:0];
        // 设置frame，开发者自己设置
        expressView.frame = CGRectMake(0, 0, 80, 80);
        expressView.controller = self;
        
        [expressView render];
        
        //添加View的时机，开发者控制
        [self.expressAdView addSubview:expressView];
        
    }
    
}

/**
 * 拉取广告失败的回调
 */
- (void)nativeExpressAdFailToLoad:(GDTNativeExpressAd *)nativeExpressAd error:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
}
/**
 * 拉取广告失败的回调
 */
- (void)nativeExpressAdRenderFail:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressAdViewRenderSuccess:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressAdViewClicked:(GDTNativeExpressAdView *)nativeExpressAdView
{
    NSLog(@"%s",__FUNCTION__);
}
@end
