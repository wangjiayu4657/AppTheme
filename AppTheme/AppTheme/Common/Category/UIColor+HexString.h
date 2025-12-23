//
//  UIColor+HexString.h
//  DoubleRecord
//
//  Created by liquan jiang on 2023/2/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexString)
/** 颜色转换 IOS中十六进制的颜色转换为UIColor*/
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)createImageWithColor:(UIColor *)color andSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
