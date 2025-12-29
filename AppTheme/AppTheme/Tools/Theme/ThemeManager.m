//
//  ThemeManager.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/20.
//

#import "ThemeManager.h"
#import "NotificationNameConst.h"
#import "BundleManager.h"
#import "UIApplication+Theme.h"


@interface ThemeManager()

@end

@implementation ThemeManager

+ (instancetype)manager {
	static ThemeManager *manager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		manager = [[ThemeManager alloc] init];
		manager.themeMode = ThemeModeLight;
	});
	return manager;
}

- (void)changeTheme:(ThemeMode)theme {
	self.themeMode = theme;
	NSString *themeName = self.themeMode == ThemeModeDark ? @"Dark" : @"Light";
	[BundleManager setOverrideSuffix:themeName];
	
	[[UIApplication sharedApplication] updateColorTheme];
	[self themeDidChangedNotification];
}

#pragma mark - events

- (void)themeDidChangedNotification {
	[[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotification object:nil];
}

@end
