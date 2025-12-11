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

- (void)refreshFontsInView:(UIView *)view {
	for (UIView *subview in view.subviews) {
		if(!subview.isNoSupportScale) {
			if ([subview isKindOfClass:[UILabel class]]) {
				UILabel *label = (UILabel *)subview;
				label.font = [UIFont systemFontOfSize:label.originalSize];
			} else if ([subview isKindOfClass:[UIButton class]]) {
				UIButton *btn = (UIButton *)subview;
					btn.titleLabel.font = [UIFont systemFontOfSize:btn.titleLabel.originalSize];
					[btn sizeToFit];
			} else {
				[self refreshFontsInView:subview];
			}
		}
	}
}

@end
