//
//  FontManager.h
//  FontScale
//
//  Created by 王家玉 on 2025/11/26.
/*
 onceScale:
 如果是当前存在的页面,只能使用 onceScale 缩放比例来进行字体的缩放
 
 selectedScale:
 如果是新创建的页面需要使用 selectedScale 缩放系数来进行字体的缩放
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

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

@interface FontManager : NSObject

+ (instancetype)sharedManager;

//当前缩放类型
@property(nonatomic, assign) FontScale currentFontScale;
//字体缩放系数
@property (nonatomic, readonly, assign) CGFloat fontScale;

/// 更新字体大小
/// - Parameter FontScale: 字体大小类型
- (void)updateFontScale:(FontScale)fontScale;

@end

NS_ASSUME_NONNULL_END
