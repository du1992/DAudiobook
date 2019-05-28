//
//  DRadioModel.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/23.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRadioModel : DBaseModel

/**
 *  专辑标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  配图
 */
@property (nonatomic,copy) NSString *coverimg;

/**
 *  专辑ID
 */
@property (nonatomic, assign) NSInteger albumId;

/**
 *  专辑简介
 */
@property (nonatomic, strong) NSString * albumIntro;

/**
 *  是否相同
 */
-(DRadioModel*)isEqualRadioModel:(NSMutableArray*)array;

/**
 *  删除
 */
-(DRadioModel*)deleteRadioModel:(NSMutableArray*)array;

@end

NS_ASSUME_NONNULL_END
