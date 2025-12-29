//
//  UIView+Theme.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Theme)

@property(nonatomic, assign) BOOL theme_isInited;
@property(nonatomic, strong) NSString *theme_resourceSuffix;
@property(nonatomic, copy, nullable) UIColor *theme_backgroundColor;

- (void)didUpdateViewTheme NS_REQUIRES_SUPER;
- (void)updateViewImageTheme NS_REQUIRES_SUPER;
- (void)updateViewColorTheme NS_REQUIRES_SUPER;
- (void)updateViewFontTheme;

@end

NS_ASSUME_NONNULL_END
