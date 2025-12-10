//
//  StepSlider.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/9.
//

#import <UIKit/UIKit.h>
@class StepSlider;

NS_ASSUME_NONNULL_BEGIN

@protocol StepSliderDelegate <NSObject>

- (void)slider:(StepSlider *)slider valueDidChanged:(CGFloat)value;

@end


@interface StepSlider : UISlider

@property(nonatomic, weak) id<StepSliderDelegate> delegate;
@property (nonatomic, assign) CGFloat stepValue; // 步进值

@end

NS_ASSUME_NONNULL_END
