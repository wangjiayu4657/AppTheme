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
#import "ThemeFontViewController.h"
#import "NavigationViewController.h"

@implementation UIWindow (Theme)

- (void)updateFontTheme {
	[self.rootViewController updateFontTheme];
	
	TabBarController *tabCtrl = (TabBarController *)self.rootViewController;
	for (NavigationViewController *nav in tabCtrl.childViewControllers) {
		if([nav isKindOfClass:[NavigationViewController class]]) {
			for(UIViewController *controller in nav.viewControllers) {
				[controller updateFontTheme];
			}
		}
	}
}

- (void)updateColorTheme {
	[self.rootViewController updateColorTheme];
	
	TabBarController *tabCtrl = (TabBarController *)self.rootViewController;
	for (NavigationViewController *nav in tabCtrl.childViewControllers) {
		if([nav isKindOfClass:[NavigationViewController class]]) {
			for(UIViewController *controller in nav.viewControllers) {
				[controller updateColorTheme];
			}
		}
	}
}

//- (void)updateFontTheme {
//	UIView *rootCtrlView = self.rootViewController.view;
//	[self.rootViewController updateColorTheme];
//}
//
//- (void)updateColorTheme {
//	UIView *rootCtrlView = self.rootViewController.view;
//	[self.rootViewController updateFontTheme];
//}

@end
