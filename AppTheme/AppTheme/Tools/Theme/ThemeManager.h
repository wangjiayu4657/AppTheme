//
//  ThemeManager.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
	ThemeModeLight,		//默认模式
	ThemeModeDark,		//深色模式
} ThemeMode;

@interface ThemeManager : NSObject

+ (instancetype)manager;

@property(nonatomic, assign) ThemeMode themeMode;

///加载初始化主题模式名称
- (void)loadThemeSource:(NSArray *)source;

///切换主题模式
- (void)changeTheme:(ThemeMode)theme;
//- (BOOL)changeTheme:(ThemeMode)theme;

@end

NS_ASSUME_NONNULL_END
