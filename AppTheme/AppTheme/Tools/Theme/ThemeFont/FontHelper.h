//
//  FontHelper.h
//  AppTheme
//
//  Created by 王家玉 on 2026/1/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FontHelper : NSObject

//字体缩放系数
@property (nonatomic, assign) CGFloat fontScale;
//当前缩放类型
@property(nonatomic, assign) FontType currentFontType;

/// 更新字体大小
/// - Parameter FontScale: 字体大小类型
- (void)updateFontType:(FontType)fontType;


/// 更新字体大小
/// - Parameters:
///   - fontType: 字体大小类型
///   - isRefresh: 是否需要立即刷新 YES: 刷新  NO:不刷新
- (void)updateFontType:(FontType)fontType isRefresh:(BOOL)isRefresh;

@end

NS_ASSUME_NONNULL_END
