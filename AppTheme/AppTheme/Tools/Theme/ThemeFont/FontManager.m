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

@property (nonatomic, strong) NSDictionary *fontTypeMap;

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
    self.fontTypeMap = @{
      @(FontType095): @(0.95),
      @(FontType100): @(1.00),
      @(FontType105): @(1.05),
      @(FontType110): @(1.10),
			@(FontType115): @(1.15),
			@(FontType120): @(1.20),
			@(FontType125): @(1.25),
			@(FontType130): @(1.30),
    };
		
		NSNumber *scale = [[NSUserDefaults standardUserDefaults] objectForKey:kAppFontScale];
		CGFloat fontScale = [self handlerConversionAccuracyWithNumber:scale scale:2];
		self.fontScale = fontScale ? fontScale : 1.0;
  }
  return self;
}


#pragma mark - public

- (void)updateFontType:(FontType)fontType {
	//先获取当前选中的缩放系数
	NSNumber *selScale = [self.fontTypeMap objectForKey:@(fontType)];
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

- (FontType)currentFontType {
	FontType fontType = FontType100;
	NSNumber *saveScale = [[NSUserDefaults standardUserDefaults] objectForKey:kAppFontScale];
	CGFloat scale = [self handlerConversionAccuracyWithNumber:saveScale scale:2];
	
	if(scale == 0.95) {
		fontType = FontType095;
	} else if(scale == 1.00) {
		fontType = FontType100;
	} else if(scale == 1.05) {
		fontType = FontType105;
	} else if(scale == 1.10) {
		fontType = FontType110;
	} else if(scale == 1.15) {
		fontType = FontType115;
	} else if(scale == 1.20) {
		fontType = FontType120;
	} else if(scale == 1.25) {
		fontType = FontType125;
	} else if(scale == 1.30) {
		fontType = FontType130;
	}
	
	return fontType;
}

@end
