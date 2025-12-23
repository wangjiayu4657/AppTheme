//
//  UIViewController+FontScale.m
//  FontScale
//
//  Created by 王家玉 on 2025/11/26.
//

#import "UIViewController+Theme.h"
#import "ThemeCommon.h"
#import "UIViewController+RouteStack.h"
#import "UILabel+Theme.h"
#import "UIView+Theme.h"


@implementation UIViewController (Theme)

- (void)updateFontTheme {
	if(self.presentingViewController) {
		[self.presentedViewController updateFontTheme];
	}
	
	// 遍历所有子视图并刷新字体
	[self refreshFontsInView:self.view];
}

- (void)updateColorTheme {
	if(self.presentingViewController) {
		[self.presentedViewController updateColorTheme];
	}
	
	[self refreshColorsInView:self.view];
}


#pragma mark - private

- (void)refreshFontsInView:(UIView *)view {
	for (UIView *subview in view.subviews) {
		if ([subview isKindOfClass:[UILabel class]]) {
			UILabel *label = (UILabel *)subview;
			[self jy_updateFontWithLabel:label];
		} else if ([subview isKindOfClass:[UIButton class]]) {
			UIButton *btn = (UIButton *)subview;
			[self jy_updateFontWithLabel:btn.titleLabel];
			[btn sizeToFit];
		} else {
			[self refreshFontsInView:subview];
		}
	}
}

//更新字体缩放
- (void)jy_updateFontWithLabel:(UILabel *)label  {
	UIFontDescriptorSymbolicTraits trait = label.font.fontDescriptor.symbolicTraits;
	if(trait == UIFontDescriptorTraitBold) {
		label.font = [UIFont boldSystemFontOfSize:label.originalSize];
	} else {
		label.font = [UIFont systemFontOfSize:label.originalSize];
	}
}

- (void)refreshColorsInView:(UIView *)view {
	for (UIView *subview in view.subviews) {
		if ([subview isKindOfClass:[UILabel class]]) {
			UILabel *label = (UILabel *)subview;
			label.textColor = UIColor.jy_textPrimaryColor;
			label.backgroundColor = UIColor.jy_bgColor;
		} else if ([subview isKindOfClass:[UIButton class]]) {
			UIButton *btn = (UIButton *)subview;
			[btn setTitleColor:UIColor.jy_textPrimaryColor forState:UIControlStateNormal];
			btn.backgroundColor = UIColor.jy_bgColor;
			[btn sizeToFit];
		} else {
			subview.backgroundColor = UIColor.jy_bgContentColor;
			[self refreshFontsInView:subview];
		}
	}
}
@end
