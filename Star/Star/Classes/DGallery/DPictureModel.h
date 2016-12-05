//
//  DPictureModel.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPictureModel : NSObject

@property(nonatomic,assign)NSInteger width;//宽
@property(nonatomic,assign)NSInteger height;//高
@property(nonatomic,copy)NSString *thumbURL;//图片网址
@property(nonatomic,copy)NSString *title;//图片标题
@property(nonatomic,copy)NSString *imgUrl;//图片地址
@property(nonatomic,copy)NSString *linkUrl;//详情页网址

//该方法用于封装model （需要给个字典）
+(instancetype)setModelWithDictionary:(NSDictionary *)dictionary;

@end
