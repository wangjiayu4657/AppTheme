//
//  SliderView.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/9.
//

#import <UIKit/UIKit.h>
@class SliderView;

NS_ASSUME_NONNULL_BEGIN

@protocol SliderViewDelegate <NSObject>

- (void)sliderView:(SliderView *)sliderView updateScale:(CGFloat)scale FontScale:(FontScale)fontScale;

@end


@interface SliderView : UIView

@property(nonatomic, weak) id<SliderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
