//
//  UIView+Theme.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/11.
//

#import "UIView+Theme.h"
#import <objc/runtime.h>
#import "ThemeCommon.h"
#import "ThemeColor.h"
#import "BundleManager.h"
#import "UITextField+Theme.h"


static void (*theme_original_setBackgroundColor)(UIView *, SEL, UIColor *);

static void theme_setBackgroundColor(UIView * self, SEL _cmd, UIColor * color) {
	if([color isKindOfClass:ThemeColor.class]) {
		self.theme_backgroundColor = color;
	} else {
		self.theme_backgroundColor = nil;
	}
	
	theme_original_setBackgroundColor(self, _cmd, color);
}



@implementation UIView (Theme)


#pragma mark - public

+ (void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		Method method = class_getInstanceMethod(self, @selector(setBackgroundColor:));
		theme_original_setBackgroundColor = (void *)method_getImplementation(method);
		method_setImplementation(method, (IMP)theme_setBackgroundColor);
		
		theme_swizzleSelector(self, @selector(setTintColor:), @selector(setTheme_tintColor:));
		theme_swizzleSelector(self, @selector(willMoveToSuperview:), @selector(theme_willMoveToSuperview:));
	});
}

- (void)theme_willMoveToSuperview:(UIView *)newSuperview {
	NSString *suffix = [BundleManager overrideSuffix];
	if(!self.theme_isInited) {
		self.theme_resourceSuffix = suffix;
		self.theme_isInited = YES;
	} else if(newSuperview) {
		if(![self.theme_resourceSuffix isEqualToString:suffix]) {
			self.theme_resourceSuffix = suffix;
		}
	}

	[self theme_willMoveToSuperview:newSuperview];
}

- (void)didUpdateViewTheme {
	
	for (UIView *subView in self.subviews) {
		[subView didUpdateViewTheme];
	}
	
	[self updateViewColorTheme];
	[self updateViewImageTheme];
	
	[self setNeedsLayout];
	[self layoutIfNeeded];
}

- (void)updateViewColorTheme {
	UIColor *bgColor = self.theme_backgroundColor;
	
	if(bgColor) {
		self.backgroundColor = nil;
		self.backgroundColor = bgColor;
	}
	
	UIColor *tColor = self.theme_tintColor;
	if(tColor) {
		self.tintColor = tColor;
	}
}

- (void)updateViewImageTheme {
	
}

- (void)updateViewFontTheme {
	for (UIView *subview in self.subviews) {
		if ([subview isKindOfClass:[UILabel class]]) {
			UILabel *label = (UILabel *)subview;
			[self jy_updateFontWithLabel:label];
		} else if ([subview isKindOfClass:[UIButton class]]) {
			UIButton *btn = (UIButton *)subview;
			[self jy_updateFontWithLabel:btn.titleLabel];
			[btn sizeToFit];
		} else if([subview isKindOfClass:[UITextField class]]){
			UITextField *textField = (UITextField *)subview;
			UIFontDescriptorSymbolicTraits trait = textField.font.fontDescriptor.symbolicTraits;
			if(trait == UIFontDescriptorTraitBold) {
				textField.font = [UIFont boldSystemFontOfSize:textField.originalSize];
			} else {
				textField.font = [UIFont systemFontOfSize:textField.originalSize];
			}
		} else {
			[subview updateViewFontTheme];
		}
	}
}


#pragma mark - private

//更新字体缩放
- (void)jy_updateFontWithLabel:(UILabel *)label  {
	UIFontDescriptorSymbolicTraits trait = label.font.fontDescriptor.symbolicTraits;
	if(trait == UIFontDescriptorTraitBold) {
		label.font = [UIFont boldSystemFontOfSize:label.originalSize];
	} else {
		label.font = [UIFont systemFontOfSize:label.originalSize];
	}
}


#pragma mark - setter & getter 

- (UIColor *)theme_tintColor {
	return objc_getAssociatedObject(self, @selector(theme_tintColor));
}

- (void)setTheme_tintColor:(UIColor *)color {
	if([color isKindOfClass:ThemeColor.class]) {
		objc_setAssociatedObject(self, @selector(theme_tintColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	} else {
		objc_setAssociatedObject(self, @selector(theme_tintColor), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	
	[self setTheme_tintColor:color];
}

-(UIColor *)theme_backgroundColor {
	return objc_getAssociatedObject(self, @selector(theme_backgroundColor));
}

- (void)setTheme_backgroundColor:(UIColor *)color {
	objc_setAssociatedObject(self, @selector(theme_backgroundColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)theme_isInited {
	NSNumber *isInited = objc_getAssociatedObject(self, @selector(theme_isInited));
	return isInited.boolValue;
}

- (void)setTheme_isInited:(BOOL)isInited {
	NSNumber *obj = [NSNumber numberWithBool:isInited];
	objc_setAssociatedObject(self, @selector(theme_isInited), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)theme_resourceSuffix {
	return objc_getAssociatedObject(self, @selector(theme_resourceSuffix));
}

- (void)setTheme_resourceSuffix:(NSString *)theme_resourceSuffix {
	if (!self.theme_isInited || ![self.theme_resourceSuffix isEqualToString:theme_resourceSuffix]) {
		[self didUpdateViewTheme];
	}
	
	objc_setAssociatedObject(self, @selector(theme_resourceSuffix), theme_resourceSuffix, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
