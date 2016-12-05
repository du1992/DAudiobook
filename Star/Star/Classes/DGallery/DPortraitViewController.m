//
//  DPortraitViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//


#import "DPortraitViewController.h"

@interface DPortraitViewController ()

@end

@implementation DPortraitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  isUrlStrin];
    [self  viewFirstLoad];
    [self  loadNewData];
}

-(void)viewFirstLoad
{
    self.array=nil;
    [self readSource];
}

-(void)readSource
{
    
    //在全局队列中处理数据
    //    [GMDCircleLoader setOnView:self.collectionView withTitle:@"" animated:YES];
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSMutableArray *array=[ToolOfPhotos photosData:self.urlString];
        if (array==nil) {
            return ;
        }
        else{
            for (NSDictionary *dict in array) {
                [self.array addObject:[DPictureModel setModelWithDictionary:dict]];
            };
            dispatch_async(dispatch_get_main_queue(), ^{
                //  [GMDCircleLoader hideFromView:self.collectionView animated:YES];
                [self.collectionView reloadData];
            });
            
        }
        
    });
    
}

-(void)loadMoreData
{
    self.htmlUrl=[NSString stringWithFormat:@"%@index_%ld.html",PortraitUrl,_page];
    [super loadMoreData];
}

-(void)loadNewData
{

    self.htmlUrl=[NSString stringWithFormat:@"%@index_2.html",self.urlString];
    [super loadNewData];
    
}
-(void)isUrlStrin{
    if ([self.title isEqualToString:@"写真"]) {
        self.urlString=WallpaperUrl;
    }else if ([self.title isEqualToString:@"现场"]) {
        self.urlString=SceneUrl;
    }else if ([self.title isEqualToString:@"剧照"]) {
        self.urlString=StillsUrl;
    }else if ([self.title isEqualToString:@"壁纸"]) {
        self.urlString=PortraitUrl;
    }
    
}

@end
