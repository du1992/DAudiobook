//
//  DPublishDraftBottomView.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/26.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DView.h"

NS_ASSUME_NONNULL_BEGIN
@interface DCustomTopImageButton : UIButton

@end
/**
 *  item类型
 */
typedef NS_ENUM(NSUInteger, DPublishDraftBottomViewItemType) {
    /** 图片*/
    DPublishDraftBottomViewItemTypePicture = 1,
    /** 视频*/
    DPublishDraftBottomViewItemTypeVideo,
    /** 匿名*/
    DPublishDraftBottomViewItemTypeAnonymous,
};

@class DPublishDraftBottomView;
@protocol DPublishDraftBottomViewDelegate <NSObject>
/** 点击回调*/
- (void)publishDraftBottomView:(DPublishDraftBottomView *)bottomView didClickItemWithType:(DPublishDraftBottomViewItemType)type;
@end

@interface DPublishDraftBottomView : UIView
@property (nonatomic, weak) id <DPublishDraftBottomViewDelegate> delegate;
/** 剩余可输入字数*/
@property (nonatomic, assign) NSInteger limitCount;

@end


NS_ASSUME_NONNULL_END
