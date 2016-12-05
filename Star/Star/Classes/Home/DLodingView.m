
//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.
#import "DLodingView.h"

#define kScreenFrame [[UIScreen mainScreen] bounds]
@interface DLodingView()

@end


@implementation DLodingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:kScreenFrame];
    if (self) {
        UIActivityIndicatorView *view=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        UILabel *hintLabel=[[UILabel alloc] init];
        hintLabel.numberOfLines=0;
        [self addSubview:view];
        [self addSubview:hintLabel];
        self.indicatorView=view;
        self.hintLabel=hintLabel;
        self.hintLabel.text=@"ddddddddd";
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)layoutSubviews{
    CGFloat inX=kScreenFrame.size.width*0.3;
    CGFloat inY=kScreenFrame.size.height*0.4;
    self.indicatorView.frame=CGRectMake(inX, inY, 150, 150);
    self.hintLabel.frame=CGRectMake(inX+50, inY, 100, 40);
    
}


@end
