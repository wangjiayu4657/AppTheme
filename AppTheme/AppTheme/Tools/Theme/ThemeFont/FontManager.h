//
//  FontManager.h
//  FontScale
//
//  Created by 王家玉 on 2025/11/26.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FontManager : NSObject

+ (instancetype)sharedManager;

//字体缩放系数
@property (nonatomic, assign) CGFloat fontScale;
//当前缩放类型
@property(nonatomic, assign) FontType currentFontType;

/// 更新字体大小
/// - Parameter FontScale: 字体大小类型
- (void)updateFontType:(FontType)fontType;

@end

NS_ASSUME_NONNULL_END
