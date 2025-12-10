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
  FontTypeSmall,        //小字体
	FontTypeNormal,       //默认
  FontTypeLarger,       //大字体
  FontTypeExtraLarge,   //超大字体
} FontType;

typedef enum : NSUInteger {
	FontScale10,   //放大系数为: 1.0
	FontScale11,   //放大系数为: 1.1
	FontScale12,   //放大系数为: 1.2
	FontScale13,   //放大系数为: 1.3
	FontScale14,   //放大系数为: 1.4
	FontScale15,   //放大系数为: 1.5
	FontScale16,   //放大系数为: 1.6
} FontScale;

@interface FontManager : NSObject

+ (instancetype)sharedManager;

//一次性缩放比例, 只在用户切换字体时生效
@property (nonatomic, assign) CGFloat onceScale;
//当前选中的缩放系数
@property (nonatomic, readonly, assign) CGFloat fontScale;
//当前放大类型
@property (nonatomic,assign) FontType currentFontType;

/// 更新字体大小
/// - Parameter fontType: 字体大小类型
- (void)updateFontScaleWithFontType:(FontType)fontType;
- (void)updateFontScale:(FontScale)fontScale;
///重置零时缩放比例系数
- (void)resetOnceScale;

@end

NS_ASSUME_NONNULL_END
