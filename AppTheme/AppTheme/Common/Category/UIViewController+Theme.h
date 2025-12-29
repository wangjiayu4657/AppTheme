//
//  UIViewController+FontScale.h
//  FontScale
//
//  Created by 王家玉 on 2025/11/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Theme)

@property(nonatomic, assign) BOOL theme_isInited;
@property(nonatomic, copy) NSString *theme_resourceSuffix;

- (void)updateControllerFontTheme;
- (void)updateControllerColorTheme;


@end

NS_ASSUME_NONNULL_END
