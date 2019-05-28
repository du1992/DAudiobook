//
//  DPictureViewController.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/18.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DPictureViewController.h"
#import "DPictureModel.h"
#import "DPictureCell.h"

#pragma mark - 照片控制器
@interface DPictureViewController ()

@property(nonatomic,strong)  UIButton     *shutDownButton;

@end

@implementation DPictureViewController
//隐藏导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
//显示导航栏
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"照片";
    [self setUpSubviews];
     self.shutDownButton.frame=CGRectMake(10,(IS_iPhoneX ? kScreenHeight-120 :kScreenHeight-100) , 55, 55);
    
    
}

-(void)setUpSubviews
{
    
    
    DAllViewController *allVC=[[DAllViewController alloc]init];
    allVC.title=@"全部";
    
    
    DSexyViewController *sexyVC=[[DSexyViewController alloc]init];
    sexyVC.title=@"性感";
    
    
    DPlumpViewController *plumpVC=[[DPlumpViewController alloc]init];
    plumpVC.title=@"丰满";
    
    
    DSilkStockingsViewController *silkStockingsVC=[[DSilkStockingsViewController alloc]init];
    silkStockingsVC.title=@"丝袜";
    
    DLegViewController *legVC=[[DLegViewController alloc]init];
    legVC.title=@"美腿";
    
    DSportViewController *sportVC=[[DSportViewController alloc]init];
    sportVC.title=@"清新";
    
    
   
    //把控制视图添加到容器视图控制器上
    DContainerViewController *containerVC = [[DContainerViewController alloc]initWithControllers:@[allVC,sexyVC,plumpVC,silkStockingsVC,legVC ,sportVC] topBarHeight:20   parentViewController:self];
    containerVC.delegate = self;
    [self.view addSubview:containerVC.view];
}

#pragma mark -- ContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    //让view要出现时开始加载数据
    [controller viewWillAppear:YES];
}
/// 悬浮关闭按钮
- (UIButton *)shutDownButton{
    if (!_shutDownButton) {
        _shutDownButton = [[UIButton alloc]init];
        [_shutDownButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [_shutDownButton setImage:ImageNamed(@"关闭") forState:0];
        [self.view addSubview:_shutDownButton];
    }
    return _shutDownButton;
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
 
}
@end



#pragma mark - 全部照片
@implementation DAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self onHeaderRefreshing];
    [self GDTadvertising];
}
#pragma mark - 共享方法
//数据处理
-(void)dataProcessingIsRemove:(BOOL)isRemove input:(id)input{
    if (isRemove) {
        [self.listArray removeAllObjects];
    }
    [self.listArray addObjectsFromArray:[DPictureModel mj_objectArrayWithKeyValuesArray:input]];
    [self.tableView  reloadData];
    
}
//获取参数
-(NSMutableDictionary *)getJSON{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[self.pageModel pageOutput]];
    [dic setObject:@"1" forKey:@"type"];
    return dic;
}
//获取URL
-(NSString *)getURL{
    return AllUrl;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPictureModel *model = self.listArray[indexPath.row];
    if (model.cellHeight) {
        return model.cellHeight;
    }
    return 120;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DPictureCell *cell = [DPictureCell cellWithTableView:tableView];
    DPictureModel *model = self.listArray[indexPath.row];
    [cell setData:model];
        WEAKSELF
    [cell.dynamicImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!model.cellHeight) {
                [model calculateHeight:image];
                weakSelf.listArray[indexPath.row]=model;
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
    }];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DPictureModel *model = self.listArray[indexPath.row];
    DPictureCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    LBPhotoWebItem *item = [[LBPhotoWebItem alloc]initWithURLString:model.image_url frame:cell.dynamicImageView.frame];
   [LBPhotoBrowserManager.defaultManager showImageWithWebItems:@[item] selectedIndex:0 fromImageViewSuperView:cell].lowGifMemory = YES ;
    
}

@end



#pragma mark - 性感照片
@implementation DSexyViewController
//获取URL
-(NSString *)getURL{
    return SexyUrl;
}
@end


#pragma mark - 丰满照片
@implementation DPlumpViewController
//获取URL
-(NSString *)getURL{
    return SexyUrl;
}
@end

#pragma mark - 丝袜照片
@implementation DSilkStockingsViewController
//获取URL
-(NSString *)getURL{
    return SilkStockingsUrl;
}
@end

#pragma mark - 美腿照片
@implementation DLegViewController
//获取URL
-(NSString *)getURL{
    return LegUrl;
}
@end

#pragma mark - 清新照片
@implementation DSportViewController
//获取URL
-(NSString *)getURL{
    return SportUrl;
}
@end
