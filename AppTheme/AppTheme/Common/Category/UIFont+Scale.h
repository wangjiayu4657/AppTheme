//
//  UIFont+Scale.h
//  FontScale
//
//  Created by 王家玉 on 2025/11/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (Scale)

@property(nonatomic, assign) CGFloat originalSize;

///不支持正常字体缩放
+ (UIFont *)jy_notSupportScaleFontOfSize:(CGFloat)fontSize;

///不支持粗字体的缩放
+ (UIFont *)jy_notSupportScaleBoldFontOfSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
