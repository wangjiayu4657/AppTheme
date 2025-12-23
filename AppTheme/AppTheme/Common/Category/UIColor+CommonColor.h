//
//  UIColor+CommonColor.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (CommonColor)

//#F2F2F2 - #0F1319
@property(class, nonatomic, readonly) UIColor *jy_bgColor;

//#FFFFFF - #222531
@property(class, nonatomic, readonly) UIColor *jy_bgContentColor;

//#F8F8F8 - #333333
@property(class, nonatomic, readonly) UIColor *jy_textPrimaryColor;

@end

NS_ASSUME_NONNULL_END
