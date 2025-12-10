//
//  UIWindow+FontScale.m
//  FontScale
//
//  Created by 王家玉 on 2025/12/1.
//

#import "UIWindow+Theme.h"
#import "UIViewController+Theme.h"
#import "FontManager.h"
#import "UIViewController+RouteStack.h"
#import "TabBarController.h"

@implementation UIWindow (Theme)

- (void)updateFontTheme {
	[self.rootViewController updateFontTheme];
	
	TabBarController *tabCtrl = (TabBarController *)self.rootViewController;
	for (UINavigationController *nav in tabCtrl.childViewControllers) {
		for (UIViewController *controller in nav.viewControllers) {
			[controller updateFontTheme];
		}
	}
	
	//已存在的页面更新完之后需要重置一下零时的缩放系数
	[[FontManager sharedManager] resetOnceScale];
}

@end
