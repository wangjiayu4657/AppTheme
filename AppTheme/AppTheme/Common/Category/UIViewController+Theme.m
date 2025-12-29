//
//  UIViewController+FontScale.m
//  FontScale
//
//  Created by 王家玉 on 2025/11/26.
//

#import "UIViewController+Theme.h"
#import "ThemeCommon.h"
#import "UIViewController+RouteStack.h"
#import "UILabel+Theme.h"
#import "UIView+Theme.h"
#import "BundleManager.h"
#import "UITextField+Theme.h"


@implementation UIViewController (Theme)

+ (void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		theme_swizzleSelector(self, @selector(willMoveToParentViewController:), @selector(theme_willMoveToParentViewController:));
	});
}

- (void)theme_willMoveToParentViewController:(UIViewController *)parent {
	NSString *suffix = [BundleManager overrideSuffix];
	if(!self.theme_isInited) {
		self.theme_resourceSuffix = suffix;
		self.theme_isInited = YES;
	} else if(parent) {
		if(![self.theme_resourceSuffix isEqualToString:suffix]) {
			self.theme_resourceSuffix = suffix;
		}
	} else if(parent == nil) {
		/* childVC被移除时也要保存Suffix
		 存在这种场景：
		 childVC1->switchTheme->childVC2->switchTheme->循环。
		 此时如果在移除时未保存suffix，下个周期会因为Suffix相等而跳过换肤操作
		 */
		
		self.theme_resourceSuffix = suffix;
		
		/*
		 疑问：如果没有这句代码，同一个VC为什么会存在部分UI更新，部分未更新呢？
		 解释：新创建的控件UI会更新，比如Cell，旧控件不会；
		 */
	}
	
	[self theme_willMoveToParentViewController:parent];
}

- (void)updateControllerFontTheme {
	if(self.presentingViewController) {
		NSLog(@"presentingViewController == %@",self.presentingViewController);
		[self.presentedViewController updateControllerFontTheme];
	}
	
	if(self.viewLoaded) {
		[self.view updateViewFontTheme];
	}
}

- (void)updateControllerColorTheme {
	[self setNeedsStatusBarAppearanceUpdate];
	
	[self.presentedViewController updateControllerColorTheme];
	
	for (UIViewController *child in self.childViewControllers) {
		[child updateControllerColorTheme];
	}
	
	if(self.viewLoaded) {
		[self.view didUpdateViewTheme];
	}
}



#pragma mark - private
//
//- (void)refreshFontsInView:(UIView *)view {
//	for (UIView *subview in view.subviews) {
//		if ([subview isKindOfClass:[UILabel class]]) {
//			UILabel *label = (UILabel *)subview;
//			[self jy_updateFontWithLabel:label];
//		} else if ([subview isKindOfClass:[UIButton class]]) {
//			UIButton *btn = (UIButton *)subview;
//			[self jy_updateFontWithLabel:btn.titleLabel];
//			[btn sizeToFit];
//		} else if([subview isKindOfClass:[UITextField class]]){
//			UITextField *textField = (UITextField *)subview;
//			UIFontDescriptorSymbolicTraits trait = textField.font.fontDescriptor.symbolicTraits;
//			if(trait == UIFontDescriptorTraitBold) {
//				textField.font = [UIFont boldSystemFontOfSize:textField.originalSize];
//			} else {
//				textField.font = [UIFont systemFontOfSize:textField.originalSize];
//			}
//		} else {
//			[self refreshFontsInView:subview];
//		}
//	}
//}
//
////更新字体缩放
//- (void)jy_updateFontWithLabel:(UILabel *)label  {
//	UIFontDescriptorSymbolicTraits trait = label.font.fontDescriptor.symbolicTraits;
//	if(trait == UIFontDescriptorTraitBold) {
//		label.font = [UIFont boldSystemFontOfSize:label.originalSize];
//	} else {
//		label.font = [UIFont systemFontOfSize:label.originalSize];
//	}
//}

- (void)refreshColorsInView:(UIView *)view {
	for (UIView *subview in view.subviews) {
		if ([subview isKindOfClass:[UILabel class]]) {
			UILabel *label = (UILabel *)subview;
			label.textColor = UIColor.jy_textPrimaryColor;
			label.backgroundColor = UIColor.jy_bgColor;
		} else if ([subview isKindOfClass:[UIButton class]]) {
			UIButton *btn = (UIButton *)subview;
			[btn setTitleColor:UIColor.jy_textPrimaryColor forState:UIControlStateNormal];
			btn.backgroundColor = UIColor.jy_bgColor;
			[btn sizeToFit];
		} else {
			subview.backgroundColor = UIColor.jy_bgContentColor;
			[self refreshColorsInView:subview];
		}
	}
}


#pragma mark - setter & getter

- (BOOL)theme_isInited {
	return [objc_getAssociatedObject(self, @selector(theme_isInited)) boolValue];
}

- (void)setTheme_isInited:(BOOL)theme_isInited {
	objc_setAssociatedObject(self, @selector(theme_isInited), @(theme_isInited), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)theme_resourceSuffix {
	return objc_getAssociatedObject(self, @selector(theme_resourceSuffix));
}

- (void)setTheme_resourceSuffix:(NSString *)theme_resourceSuffix {
	if(!self.theme_isInited || ![self.theme_resourceSuffix isEqualToString:theme_resourceSuffix]) {
		[self updateControllerColorTheme];
	}
	
	objc_setAssociatedObject(self, @selector(theme_resourceSuffix), theme_resourceSuffix, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
