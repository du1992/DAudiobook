//
//  DBaseCollectionViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "DBaseCollectionViewController.h"
#import "Macro.h"

@implementation DBaseCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
-(instancetype)init
{
    self.flowLayout=[[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.itemSize=CGSizeMake(WIDTH, 160);//item大小
    self.flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;//垂直滑动
    
    //    flowLayout.minimumLineSpacing=1;//行间距
    self.flowLayout.minimumInteritemSpacing=5;//竖间距
    self.flowLayout.sectionInset=UIEdgeInsetsMake(0.1, 0.1, 0.1, 0.1);
    return [super initWithCollectionViewLayout:self.flowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    //注册cell
    [self.collectionView registerClass:[DWallpaperCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self setupRefreshView];
    
    _page=2;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)setupRefreshView
{
    // 1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.collectionView;
    header.delegate = self;
    // 自动进入刷新状态
    //    [header beginRefreshing];
    self.header = header;
    
    // 2.上拉刷新(上拉加载更多数据)
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.collectionView;
    footer.delegate = self;
    self.footer = footer;
    
}

/**
 *  刷新控件进入开始刷新状态的时候调用
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新
        [self loadMoreData];
    } else { // 下拉刷新
        [self loadNewData];
        //结束刷新
        [self.footer endRefreshing];
    }
}



//上拉加载
-(void)loadMoreData
{
    __unsafe_unretained typeof(self) selfVC=self;
    __block NSMutableArray *mutArray=nil;
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        mutArray=[NSMutableArray array];
        NSMutableArray *array=[ToolOfPhotos photosData:selfVC.htmlUrl];
        if (array==nil) {
            
            [selfVC.footer endRefreshing];
            return ;
        }
        for (NSDictionary *dict in array) {
            DPictureModel *model=[DPictureModel setModelWithDictionary:dict];
            [mutArray addObject:model];
        }
        [selfVC.array addObjectsFromArray:mutArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _page++;
            //            [GMDCircleLoader hideFromView:self.collectionView animated:YES];
            [selfVC.collectionView reloadData];
            [selfVC.footer endRefreshing];
        });
    });
    
}

//下拉刷新
-(void)loadNewData
{
    __unsafe_unretained typeof(self) selfVC=self;
    __block NSMutableArray *mutArray=nil;
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        mutArray=[NSMutableArray array];
        NSMutableArray *array=[ToolOfPhotos photosData:selfVC.htmlUrl];
        for (NSDictionary *dict in array) {
            DPictureModel *model=[DPictureModel setModelWithDictionary:dict];
            [mutArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //获取新数据
            NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",selfVC.array];
            NSArray * theNewest = [mutArray filteredArrayUsingPredicate:filterPredicate];
            
            if (theNewest.count>0) {
                //放入当前数组中
                NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, theNewest.count)];
                [selfVC.array insertObjects:theNewest atIndexes:indexSet];
                //                [GMDCircleLoader hideFromView:self.collectionView animated:YES];
                [selfVC.collectionView reloadData];
            }
            
            [selfVC.header endRefreshing];
            
        });
    });
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.array.count==0) {
        return 20;
    }
    else{
        return _array.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DWallpaperCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (self.array.count!=0) {
        DPictureModel *model=_array[indexPath.item];
        cell.pictureModel=model;
    }
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath

{
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, 0, 0, 0, 1);//渐变
    transform = CATransform3DTranslate(transform, 0, -100, 0);//左边水平移动
    transform = CATransform3DScale(transform, 0, 0, 0);//由小变大
    cell.layer.transform = transform;
    cell.layer.opacity = 0.0;
    [UIView animateWithDuration:0.6 animations:^{
        cell.layer.transform = CATransform3DIdentity;
        cell.layer.opacity = 1;
    }];

}
//懒加载
-(NSMutableArray *)array
{
    if (_array==nil) {
        _array=[NSMutableArray array];
    }
    return _array;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DPictureViewController *pictureVC=[[DPictureViewController alloc]init];
    if (self.array.count!=0) {
        DPictureModel *model=_array[indexPath.item];
        pictureVC.pictureModel=model;
    }
    
    UINavigationController *NC=[[UINavigationController alloc]initWithRootViewController:pictureVC];
    //    NC.modalTransitionStyle=UIModalPresentationCurrentContext;
    //    NC.modalTransitionStyle=UIModalPresentationFormSheet;
    //    NC.modalTransitionStyle=UIModalPresentationCustom;
    //    NC.modalTransitionStyle=UIModalPresentationNone;
    
    [self presentViewController:NC animated:YES completion:^{
        
    }];
}
- (void)dealloc
{
    // 释放内存
    [self.header free];
    [self.footer free];
}


@end
