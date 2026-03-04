//
//  SkinHelper.m
//  AppTheme
//
//  Created by 王家玉 on 2026/1/16.
//

#import "SkinHelper.h"
#import "NotificationNameConst.h"
#import "BundleManager.h"
#import "UIApplication+Theme.h"


@implementation SkinHelper

- (instancetype)init {
	self = [super init];
	if (self) {
		self.skinType = SkinTypeLight;
	}
	return self;
}

- (void)updateSkinType:(SkinType)skinType {
	self.skinType = skinType;
	NSString *themeType = self.skinType == SkinTypeDark ? @"Dark" : @"Light";
	[BundleManager setOverrideSuffix:themeType];
	
	[[UIApplication sharedApplication] updateColorTheme];
	[self themeDidChangedNotification];
}


#pragma mark - events

- (void)themeDidChangedNotification {
	[[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotification object:nil];
}


@end
