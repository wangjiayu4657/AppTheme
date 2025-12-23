//
//  UIColor+CommonColor.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/22.
//

#import "UIColor+CommonColor.h"
#import "ThemeMacro.h"

#define _COLOR_FOR_ONCE(colorName) \
static UIColor * color; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
color = UPTColorInModule(colorName, @UPR_STRING(UPR_MODULE)); \
}); \
return color;


@implementation UIColor (CommonColor)

+ (UIColor *)jy_bgColor {
	_COLOR_FOR_ONCE(@"conmmon_bg_color");
}

+ (UIColor *)jy_bgContentColor {
	_COLOR_FOR_ONCE(@"common_bg_content_color");
}

+ (UIColor *)jy_textPrimaryColor {
	_COLOR_FOR_ONCE(@"common_text_primary_color");
}



@end
