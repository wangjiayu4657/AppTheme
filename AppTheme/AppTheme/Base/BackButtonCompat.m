//
//  BackButtonCompat.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/8.
//

#import "BackButtonCompat.h"

@implementation BackButtonCompat

+ (UIBarButtonItem *)compatibleBackButtonWithTitle:(NSString *)title
																						 image:(UIImage *)image
																	 imageEdgeInsets:(UIEdgeInsets)imageInsets
																	 titleEdgeInsets:(UIEdgeInsets)titleInsets
																						target:(id)target
																						action:(SEL)action {
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
	
	// 设置图片
	if (image) {
		[button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
						forState:UIControlStateNormal];
		button.tintColor = [UIColor systemBlueColor];
	}
	
	// 设置标题
	if (title.length > 0) {
		[button setTitle:title forState:UIControlStateNormal];
		[button setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
		button.titleLabel.font = [UIFont systemFontOfSize:16];
	}
	
	// 设置间距（兼容处理）
	[self setButton:button
						image:image
						title:title
	imageEdgeInsets:imageInsets
	titleEdgeInsets:titleInsets];
	
	// 添加事件
	if (target && action) {
		[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	}
	
	// 自动调整大小
	[button sizeToFit];
	
	// 确保最小点击区域
	CGRect frame = button.frame;
	frame.size.width = MAX(frame.size.width, 44);
	frame.size.height = MAX(frame.size.height, 44);
	button.frame = frame;
	
	return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (void)setButton:(UIButton *)button
						image:(UIImage *)image
						title:(NSString *)title
	imageEdgeInsets:(UIEdgeInsets)imageInsets
	titleEdgeInsets:(UIEdgeInsets)titleInsets {
	
	if (@available(iOS 15.0, *)) {
		// iOS 15+ 使用 UIButtonConfiguration
		UIButtonConfiguration *config = button.configuration ?: [UIButtonConfiguration plainButtonConfiguration];
		
		// 设置图片
		if (image) {
			config.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
			config.imageColorTransformer = ^UIColor *(UIColor *color) {
				return [UIColor systemBlueColor];
			};
			
			// 使用 imagePadding 替代 imageEdgeInsets
			config.imagePadding = imageInsets.right; // 使用 right 作为间距
		}
		
		// 设置标题
		if (title.length > 0) {
			config.title = title;
			
			// 设置标题属性
			NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:title];
			[attributedTitle addAttribute:NSFontAttributeName
															value:[UIFont systemFontOfSize:16]
															range:NSMakeRange(0, title.length)];
			[attributedTitle addAttribute:NSForegroundColorAttributeName
															value:[UIColor systemBlueColor]
															range:NSMakeRange(0, title.length)];
			
			config.attributedTitle = attributedTitle;
		}
		
		// 设置内容内边距
		config.contentInsets = NSDirectionalEdgeInsetsMake(imageInsets.top,
																											 imageInsets.left,
																											 imageInsets.bottom,
																											 titleInsets.right);
		
		// 应用配置
		button.configuration = config;
		
	} else {
		// iOS 14 及以下使用传统方式
		button.imageEdgeInsets = imageInsets;
		button.titleEdgeInsets = titleInsets;
	}
}

+ (void)updateButtonConfiguration:(UIButton *)button
											updateBlock:(void(^)(UIButton *button))updateBlock {
	
	if (!updateBlock) return;
	
	if (@available(iOS 15.0, *)) {
		// iOS 15+：创建新的配置
		UIButtonConfiguration *config = [button.configuration copy];
		
		// 应用更新到按钮
		updateBlock(button);
		
		// 确保配置被应用
		if (config) {
			button.configuration = config;
		}
	} else {
		// iOS 14 及以下：直接更新按钮
		updateBlock(button);
	}
}


@end
