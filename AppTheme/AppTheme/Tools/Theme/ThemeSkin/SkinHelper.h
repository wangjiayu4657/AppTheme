//
//  SkinHelper.h
//  AppTheme
//
//  Created by 王家玉 on 2026/1/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
	SkinTypeLight,		  //默认模式
	SkinTypeDark,		  //深色模式
} SkinType;


@interface SkinHelper : NSObject

@property(nonatomic, assign)SkinType skinType;

///切换皮肤主题模式
- (void)updateSkinType:(SkinType)skinType;


@end

NS_ASSUME_NONNULL_END
