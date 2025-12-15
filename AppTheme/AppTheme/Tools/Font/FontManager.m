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
      @(FontScale095): @(0.95),
      @(FontScale100): @(1.00),
      @(FontScale105): @(1.05),
      @(FontScale110): @(1.10),
			@(FontScale115): @(1.15),
			@(FontScale120): @(1.20),
			@(FontScale125): @(1.25),
			@(FontScale130): @(1.30),
    };
		
		NSNumber *scale = [[NSUserDefaults standardUserDefaults] objectForKey:kAppFontScale];
		CGFloat fontScale = [self handlerConversionAccuracyWithNumber:scale scale:2];
		self.fontScale = fontScale ? fontScale : 1.0;
  }
  return self;
}


#pragma mark - public

- (void)updateFontScale:(FontScale)fontScale {
	//先获取当前选中的缩放系数
	NSNumber *selScale = [self.fontScaleMap objectForKey:@(fontScale)];
	self.fontScale = [self handlerConversionAccuracyWithNumber:selScale scale:2];
}

- (void)saveFontScale:(FontScale)fontScale {
	//先获取当前选中的缩放系数
	NSNumber *selScale = [self.fontScaleMap objectForKey:@(fontScale)];
	[self saveScale:selScale];
	
	[[UIApplication sharedApplication] updateFontTheme];
	[[NSNotificationCenter defaultCenter] postNotificationName:kFontSizeDidChangeNotification object:nil];
}


#pragma mark - private

- (void)saveScale:(NSNumber *)scale {
	[[NSUserDefaults standardUserDefaults] setObject:scale forKey:kAppFontScale];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

//处理转换时的精度
- (CGFloat)handlerConversionAccuracyWithNumber:(NSNumber *)number scale:(NSUInteger)scale {
	// 放大指定倍数，进行整数运算，再缩小
	long long multiplier = pow(10, scale);
	long long integerValue = (long long)([number doubleValue] * multiplier + 0.5);
	return (CGFloat)integerValue / multiplier;
}


#pragma mark - getter

- (FontScale)currentFontScale {
	FontScale fontScale = FontScale100;
	NSNumber *saveScale = [[NSUserDefaults standardUserDefaults] objectForKey:kAppFontScale];
	CGFloat scale = [self handlerConversionAccuracyWithNumber:saveScale scale:2];
	
	if(scale == 0.95) {
		fontScale = FontScale095;
	} else if(scale == 1.00) {
		fontScale = FontScale100;
	} else if(scale == 1.05) {
		fontScale = FontScale105;
	} else if(scale == 1.10) {
		fontScale = FontScale110;
	} else if(scale == 1.15) {
		fontScale = FontScale115;
	} else if(scale == 1.20) {
		fontScale = FontScale120;
	} else if(scale == 1.25) {
		fontScale = FontScale125;
	} else if(scale == 1.30) {
		fontScale = FontScale130;
	}
	
	return fontScale;
}

@end
