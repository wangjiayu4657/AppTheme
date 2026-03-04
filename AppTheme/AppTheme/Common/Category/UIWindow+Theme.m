//
//  UIWindow+FontScale.m
//  FontScale
//
//  Created by 王家玉 on 2025/12/1.
//

#import "UIWindow+Theme.h"
#import "UIViewController+Theme.h"
#import "UIViewController+RouteStack.h"
#import "TabBarController.h"
#import "ThemeFontViewController.h"
#import "NavigationViewController.h"

@implementation UIWindow (Theme)

- (void)updateWindowFontTheme {
	UIView *snapshot = [self snapshotViewAfterScreenUpdates:NO];
	[self.rootViewController updateControllerFontTheme];
	
	TabBarController *tabCtrl = (TabBarController *)self.rootViewController;
	for (NavigationViewController *nav in tabCtrl.childViewControllers) {
		if([nav isKindOfClass:[NavigationViewController class]]) {
			for(UIViewController *controller in nav.viewControllers) {
				[controller updateControllerFontTheme];
			}
		}
	}
	
	[self addSubview:snapshot];
	[UIView animateWithDuration:0.25 animations:^{
		snapshot.alpha = 0;
	} completion:^(BOOL finished) {
		[snapshot removeFromSuperview];
	}];
}

- (void)updateWindowColorTheme {
	UIView *snapshot = [self snapshotViewAfterScreenUpdates:NO];
	[self.rootViewController updateControllerColorTheme];
	
	TabBarController *tabCtrl = (TabBarController *)self.rootViewController;
	for (NavigationViewController *nav in tabCtrl.childViewControllers) {
		if([nav isKindOfClass:[NavigationViewController class]]) {
			for(UIViewController *controller in nav.viewControllers) {
				[controller updateControllerColorTheme];
			}
		}
	}
	
	[self addSubview:snapshot];
	[UIView animateWithDuration:0.25 animations:^{
		snapshot.alpha = 0;
	} completion:^(BOOL finished) {
		[snapshot removeFromSuperview];
	}];
}

@end
