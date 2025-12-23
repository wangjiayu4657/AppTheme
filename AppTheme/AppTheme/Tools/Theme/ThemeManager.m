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

/** 主题bundle*/
@property (nonatomic,strong) NSBundle *bundle;
/** 颜色对照表*/
@property (nonatomic, copy) NSDictionary *colorsMap;
/** 主题数组*/
@property (nonatomic, copy) NSArray *themeSource;

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

- (void)loadThemeSource:(NSArray *)source {
	self.themeSource = source;
}

- (void)changeTheme:(ThemeMode)theme {
	self.themeMode = theme;
	NSString *themeName = [self getThemeName];
	[BundleManager setOverrideSuffix:themeName];
	
	[[UIApplication sharedApplication] updateColorTheme];
	[self themeDidChangedNotification];
	
//	[self themeChanged:theme];
}

- (BOOL)themeChanged:(ThemeMode)theme {
	self.themeMode = theme;
	
	//判断当前主题资源中是否含有需要切换的主题
	if(![self.themeSource containsObject:@(theme)]) {
		return NO;
	}
	
	//获取特定bundle
	NSString *themeName = [self getThemeName];
	NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"AppThemeSource_Dark" withExtension:@"bundle"]];
	if(!bundle) {
		return NO;
	}
	
	NSLog(@"bundle == %@",bundle);
	
	//获取 bundle 下特定文件的路径
	NSString *path = [bundle pathForResource:@"colors" ofType:@"strings"];
	if(!path) {
		return NO;
	}
	
	NSLog(@"bundlepath == %@",path);
	
	//获取特定文件中的内容
	self.colorsMap = [NSDictionary dictionaryWithContentsOfFile:path];
	
	[self themeDidChangedNotification];
	
	return YES;
}


#pragma mark - events

- (void)themeDidChangedNotification {
	[[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotification object:nil];
}


#pragma mark - private

- (NSString *)getThemeName {
//	NSString *themeName = @"LightThemeSource";
//	NSArray *themes = @[@"LightThemeSource", @"DarkThemeSource"];
//	if(self.themeMode < themes.count) {
//		themeName = themes[self.themeMode];
//	}
//	return themeName;
	
	NSString *themeName = @"Light";
	NSArray *themes = @[@"Light", @"Dark"];
	if(self.themeMode < themes.count) {
		themeName = themes[self.themeMode];
	}
	return themeName;
}

@end
