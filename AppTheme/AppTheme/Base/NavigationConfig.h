//
//  NavigationConfig.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NavigationConfig : NSObject

@property(nonatomic, strong) UIColor *navigationBarColor; 						// navigationBar颜色, 默认品牌色, 覆盖getter返回自定义的
@property(nonatomic, strong) UIImage *navigationBarBackImage; 				// navigationBar返回按钮图标, 覆盖getter返回自定义的
@property(nonatomic, strong) UIImage *navigationBarBackgroundImage; 	// navigationBar背景图片, 覆盖getter返回自定义的
@property(nonatomic, strong) UIColor *navigationBarTitleColor; 			  // navigationBar标题颜色, 覆盖getter返回自定义的
@property(nonatomic, strong) UIFont *navigationBarTitleFont; 				  // navigationBar标题字体, 覆盖getter返回自定义的

@property(nonatomic, assign) BOOL isHiddenBackBtn;										//是否隐藏右侧按钮
@property(nonatomic, strong) NSString *backBtnTitle;									//右侧按钮名称
@property(nonatomic, strong) NSString *backBtnImgName;								//右侧按钮图标

@property(nonatomic, assign) BOOL isHiddenMoreBtn;										//是否隐藏右侧按钮
@property(nonatomic, strong) NSString *moreBtnTitle;									//右侧按钮名称
@property(nonatomic, strong) NSString *moreBtnImgName;								//右侧按钮图标

@property(nonatomic, assign) BOOL hidesNavigationBarWhenPush; 		 	  // 是否隐藏navigationBar, 默认YES
@property(nonatomic, assign, readonly) BOOL isNetworkAvailable;		  	// 网络是否可用
@property(nonatomic, assign, readonly) BOOL isPresented; 							// 是否是Presented的, 一般不需要直接使用


@end

NS_ASSUME_NONNULL_END
