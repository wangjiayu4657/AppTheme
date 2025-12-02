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
	
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	TabBarController *tabCtrl = [[TabBarController alloc] init];
	self.window.rootViewController = tabCtrl;
	[self.window makeKeyAndVisible];
	
	return YES;
}


@end
