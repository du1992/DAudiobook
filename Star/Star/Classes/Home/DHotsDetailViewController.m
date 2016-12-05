//
//  HotsDetailViewCell.m
//  Star
//
//  Created by JUNE_EN on 15/5/30.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "DHotsDetailViewController.h"
#import "DHotsDetailTool.h"
#import "NewsDetail.h"
#import "NSString+Extension.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "UIView+MJ.h"
#import "NSMutableString+ReplaceByString.h"
#import "Macro.h"

@interface DHotsDetailViewController ()
@property (nonatomic,strong) __block NewsDetail *newsDetail;
@property (nonatomic,strong) __block UIScrollView *scrollView;
@property (nonatomic,assign) __block NSNumber *imgH;
@property (nonatomic,weak) __block UILabel *titleLabel;
@property (nonatomic,weak) __block UILabel *dateLabel;
@property (nonatomic,weak) __block UILabel *introductionLabel;
@property (nonatomic,weak) __block UIImageView *imgView;
@property (nonatomic,weak) __block UILabel *imgDesLabel;
@property (nonatomic,weak) __block UILabel *contentLabel;
@property (nonatomic,copy) NSString *originalURL;

@property (nonatomic,assign) __block int pageCount;
@property (nonatomic,assign) int number;

@end


@implementation DHotsDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidLoad{
    [self addObserver:self forKeyPath:@"imgH" options:NSKeyValueObservingOptionNew context:nil];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedBack:)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"下一页" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedNextPage:)];
    
    self.originalURL=self.linkUrl;
    CGRect screenFrame=[[UIScreen mainScreen] bounds];
    self.scrollView=[[UIScrollView alloc] initWithFrame:screenFrame];
    [self.view addSubview:_scrollView];
    [_scrollView showsVerticalScrollIndicator];
    
    [self addGesture:self.view];
    _number=1;
    _scrollView.userInteractionEnabled=YES;
    //加载网络数据
    [self loadingNetData];
    
}
//添加手势
-(void)addGesture:(UIView *)view{
    //添加向右轻扫手势
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    //添加向做手势
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    //设置轻扫的方向
    swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft; //默认向右
    
    [view addGestureRecognizer:swipeGestureRight];
    [view addGestureRecognizer:swipeGestureLeft];
}
#pragma mark 轻扫手势对应的action方法
-(void)swipeGesture:(UISwipeGestureRecognizer *)swipe{
    if (swipe.direction==UISwipeGestureRecognizerDirectionLeft) {
        [self leftSwipeGesture];
    }else{
        [self rightSwipeGesture];
    }
    
}
#pragma mark 向左侧轻扫手势
-(void)leftSwipeGesture{
    self.number++;
   NSRange range= [self.originalURL rangeOfString:@".html"];
     NSString *str=[self.originalURL stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"_%d.html",_number]];
    self.linkUrl=str;
    
     __unsafe_unretained typeof(self) selfVC=self;
   
    dispatch_async(dispatch_get_global_queue(0.0, 0.0), ^{
        NSDictionary *dict=[DHotsDetailTool detailData:selfVC.linkUrl];
        if (nil == dict){
            self.number--;
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            __block float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
            __block float navigationHeight = self.navigationController.navigationBar.frame.size.height;
            CGSize size=[[UIScreen mainScreen] bounds].size;
            
            __block UIScrollView *view =[[UIScrollView alloc] initWithFrame:CGRectMake(size.width, statusHeight+navigationHeight, size.width, size.height)];
            view.contentInset=UIEdgeInsetsMake(10, 0, 30, 0);
            [selfVC.view addSubview:view];
           
            [UIView animateWithDuration:0.0 animations:^{
//                 [GMDCircleLoader setOnView:view withTitle:@"正在拼命加载..." animated:YES];
                _scrollView.x=-size.width;
                view.x=0.0;
                
            } completion:^(BOOL finished) {
                [_scrollView removeFromSuperview];
                if (_number==selfVC.pageCount) {
                    selfVC.navigationItem.rightBarButtonItem.enabled=NO;
                }else{
                    selfVC.navigationItem.rightBarButtonItem.enabled=YES;
                }
                selfVC.scrollView=view;
                [selfVC loadingNetData];
            }];

        });
    });
    
}

#pragma mark 向右侧轻扫手势
-(void)rightSwipeGesture{
    self.number--;
    if (_number==1) {
        self.linkUrl=self.originalURL;
    }else{
        NSRange range= [self.originalURL rangeOfString:@".html"];
        NSString *str=[self.originalURL stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"_%d.html",_number]];
        self.linkUrl=str;
    }
//    [GMDCircleLoader hideFromView:self.view animated:YES];

    __unsafe_unretained typeof(self) selfVC=self;
    dispatch_async(dispatch_get_global_queue(0.0, 0.0), ^{
        NSDictionary *dict=[DHotsDetailTool detailData:selfVC.linkUrl];
        if (nil == dict){
            self.number++;
            return ;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __block float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
            __block float navigationHeight = self.navigationController.navigationBar.frame.size.height;
            CGSize size=[[UIScreen mainScreen] bounds].size;
            
            __block UIScrollView *view =[[UIScrollView alloc] initWithFrame:CGRectMake(-size.width, statusHeight+navigationHeight, size.width, size.height)];
            view.contentInset=UIEdgeInsetsMake(10, 0, 30, 0);
            [selfVC.view addSubview:view];
            
            [UIView animateWithDuration:0.0 animations:^{
//                 [GMDCircleLoader setOnView:view withTitle:@"正在拼命加载..." animated:YES];
                _scrollView.x=size.width;
                view.x=0.0;
            } completion:^(BOOL finished) {
                [_scrollView removeFromSuperview];
                if (_number==selfVC.pageCount) {
                    selfVC.navigationItem.rightBarButtonItem.enabled=NO;
                }else{
                    selfVC.navigationItem.rightBarButtonItem.enabled=YES;
                }
                selfVC.scrollView=view;
                [selfVC loadingNetData];
                
            }];
            
        });
    });
    
}

#pragma mark 加载网络数据
-(void)loadingNetData{
    __unsafe_unretained typeof(self) selfVC=self;
//    [GMDCircleLoader hideFromView:self.view animated:YES];
    if (_newsDetail==nil) {
//        [GMDCircleLoader setOnView:self.view withTitle:@"正在拼命加载..." animated:YES];
    }
    self.newsDetail=nil;
    dispatch_async(dispatch_get_global_queue(0.0, 0.0), ^{
        NSDictionary *dict=[DHotsDetailTool detailData:self.linkUrl];
        if (nil !=dict) {
            selfVC.newsDetail=[NewsDetail newsDetailWithDict:dict];
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                //设置子控件
    #warning 判断请求链接是否有数据
                //frame 需要根据数据计算
//                [GMDCircleLoader hideFromView:selfVC.view animated:YES];
                [selfVC setupSubViewsFrame];
                [selfVC setupData];
                int page=[_newsDetail.pageCount intValue];
                if (page==0) {
                    page=_number;
                }
                self.pageCount=page;
                if (_number==page) {
                    selfVC.navigationItem.rightBarButtonItem.enabled=NO;
                }
                selfVC.title=[NSString stringWithFormat:@"%d/%d",_number,page];
//                [GMDCircleLoader hideFromView:self.scrollView animated:YES];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
//                [GMDCircleLoader stopInView:selfVC.view title:@"数据或网络异常" animated:YES];
            
            });
        }
    });

}

- (void)setupSubViewsFrame{
    //设置标题
     CGRect screenFrame=[[UIScreen mainScreen] bounds];
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 2*kMargin,screenFrame.size.width, 3*kMargin)];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:kTitleFont]];
    [_scrollView addSubview:titleLabel];
    self.titleLabel=titleLabel;
    
    //设置 日期 来源
    CGFloat dateX=2*kMargin;
    CGFloat dateY=CGRectGetMaxY(titleLabel.frame)+kMargin;
    UILabel *dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(dateX, dateY,screenFrame.size.width-dateX , kMargin)];
    dateLabel.font=[UIFont systemFontOfSize:kDateFont];
    dateLabel.textColor=[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    [_scrollView addSubview:dateLabel];
    self.dateLabel=dateLabel;
    //设置导读
    
    CGFloat instrX=kMargin;
    CGFloat instrY=CGRectGetMaxY(dateLabel.frame)+kMargin;
    CGFloat instrW=screenFrame.size.width-2*instrX;
    CGSize fontSize=[_newsDetail.introduction sizeWithFont:kFountNormalSmall maxSize:CGSizeMake(instrW, MAXFLOAT)];
    CGFloat instrH=fontSize.height+kMargin;
    UILabel *instrLabel=[[UILabel alloc] initWithFrame:CGRectMake(instrX, instrY, instrW,instrH)];
    instrLabel.numberOfLines=0;
    instrLabel.font=kFountNormal;
//    instrLabel.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [_scrollView addSubview:instrLabel];
    self.introductionLabel=instrLabel;
    //设置图片
    
    CGFloat imgW=screenFrame.size.width-4*kMargin;
    CGFloat imgH=kDefaultImgH;
    CGFloat imgX=2*kMargin;
    CGFloat imgY=CGRectGetMaxY(instrLabel.frame)+2*kMargin;
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
     imgView.contentMode=UIViewContentModeScaleAspectFit;

    [_scrollView addSubview:imgView];
    self.imgView=imgView;
    
    //设置图片描述
    CGFloat imgDesX=kMargin;
    CGFloat imgDesY=CGRectGetMaxY(_imgView.frame)+kMargin;
    UILabel *imgDesLabel=[[UILabel alloc] initWithFrame:CGRectMake(imgDesX, imgDesY,screenFrame.size.width-2*kMargin , 2*kMargin)];
    imgDesLabel.text=_newsDetail.imgDescrip;
    imgDesLabel.numberOfLines=0;
    imgDesLabel.font=kFountNormalSmall;
    imgDesLabel.textAlignment=NSTextAlignmentCenter;
    [_scrollView addSubview:imgDesLabel];
    self.imgDesLabel=imgDesLabel;
    
    //设置内容
    CGFloat contentX=kMargin;
    CGFloat contentY=CGRectGetMaxY(imgDesLabel.frame)+kMargin;
    CGFloat contentW=screenFrame.size.width-2*contentX;
    CGSize contentSize=[_newsDetail.content sizeWithFont:kFountNormal maxSize:CGSizeMake(instrW, MAXFLOAT)];
    CGFloat contentH=contentSize.height+kMargin;
    UILabel *contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(contentX, contentY, contentW,contentH)];
    contentLabel.numberOfLines=0;
//    contentLabel.text=_newsDetail.content;
    contentLabel.font=kFountNormal;
    [_scrollView addSubview:contentLabel];
    self.contentLabel=contentLabel;
    
    //设置滚动范围
     _scrollView.contentSize=CGSizeMake(0, CGRectGetMaxY(contentLabel.frame)+50);

}
#pragma mark 设置数据
-(void)setupData{
    self.contentLabel.text=nil;
    self.titleLabel.text=_newsDetail.title;
    self.dateLabel.text=[NSString stringWithFormat:@"%@  %@",_newsDetail.date,_newsDetail.source];
    self.introductionLabel.text=_newsDetail.introduction;
    NSURL *url=[NSURL URLWithString:_newsDetail.imgUrl];
#warning 占位图片还没有设置
    
    __unsafe_unretained typeof(self) selfVC=self;
    [_imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"HotsDetailPlaceHoder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGFloat trueW=image.size.width;
        CGFloat trueH=image.size.height;
        if (trueW >trueH) {
            CGFloat nowH =trueH*kDefaultImgH/trueW;
            [selfVC setValue:[NSNumber numberWithFloat:nowH] forKeyPath:@"imgH"];
        }
    }];
     self.imgDesLabel.text=_newsDetail.imgDescrip;
    self.contentLabel.text=_newsDetail.content;
}
//监听 imgH 改变 imgView 及下面view的frame
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    CGRect imgFrame=_imgView.frame;
    imgFrame.size.height=[self.imgH floatValue];
    self.imgView.frame=imgFrame;
    
    //重设 图片描述
    CGRect imgDescripFrame=_imgDesLabel.frame;
    imgDescripFrame.origin.y=CGRectGetMaxY(_imgView.frame)+kMargin;
    _imgDesLabel.frame=imgDescripFrame;
    
    //重设 正文frame
    CGRect contentFrame=_contentLabel.frame;
    contentFrame.origin.y=CGRectGetMaxY(_imgDesLabel.frame)+kMargin;
    _contentLabel.frame=contentFrame;
    
    //滚动范围
     _scrollView.contentSize=CGSizeMake(0, CGRectGetMaxY(_contentLabel.frame)+50);
}
-(void)didClickedBack:(UIBarButtonItem *)item{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
     [self removeObserver:self forKeyPath:@"imgH"];
}
-(void)didClickedNextPage:(UIBarButtonItem *)item{
    [self leftSwipeGesture];
}
//-(void)dealloc{
//
//}
@end
