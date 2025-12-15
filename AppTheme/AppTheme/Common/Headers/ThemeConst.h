//
//  ThemeConst.h
//  FontScale
//
//  Created by 王家玉 on 2025/11/27.
//

#ifndef ThemeConst_h
#define ThemeConst_h

typedef enum : NSUInteger {
	FontScale095,   //字体缩放系数为: 0.95
	FontScale100,   //字体缩放系数为: 1.00
	FontScale105,   //字体缩放系数为: 1.05
	FontScale110,   //字体缩放系数为: 1.10
	FontScale115,   //字体缩放系数为: 1.15
	FontScale120,   //字体缩放系数为: 1.20
	FontScale125,   //字体缩放系数为: 1.25
	FontScale130,   //字体缩放系数为: 1.30
} FontScale;

static NSString * const kAppFontSize = @"kAppFontSize";
static NSString * const kAppFontScale = @"kAppFontScale";
static NSString * const kAppDeltFontScale = @"kAppDeltFontScale";

#endif /* ThemeConst_h */
