//
//  UIViewController+RouteStack.m
//  FontScale
//
//  Created by 王家玉 on 2025/12/1.
//

#import "UIViewController+RouteStack.h"

@implementation UIViewController (RouteStack)

- (NSArray<UIViewController *> *)getAllViewControllers {
	NSMutableArray<UIViewController *> *allViewControllers = [NSMutableArray array];
	
	// 获取所有窗口
	NSArray<UIWindow *> *windows = [self getApplicationWindows];
	
	for (UIWindow *window in windows) {
		UIViewController *rootVC = window.rootViewController;
		if (rootVC) {
			// 递归获取该窗口下的所有控制器
			NSArray<UIViewController *> *windowViewControllers = [self getAllChildViewControllersFromViewController:rootVC];
			[allViewControllers addObjectsFromArray:windowViewControllers];
		}
	}
	
	return [allViewControllers copy];
}

- (NSArray<UIViewController *> *)getAllChildViewControllersFromViewController:(UIViewController *)viewController {
	NSMutableArray<UIViewController *> *viewControllers = [NSMutableArray array];
	
	if (!viewController) {
		return viewControllers;
	}
	
	// 添加当前控制器
	[viewControllers addObject:viewController];
	
	// 处理 presentedViewController (present 出来的控制器)
	if (viewController.presentedViewController) {
		NSArray<UIViewController *> *presentedViewControllers = [self getAllChildViewControllersFromViewController:viewController.presentedViewController];
		[viewControllers addObjectsFromArray:presentedViewControllers];
	}
	
	// 处理子控制器
	for (UIViewController *childViewController in viewController.childViewControllers) {
		NSArray<UIViewController *> *childViewControllers = [self getAllChildViewControllersFromViewController:childViewController];
		[viewControllers addObjectsFromArray:childViewControllers];
	}
	
	// 特殊处理 UINavigationController
	if ([viewController isKindOfClass:[UINavigationController class]]) {
		UINavigationController *navController = (UINavigationController *)viewController;
		for (UIViewController *vc in navController.viewControllers) {
			NSArray<UIViewController *> *childViewControllers = [self getAllChildViewControllersFromViewController:vc];
			[viewControllers addObjectsFromArray:childViewControllers];
		}
	}
	
	// 特殊处理 UITabBarController
	if ([viewController isKindOfClass:[UITabBarController class]]) {
		UITabBarController *tabController = (UITabBarController *)viewController;
		for (UIViewController *vc in tabController.viewControllers) {
			NSArray<UIViewController *> *childViewControllers = [self getAllChildViewControllersFromViewController:vc];
			[viewControllers addObjectsFromArray:childViewControllers];
		}
	}
	
	return [viewControllers copy];
}

- (NSArray<UIWindow *> *)getApplicationWindows {
	NSMutableArray<UIWindow *> *windows = [NSMutableArray array];
	
	if (@available(iOS 13.0, *)) {
		// iOS 13+ 使用 connectedScenes
		NSSet<UIScene *> *scenes = [UIApplication sharedApplication].connectedScenes;
		for (UIScene *scene in scenes) {
			if ([scene isKindOfClass:[UIWindowScene class]]) {
				UIWindowScene *windowScene = (UIWindowScene *)scene;
				[windows addObjectsFromArray:windowScene.windows];
			}
		}
	} else {
		// iOS 13 之前
		[windows addObjectsFromArray:[UIApplication sharedApplication].windows];
	}
	
	// 确保主窗口在最前面
	[windows sortUsingComparator:^NSComparisonResult(UIWindow *window1, UIWindow *window2) {
		if (window1.isKeyWindow) return NSOrderedAscending;
		if (window2.isKeyWindow) return NSOrderedDescending;
		return NSOrderedSame;
	}];
	
	return [windows copy];
}

@end
