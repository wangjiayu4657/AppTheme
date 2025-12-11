//
//  UILabel+Theme.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/11.
//

#import "UILabel+Theme.h"
#import "ThemeCommon.h"
#import <objc/runtime.h>
#import "UIFont+Scale.h"

@implementation UILabel (Theme)

+ (void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		theme_swizzleSelector(self, @selector(setFont:), @selector(jy_setFont:));
	});
}

- (void)jy_setFont:(UIFont *)font {
	self.originalSize = font.originalSize;
	[self jy_setFont:font];
}


#pragma mark - setter & getter

- (CGFloat)originalSize {
	return [objc_getAssociatedObject(self, @selector(originalSize)) floatValue];
}

- (void)setOriginalSize:(CGFloat)originalFontOfSize {
	objc_setAssociatedObject(self, @selector(originalSize), @(originalFontOfSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
