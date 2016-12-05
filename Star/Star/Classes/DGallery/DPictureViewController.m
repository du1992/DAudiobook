//
//  DPictureViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "DPictureViewController.h"
#import "UIImageView+WebCache.h"
#import "ToolOfPhotos.h"
#import "Macro.h"
@interface DPictureViewController ()
{
    __block NSInteger _page;
}
//当前页
@property(nonatomic,assign)NSInteger currenPage;
@property(nonatomic,strong)DPictureView *pictureView;
@end

@implementation DPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor blackColor];
    [self readSource];
    
    //    设置左按键
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backLastController)];
    self.navigationItem.leftBarButtonItem=leftButton;
    
    //设置该属性保持上下不飘
    [self.navigationController.navigationBar setTranslucent:NO];
    //    self.scrollViewTwo.contentInset=UIEdgeInsetsMake(80, 10, 300, 10);
    //    self.view.alpha=0.9;//透明度
    
    //
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//返回到上一个页面
-(void)backLastController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self.navigationController popViewControllerAnimated:YES];
}


//初始化ScrollView
-(UIScrollView *)scrollView
{
    //    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    CGRect frame=self.view.frame;
    
    if (!_scrollView ) {
        _scrollView=[[UIScrollView alloc]initWithFrame:frame];
        //活动有翻页效果
        _scrollView.pagingEnabled=YES;
        
        //
        _scrollView.directionalLockEnabled = YES;
        
        
        //设置代理
        _scrollView.delegate=self;
        
    }
    return _scrollView;
}

//读取数据
-(void)readSource
{
    
    __block DPictureViewController *selfVC=self;
   [self.view showLoadingMeg:@"🏃🏻资讯正在赶来...." time:kLogintenTime];

    NSRange range=[_pictureModel.linkUrl rangeOfString:@"1.html"];
    NSDictionary *dict=[ToolForPictureDetail everyPhoto:_pictureModel.linkUrl];
    if (dict==nil) {
        
        return;
    }
    DPictureDetailModel *model=[[DPictureDetailModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    _page=model.pageCount;
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        for ( int i=1 ; i<=model.pageCount; i++) {
            NSString *stringHTML=[_pictureModel.linkUrl stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%d.html",i]];
            NSDictionary *dic=[ToolForPictureDetail everyPhoto:stringHTML];
            
            DPictureDetailModel *detailModel=[[DPictureDetailModel alloc]init];
            [detailModel setValuesForKeysWithDictionary:dic];
            [selfVC.array addObject:detailModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [GMDCircleLoader hideFromView:self.view animated:YES];
             [self.view showLoadingMeg:@"准时赶到了✊🏻" time:kDefaultShowTime];
            [self creeateScrollViewTwo];
        });
    });
}


//懒加载
-(NSMutableArray *)array
{
    if (_array==nil) {
        _array=[NSMutableArray array];
    }
    return _array;
    
}


-(void)creeateScrollViewTwo
{
    CGRect frame=[UIScreen mainScreen].bounds;
    _scrollViewTwo=[[D3DScrollView alloc]initWithFrame:frame];
    [self.view addSubview:_scrollViewTwo];
    self.scrollViewTwo.effect = D3DScrollViewEffectDepth;
    _scrollViewTwo.showsHorizontalScrollIndicator=NO;
    self.scrollViewTwo.delegate = self;
    
    self.scrollViewTwo.effect = D3DScrollViewEffectCards;
    
    self.scrollViewTwo.delegate = self; // Use only for animate nextButton and previousButton
    
    for (int i=0; i<self.array.count; i++) {
        DPictureView *view= [self createCardWithColor];
        DPictureDetailModel *model=self.array[i];
        view.pictureDetailModel=model;
        view.alpha=0.8;
        //        view.backgroundColor=[UIColor lightGrayColor];
        
    }
    if (self.array.count>0) {
        self.navigationItem.title=[NSString stringWithFormat:@"1/%lu",_page];
    }
}


- (DPictureView *)createCardWithColor
{
    
    CGFloat width = CGRectGetWidth(self.scrollViewTwo.frame);
    CGFloat height = CGRectGetHeight(self.scrollViewTwo.frame);
    
    CGFloat x = self.scrollViewTwo.subviews.count * width;
    
    DPictureView *view = [[DPictureView alloc] initWithFrame:CGRectMake(x, 0, width, height-70)];
    
    view.layer.cornerRadius = 8.;
    view.layer.masksToBounds=YES;
    view.backgroundColor=[UIColor blackColor];
    [self.scrollViewTwo addSubview:view];
    self.scrollViewTwo.contentSize = CGSizeMake(x + width, height);
    return view;
    
}


//实现uiscrollview中协议的方法
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{//滚动开始减速
    //    NSLog(@"%s",__FUNCTION__);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{//滚动就会触发
    //    NSLog(@"%s",__FUNCTION__);
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{//滚动结束触发
    CGFloat width = CGRectGetWidth(self.scrollViewTwo.frame);
    NSInteger p=self.scrollViewTwo.contentOffset.x/width;
    self.navigationItem.title=[NSString stringWithFormat:@"%ld/%ld",p+1,_page];
    
    
    //    NSLog(@"%s",__FUNCTION__);
}
#pragma mark--与缩放相关
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{//即将缩放
    //    NSLog(@"%s",__FUNCTION__);
    
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{//正在缩放
    //    NSLog(@"%s",__FUNCTION__);
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{//缩放结束
    //    NSLog(@"%s",__FUNCTION__);
    //    UIImageView *imageView=(UIImageView *)[self.view viewWithTag:101];
    //    if (scrollView.zoomScale<1.0) {//如果缩放
    //        imageView.center=CGPointMake(scrollView.bounds.size.width/2, scrollView.bounds.size.height/2);    }
    
    
    
}

@end
