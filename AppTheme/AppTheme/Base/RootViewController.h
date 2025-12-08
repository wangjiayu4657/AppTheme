//
//  RootViewController.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RootViewController : UIViewController

@property(nonatomic, strong, readonly) UIColor *navigationBarColor; 						// navigationBar颜色, 默认品牌色, 覆盖getter返回自定义的
@property(nonatomic, strong, readonly) UIImage *navigationBarBackImage; 				// navigationBar返回按钮图标, 覆盖getter返回自定义的
@property(nonatomic, strong, readonly) UIImage *navigationBarBackgroundImage; 	// navigationBar背景图片, 覆盖getter返回自定义的
@property(nonatomic, strong, readonly) UIColor *navigationBarTitleColor; 			  // navigationBar标题颜色, 覆盖getter返回自定义的
@property(nonatomic, strong, readonly) UIFont *navigationBarTitleFont; 				  // navigationBar标题字体, 覆盖getter返回自定义的

@property(nonatomic, assign) BOOL isHiddenMoreBtn;										//是否隐藏右侧按钮
@property(nonatomic, strong) NSString *moreBtnTitle;									//右侧按钮名称
@property(nonatomic, strong) NSString *moreBtnImgName;								//右侧按钮图标

@property(nonatomic, assign) BOOL hidesNavigationBarWhenPush; 		 	  // 是否隐藏navigationBar, 默认YES
@property(nonatomic, assign, readonly) BOOL isNetworkAvailable;		  	// 网络是否可用
@property(nonatomic, assign, readonly) BOOL isPresented; 							// 是否是Presented的, 一般不需要直接使用

- (void)dismiss;  // 退出vc, 会根据vc是否为Presented来选择退出的方式
- (void)networkStateDidChange:(BOOL)available;
//- (void)errorViewTryAgain:(UPErrorView *)errorView;
- (void)moreBtnClick;

@end

NS_ASSUME_NONNULL_END
