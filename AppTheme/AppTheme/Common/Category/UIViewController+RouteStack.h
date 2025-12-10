//
//  UIViewController+RouteStack.h
//  FontScale
//
//  Created by 王家玉 on 2025/12/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (RouteStack)

// 获取当前应用的所有窗口中的控制器
- (NSArray<UIViewController *> *)getAllViewControllers;

// 获取指定控制器的完整子控制器层级
- (NSArray<UIViewController *> *)getAllChildViewControllersFromViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
