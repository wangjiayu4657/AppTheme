//
//  SceneDelegate.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/1.
//

#import "SceneDelegate.h"
#import "TabBarController.h"
#import "ThemeManager.h"

@interface SceneDelegate ()

@end


@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
	if (![scene isKindOfClass:[UIWindowScene class]]) {
		return;
	}
	
	UIWindowScene *windowScene = (UIWindowScene *)scene;
	self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
	TabBarController *tabCtrl = [[TabBarController alloc] init];
	self.window.rootViewController = tabCtrl;
	[self.window makeKeyAndVisible];
	
	[[ThemeManager manager] changeTheme:ThemeModeLight];
	
	// 处理深链接
	if (connectionOptions.URLContexts.count > 0) {
		[self handleDeepLink:connectionOptions.URLContexts.allObjects.firstObject.URL];
	}
}


// 场景被系统断开连接
- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
	NSLog(@"场景断开连接");
}

// 场景变为活动状态
- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
	NSLog(@"场景变为活动状态");
}

// 场景即将变为非活动状态
- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
	NSLog(@"场景即将变为非活动状态");
}

// 场景即将进入前台
- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
	NSLog(@"场景即将进入前台");
}

// 场景进入后台
- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
	NSLog(@"场景进入后台");
}


#pragma mark - 处理 URL

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts  API_AVAILABLE(ios(13.0)){
	if (URLContexts.count > 0) {
		NSURL *url = URLContexts.allObjects.firstObject.URL;
		[self handleDeepLink:url];
	}
}

- (void)handleDeepLink:(NSURL *)url {
	// 处理深链接逻辑
	NSLog(@"处理深链接: %@", url.absoluteString);
}

@end
