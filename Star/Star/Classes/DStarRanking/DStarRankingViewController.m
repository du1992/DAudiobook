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







@end
