//
//  BackButtonCompat.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BackButtonCompat : NSObject

// 创建兼容的返回按钮
+ (UIBarButtonItem *)compatibleBackButtonWithTitle:(NSString *)title
																						 image:(UIImage *)image
																	 imageEdgeInsets:(UIEdgeInsets)imageInsets
																	 titleEdgeInsets:(UIEdgeInsets)titleInsets
																						target:(id)target
																						action:(SEL)action;

// 设置按钮的图片和文字间距（兼容所有版本）
+ (void)setButton:(UIButton *)button
						image:(UIImage *)image
						title:(NSString *)title
	imageEdgeInsets:(UIEdgeInsets)imageInsets
	titleEdgeInsets:(UIEdgeInsets)titleInsets;

// 更新按钮配置（兼容 iOS 15+ 和旧版本）
+ (void)updateButtonConfiguration:(UIButton *)button
											updateBlock:(void(^)(UIButton *button))updateBlock;

@end

NS_ASSUME_NONNULL_END
