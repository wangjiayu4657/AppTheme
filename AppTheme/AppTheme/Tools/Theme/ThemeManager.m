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
@property(nonatomic, strong) SkinHelper *skinHelper;
@property(nonatomic, strong) FontHelper *fontHelper;
@end


@implementation ThemeManager

+ (instancetype)manager {
	static ThemeManager *manager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		manager = [[ThemeManager alloc] init];
	});
	return manager;
}


#pragma mark - public

- (void)updateSkinType:(SkinType)skinType {
	[self.skinHelper updateSkinType:skinType];
}

- (void)updateFontType:(FontType)fontType isRefresh:(BOOL)isRefresh{
	[self.fontHelper updateFontType:fontType isRefresh:isRefresh];
}


#pragma mark - getter

- (CGFloat)fontScale {
	return self.fontHelper.fontScale;
}

- (FontType)currentFontType {
	return self.fontHelper.currentFontType;
}

- (SkinType)skinThemeMode {
	return self.skinHelper.skinType;
}

- (SkinHelper *)skinHelper {
	if (!_skinHelper) {
		_skinHelper = [[SkinHelper alloc] init];
	}
	return _skinHelper;
}

- (FontHelper *)fontHelper {
	if (!_fontHelper) {
		_fontHelper = [[FontHelper alloc] init];
	}
	return _fontHelper;
}

@end
