//
//  FontManager.m
//  FontScale
//
//  Created by 王家玉 on 2025/11/26.
//

#import "FontManager.h"
#import "ThemeConst.h"
#import "NotificationNameConst.h"
#import "UIApplication+Theme.h"


@interface FontManager()

@property (nonatomic, strong) NSDictionary *fontScaleMap;

@end


@implementation FontManager

+ (instancetype)sharedManager {
  static FontManager *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[FontManager alloc] init];
  });
  return instance;
}

- (instancetype)init {
  if (self = [super init]) {
    // 预设的字体缩放比例系数
    self.fontScaleMap = @{
      @(0): @(1.0),
      @(1): @(1.1),
      @(2): @(1.2),
      @(3): @(1.3),
			@(4): @(1.4),
			@(5): @(1.5),
			@(6): @(1.6),
    };
  }
  return self;
}



#pragma mark - public

- (void)updateFontScale:(FontScale)fontScale {
//	if(self.currentFontScale == fontScale) return;
	
	//先获取当前选中的缩放系数
	CGFloat selScale = [[self.fontScaleMap objectForKey:@(fontScale)] floatValue];
	self.onceScale = selScale / self.fontScale;
	
	[self saveFontScale:selScale];
	
	[[UIApplication sharedApplication] updateFontTheme];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:kFontSizeDidChangeNotification object:nil];
}

- (void)updateFontScaleWithFontType:(FontType)fontType {
	if(self.currentFontType == fontType) return;
	
	//先获取当前选中的缩放系数
  CGFloat selScale = [[self.fontScaleMap objectForKey:@(fontType)] floatValue];

	self.onceScale = selScale / self.fontScale;
	
	[self saveFontScale:selScale];
	
	[[UIApplication sharedApplication] updateFontTheme];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kFontSizeDidChangeNotification object:nil];
}

- (void)resetOnceScale {
	self.onceScale = 0;
}


#pragma mark - private

- (FontType)currentFontType {
	FontType curType = FontTypeNormal;
	CGFloat scale = self.fontScale;
	if(scale == 1.0) {
		curType = FontTypeSmall;
	} else if(scale == 1.1) {
		curType = FontTypeNormal;
	} else if(scale == 1.2) {
		curType = FontTypeLarger;
	} else if(scale == 1.3) {
		curType = FontTypeExtraLarge;
	}
	return curType;
}

- (FontScale)currentFontScale {
	FontScale fontScale = FontScale10;
	CGFloat scale = self.fontScale;

	if(scale == 1.0) {
		fontScale = FontScale10;
	} else if(scale == 1.1) {
		fontScale = FontScale11;
	} else if(scale == 1.2) {
		fontScale = FontScale12;
	} else if(scale == 1.3) {
		fontScale = FontScale13;
	} else if(scale == 1.4) {
		fontScale = FontScale14;
	} else if(scale == 1.5) {
		fontScale = FontScale15;
	} else if(scale == 1.6) {
		fontScale = FontScale16;
	}
	
	return fontScale;
}

- (void)saveFontScale:(CGFloat)fontScale {
	NSLog(@"set save scale == %f",fontScale);
	[[NSUserDefaults standardUserDefaults] setFloat:fontScale forKey:kAppFontScale];
	[[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - getter

- (CGFloat)fontScale {
	NSNumber *fontScale = [[NSUserDefaults standardUserDefaults] objectForKey:kAppFontScale];
	NSLog(@"get save scale == %@",fontScale);
	return fontScale ? [fontScale floatValue] : 1.0;
}

@end
