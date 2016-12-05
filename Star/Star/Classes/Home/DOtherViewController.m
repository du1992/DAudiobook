//
//  DOtherViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "DOtherViewController.h"

@interface DOtherViewController ()

@end

@implementation DOtherViewController

-(void)viewFirstLoad{
   
    [self  isUrlStrin];
    [self viewFirstLoadWithURL:self.urlString];
    if (self.tableView.visibleCells.count>0) {
//        [GMDCircleLoader hideFromView:self.view animated:YES];
    }
    
}

-(void)loadNewData{
    self.htmlUrl=self.urlString;
    [super loadNewData];
}
#pragma mark 上拉刷新
-(void)loadMoreData{
    self.htmlUrl=[NSString stringWithFormat:@"%@index_%lu.html",self.urlString,(unsigned long)_page];
    [super loadMoreData];
    
}
-(void)isUrlStrin{
    if ([self.title isEqualToString:@"爆料"]) {
         self.urlString=kGossipUrl;
    }else if ([self.title isEqualToString:@"秘闻"]) {
         self.urlString=kSecretsUrl;
    }else if ([self.title isEqualToString:@"八卦"]) {
          self.urlString=kPeachUrl;
    }else if ([self.title isEqualToString:@"娱乐"]) {
         self.urlString=kCarnetioUrl;
    }else if ([self.title isEqualToString:@"黑色"]) {
         self.urlString=kBlackUrl;
    }
}
-(void)viewDidAppear:(BOOL)animated{
}
@end
