//
//  DView.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/20.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DView.h"

@implementation DView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setLayout];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setLayout];
    }
    return self;
}
- (void)setLayout{}
-(void)setData:(DBaseModel *)model{
    
}
@end
