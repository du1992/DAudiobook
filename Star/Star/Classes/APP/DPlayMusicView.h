//
//  DPlayMusicView.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/1/30.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DRadioSecondListModel;
typedef  void(^RadioBlock)(DRadioSecondListModel *);

@interface DPlayMusicView : UIView

@property (nonatomic,copy) RadioBlock block;

@end
