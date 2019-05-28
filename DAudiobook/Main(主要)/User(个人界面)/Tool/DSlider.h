//
//  DSlider.h
//
//  Created by DUCHENGWEN on 2017/2/2.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class DSlider;

typedef void (^SliderValueChangeBlock) (DSlider *slider);
typedef void (^SliderFinishChangeBlock) (DSlider *slider);
typedef void (^DraggingSliderBlock) (DSlider *slider);


@interface DSlider : UIView


@property (nonatomic, assign) CGFloat value;        /* From 0 to 1 */
@property (nonatomic, assign) CGFloat middleValue;  /* From 0 to 1 */
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat sliderDiameter;
@property (nonatomic, strong) UIColor *sliderColor;
@property (nonatomic, strong) UIColor *maxColor;
@property (nonatomic, strong) UIColor *middleColor;
@property (nonatomic, strong) UIColor *minColor;

@property (nonatomic, copy) SliderValueChangeBlock valueChangeBlock;
@property (nonatomic, copy) SliderFinishChangeBlock finishChangeBlock;
@property (nonatomic, strong) DraggingSliderBlock draggingSliderBlock;


@end

NS_ASSUME_NONNULL_END
