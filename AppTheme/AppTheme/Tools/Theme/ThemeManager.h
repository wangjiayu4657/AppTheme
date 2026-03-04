//
//  ThemeManager.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/20.
//

#import <Foundation/Foundation.h>
#import "ThemeSkin/SkinHelper.h"
#import "ThemeFont/FontHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThemeManager : NSObject

+ (instancetype)manager;

//字体缩放系数
@property(nonatomic, readonly, assign) CGFloat fontScale;
//当前缩放类型
@property(nonatomic, readonly, assign) FontType currentFontType;

@property(nonatomic, readonly, assign) SkinType skinThemeMode;


///切换主题模式
/// - Parameter skinTheme: 皮肤主题
- (void)updateSkinType:(SkinType)skinType;

/// 更新字体大小
/// - Parameter FontScale: 字体大小类型
/// - Parameter isRefresh: 是否需要立即刷新
- (void)updateFontType:(FontType)fontType isRefresh:(BOOL)isRefresh;

@end

NS_ASSUME_NONNULL_END
