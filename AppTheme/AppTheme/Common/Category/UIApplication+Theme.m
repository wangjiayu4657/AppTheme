//
//  UIApplication+FontScale.m
//  FontScale
//
//  Created by 王家玉 on 2025/11/27.
//

#import "UIApplication+Theme.h"
#import "UIWindow+Theme.h"

@implementation UIApplication (Theme)

- (void)updateFontTheme {
	if(@available(iOS 13.0, *)) {
		NSSet *set = self.connectedScenes;
		UIWindowScene *windowScene = [set anyObject];
		for (UIWindow *window in windowScene.windows) {
			[window updateFontTheme];
		}
	} else if(@available(iOS 11.0, *)) {
		for (UIWindow *window in self.windows) {
			[window updateFontTheme];
		}
	}
}

@end
