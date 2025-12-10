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
  });
}

+ (UIFont *)jy_systemFontOfSize:(CGFloat)fontSize {
	FontManager *manager = [FontManager sharedManager];
	CGFloat scale = manager.onceScale == 0 ? manager.fontScale : manager.onceScale;
	CGFloat size = scale * fontSize;
	return [self jy_systemFontOfSize:size];
}

@end
