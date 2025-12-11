//
//  UIView+Theme.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/11.
//

#import "UIView+Theme.h"
#import <objc/runtime.h>

@implementation UIView (Theme)


- (BOOL)isNoSupportScale {
	return [objc_getAssociatedObject(self, @selector(isNoSupportScale)) boolValue];
}

- (void)setIsNoSupportScale:(BOOL)isNoSupportScale {
	objc_setAssociatedObject(self, @selector(isNoSupportScale), @(isNoSupportScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
