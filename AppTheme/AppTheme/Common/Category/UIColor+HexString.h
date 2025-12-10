//
//  UIColor+HexString.h
//  DoubleRecord
//
//  Created by liquan jiang on 2023/2/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexString)
+ (UIColor *) colorWithHexString: (NSString *) hexString;
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)createImageWithColor:(UIColor *)color andSize:(CGSize)size;
/** 颜色转换 IOS中十六进制的颜色转换为UIColor*/
+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
