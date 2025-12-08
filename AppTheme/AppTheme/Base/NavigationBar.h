//
//  NavigationBar.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/3.
//

#import <UIKit/UIKit.h>
@class NavigationBar;


NS_ASSUME_NONNULL_BEGIN

@protocol NavigationBarDelegate <NSObject>

@optional

/// 自定义导航栏左侧视图, 不实现则使用默认视图(返回按钮)
- (UIView *)leadingViewForNavigationBar;
/// 自定义导航栏标题视图, 不实现则使用默认视图(标题标签)
- (UIView *)titleViewForNavigationBar;
/// 自定义导航栏右侧视图, 不实现则使用默认视图(更多按钮)
- (UIView *)trailingViewForNavigationBar;

///点击返回按钮
- (void)didSelectedBack;
///点击更多按钮
- (void)didSelectedMore;

@end


@interface NavigationBar : UIView

@property (nonatomic,weak) id<NavigationBarDelegate> delegate;

@property (nonatomic,assign) CGFloat topSafeArea;     	//顶部安全区距离
@property (nonatomic, strong) NSString *bgImgName;    	//背景图片
@property (nonatomic, strong) UIColor *textColor;				//字体颜色
@property (nonatomic,assign) BOOL isHiddenBackBtn;			//是否隐藏左侧返回按钮
@property (nonatomic,assign) BOOL isHiddenRightBtn;			//是否隐藏右侧按钮
@property(nonatomic, strong) NSString *title;						//标题
@property (nonatomic,assign) NSString *backBtnTitle;		//返回按钮名称
@property (nonatomic,assign) NSString *rightBtnTitle;		//右侧按钮名称
@property (nonatomic,assign) NSString *rightBtnImgName;	//右侧按钮图标

@end

NS_ASSUME_NONNULL_END
