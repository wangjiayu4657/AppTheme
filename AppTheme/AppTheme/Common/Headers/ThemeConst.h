//
//  ThemeConst.h
//  FontScale
//
//  Created by 王家玉 on 2025/11/27.
//

#ifndef ThemeConst_h
#define ThemeConst_h

typedef enum : NSUInteger {
	FontType095,   //字体缩放系数为: 0.95
	FontType100,   //字体缩放系数为: 1.00
	FontType105,   //字体缩放系数为: 1.05
	FontType110,   //字体缩放系数为: 1.10
	FontType115,   //字体缩放系数为: 1.15
	FontType120,   //字体缩放系数为: 1.20
	FontType125,   //字体缩放系数为: 1.25
	FontType130,   //字体缩放系数为: 1.30
} FontType;


static NSString * const kAppFontScale = @"kAppFontScale";
static NSString * const kAppDeltFontScale = @"kAppDeltFontScale";

#endif /* ThemeConst_h */
