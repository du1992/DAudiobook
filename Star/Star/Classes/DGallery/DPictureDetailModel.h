//
//  DPictureDetailModel.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPictureDetailModel : NSObject

@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,strong)NSString *imgUrl;//图片地址
@property(nonatomic,copy)NSString *descrip;//描述
@property(nonatomic,assign)NSInteger pageCount;//相片总数

@end
