//
//  UIViewController+FontScale.m
//  FontScale
//
//  Created by 王家玉 on 2025/11/26.
//

#import "UIViewController+Theme.h"
#import "ThemeCommon.h"
#import "UIViewController+RouteStack.h"


@implementation UIViewController (Theme)

+ (void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
//		theme_swizzleSelector(self, @selector(viewWillAppear:), @selector(jy_viewWillAppear:));
	});
}

- (void)updateFontTheme {
	NSLog(@"presenting == %@   presented == %@", self.presentingViewController, self.presentedViewController);
	
	if(self.presentingViewController) {
		[self.presentedViewController updateFontTheme];
	}
	
	NSLog(@"controller == %@",self);
	// 遍历所有子视图并刷新字体
	[self refreshFontsInView:self.view];
}

- (void)jy_viewWillAppear:(BOOL)animated {
	[self jy_viewWillAppear:animated];
	
	// 在每次页面显示时自动刷新字体
	[self refreshFontsIfNeeded];
}

- (void)refreshFontsIfNeeded {
	// 遍历所有子视图并刷新字体
	[self refreshFontsInView:self.view];
}

- (void)refreshFontsInView:(UIView *)view {
	for (UIView *subview in view.subviews) {
		if ([subview isKindOfClass:[UILabel class]]) {
			UILabel *label = (UILabel *)subview;
			label.font = [UIFont systemFontOfSize:label.font.pointSize];
		} else if ([subview isKindOfClass:[UIButton class]]) {
			UIButton *btn = (UIButton *)subview;
			btn.titleLabel.font = [UIFont systemFontOfSize:btn.titleLabel.font.pointSize];
		} else {
			[self refreshFontsInView:subview];
		}
	}
}

@end
