//
//  Rankng.h
//  Star
//
//  Created by lanou3g on 15/5/28.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Ranking : NSObject
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *imgUrl;
@property (nonatomic ,copy) NSString *linkUrl;
@property (nonatomic ,copy) NSString *heat;
@property (nonatomic,copy) NSString *chart;
@property (nonatomic,strong) UIColor *chartColor;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)rankingWithDict:(NSDictionary *)dict;
@end
