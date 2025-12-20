//
//  UIFont+Scale.m
//  FontScale
//
//  Created by 王家玉 on 2025/11/26.
//

#import "UIFont+Scale.h"
#import "ThemeCommon.h"
#import "FontManager.h"


@implementation UIFont (Scale)

+ (void)load {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
		theme_exchangeSelector([self class], @selector(systemFontOfSize:), @selector(jy_systemFontOfSize:));
		theme_exchangeSelector([self class], @selector(boldSystemFontOfSize:), @selector(jy_boldSystemFontOfSize:));
  });
}


#pragma mark - public

+ (UIFont *)jy_notSupportScaleFontOfSize:(CGFloat)fontSize {
	return [self jy_systemFontOfSize:fontSize];
}

+ (UIFont *)jy_notSupportScaleBoldFontOfSize:(CGFloat)fontSize {
	return [self jy_boldSystemFontOfSize:fontSize];
}


#pragma mark - private

+ (UIFont *)jy_systemFontOfSize:(CGFloat)size {
	FontManager *manager = [FontManager sharedManager];
	UIFont *font = [self jy_systemFontOfSize:size * manager.fontScale];
	font.originalSize = size;
	return font;
}

+ (UIFont *)jy_boldSystemFontOfSize:(CGFloat)size {
	FontManager *manager = [FontManager sharedManager];
	UIFont *font = [self jy_boldSystemFontOfSize:size * manager.fontScale];
	font.originalSize = size;
	return font;
}


#pragma mark - setter & getter

- (CGFloat)originalSize {
	return [objc_getAssociatedObject(self, @selector(originalSize)) floatValue];
}

- (void)setOriginalSize:(CGFloat)originalSize {
	objc_setAssociatedObject(self, @selector(originalSize), @(originalSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
