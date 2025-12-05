//
//  AppDelegate.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/1.
//

#import "AppDelegate.h"
#import "TabBarController.h"


@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	// 仅当不是 iOS 13+ 时配置 window
	if (@available(iOS 13.0, *)) {
		// iOS 13+ 由 SceneDelegate 处理
	} else {
		self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
		TabBarController *tabCtrl = [[TabBarController alloc] init];
		self.window.rootViewController = tabCtrl;
		[self.window makeKeyAndVisible];
	}
	
	return YES;
}

#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {

	// 创建场景配置
	UISceneConfiguration *configuration = [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
	configuration.delegateClass = NSClassFromString(@"SceneDelegate");
	configuration.storyboard = nil; // 如果没有使用 storyboard
	
	return configuration;
}


// 用户关闭场景时调用
- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
	NSLog(@"丢弃场景会话");
}


@end
