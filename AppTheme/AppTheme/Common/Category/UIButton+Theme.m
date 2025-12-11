//
//  UIButton+Theme.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/11.
//

#import "UIButton+Theme.h"
#import "ThemeCommon.h"
#import <objc/runtime.h>

@implementation UIButton (Theme)

- (BOOL)isNotSupportScale {
	return [objc_getAssociatedObject(self, @selector(isNotSupportScale)) boolValue];
}

- (void)setIsNotSupportScale:(BOOL)isNotSupportScale {
	objc_setAssociatedObject(self, @selector(isNotSupportScale), @(isNotSupportScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
