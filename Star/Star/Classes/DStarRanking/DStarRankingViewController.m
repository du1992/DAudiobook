//
//  DStarRankingViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "DStarRankingViewController.h"
#import "WallpaperCell.h"
#import "Macro.h"
#import "StarRankingViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIBarButtonItem+Helper.h"
#import "UIViewController+MMDrawerController.h"

@interface DStarRankingViewController (){
    NSArray*imgarray;
}

@property(nonatomic,strong)NSMutableArray *array;

@end

@implementation DStarRankingViewController

static NSString * const reuseIdentifier = @"Cell";
-(instancetype)init
{
    self.flowLayout=[[UICollectionViewFlowLayout alloc]init];
    CGFloat width=[UIScreen mainScreen].bounds.size.width/2-16;
    self.flowLayout.itemSize=CGSizeMake(width, 250);//item大小
    self.flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;//垂直滑动
    
    //    flowLayout.minimumLineSpacing=1;//行间距
    //    flowLayout.minimumInteritemSpacing=5;//竖间距
    self.flowLayout.sectionInset=UIEdgeInsetsMake(2, 8, 5, 8);
    return [super initWithCollectionViewLayout:self.flowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.collectionView.backgroundColor = RGB(33, 158, 234);
    
    [self  setupNavItem];
    //注册cell
    [self.collectionView registerClass:[WallpaperCell class] forCellWithReuseIdentifier:reuseIdentifier];
    imgarray=[NSMutableArray arrayWithObjects:@"内地排名",@"港台排名" ,@"日韩排名",@"欧美排名",nil];
    
    
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  
        return 4;
   
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WallpaperCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imgView.image=[UIImage imageNamed:imgarray[indexPath.row]];
    cell.label.text=imgarray[indexPath.row];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    StarRankingViewController*star=[[StarRankingViewController alloc]init];
    star.title=imgarray[indexPath.row];
    [self.navigationController pushViewController:star animated:YES];
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 设置导航栏按钮
- (void)setupNavItem
{
    //设置导航栏唤醒抽屉按钮
    MMDrawerBarButtonItem *leftItem = [MMDrawerBarButtonItem itemWithNormalIcon:@"menu" highlightedIcon:nil target:self action:@selector(leftDrawerButtonPress:)];
    [leftItem setTintColor:[UIColor blackColor]];
    
    //设置紧挨着左侧按钮的标题按钮
    MMDrawerBarButtonItem *titleItem = [MMDrawerBarButtonItem itemWithTitle:@"排名" target:nil action:nil];
    [titleItem setTintColor:[UIColor blackColor]];
    
    self.navigationItem.leftBarButtonItems = @[leftItem,titleItem];
}


- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)item
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}





@end
