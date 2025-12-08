//
//  RootViewController.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/3.
//

#import "RootViewController.h"
#import "ThemeCommon.h"

@interface RootViewController ()
@property (nonatomic, strong) UIButton *moreBtn;
@end


@implementation RootViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self initUI];
	[self initNavigationBarBack];
	[self initNavigationBarAppearance];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}


#pragma mark - public

- (void)dismiss {
	if(self.isPresented) {
		[self dismissViewControllerAnimated:YES completion:nil];
	} else {
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (void)moreBtnClick { }

- (void)networkStateDidChange:(BOOL)available { }


#pragma mark - private

- (void)initUI {
	self.view.backgroundColor = UIColor.greenColor;

	UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithCustomView:self.moreBtn];
	self.navigationItem.rightBarButtonItem = moreItem;
	
	self.navigationController.navigationBar.backgroundColor = self.navigationBarColor;
	self.navigationController.navigationBar.barTintColor = self.navigationBarColor;
	[self.navigationController.navigationBar setBackgroundImage:self.navigationBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

// 设置返回按钮
- (void)initNavigationBarBack {
	// 设置返回按钮图标
	UIImage *backImage = self.navigationBarBackImage;
	if(backImage.renderingMode != UIImageRenderingModeAlwaysOriginal) {
		backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	}
	self.navigationController.navigationBar.backIndicatorImage = backImage;
	self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backImage;
	
	// 强制更新UI，高版本backImage不一致时会出现使用前一个vc的backImage
	[self.navigationController.navigationBar setNeedsLayout];
	[self.navigationController.navigationBar layoutIfNeeded];
	
	// 去掉返回按钮的文字
	if (@available(iOS 14.0.1, *)) {
		self.navigationItem.backButtonDisplayMode = UINavigationItemBackButtonDisplayModeMinimal;
	}
	
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
																																					 style:UIBarButtonItemStylePlain
																																					target:nil
																																					action:nil];
}

- (void)initNavigationBarAppearance {
	// 设置navigationBar颜色, 这里的主要是为了处理push或者pop时的过渡效果
	if(!self.hidesNavigationBarWhenPush) {
//		[self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
			if (@available(iOS 13.0, *)) {
				UINavigationBarAppearance *navigationBarAppearance = [UINavigationBarAppearance new];
				navigationBarAppearance.backgroundColor = self.navigationBarColor;
				navigationBarAppearance.backgroundImage = self.navigationBarBackgroundImage;
				navigationBarAppearance.shadowColor = [UIColor clearColor];
				navigationBarAppearance.shadowImage = [UIImage new];
				navigationBarAppearance.titleTextAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:20]};
				//设置返回按钮
				UIImage * backImage = self.navigationBarBackImage;
				if(backImage.renderingMode != UIImageRenderingModeAlwaysOriginal) {
					backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
				}
				[navigationBarAppearance setBackIndicatorImage:backImage transitionMaskImage:backImage];
				
				self.navigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearance;
				self.navigationController.navigationBar.standardAppearance = navigationBarAppearance;
			} else {
				self.navigationController.navigationBar.translucent = NO;
				self.navigationController.navigationBar.shadowImage = [UIImage new];
				self.navigationController.navigationBar.backgroundColor = self.navigationBarColor;
				[self.navigationController.navigationBar setBackgroundImage:self.navigationBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
				self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.blackColor};
			}
//		} completion:nil];
	}
}


#pragma mark - setter

- (void)setHidesNavigationBarWhenPush:(BOOL)hidesNavigationBarWhenPush {
	_hidesNavigationBarWhenPush = hidesNavigationBarWhenPush;
	[self.navigationController setNavigationBarHidden:hidesNavigationBarWhenPush];
}

- (void)setIsHiddenMoreBtn:(BOOL)isHiddenMoreBtn {
	_isHiddenMoreBtn = isHiddenMoreBtn;
	self.moreBtn.hidden = isHiddenMoreBtn;
}

- (void)setMoreBtnTitle:(NSString *)moreBtnTitle {
	_moreBtnTitle = moreBtnTitle;
	[self.moreBtn setTitle:moreBtnTitle forState:UIControlStateNormal];
}

- (void)setMoreBtnImgName:(NSString *)moreBtnImgName {
	_moreBtnImgName = moreBtnImgName;
	UIImage *moreImg = [UIImage imageNamed:moreBtnImgName];
	[self.moreBtn setImage:moreImg forState:UIControlStateNormal];
}


#pragma mark - getter

- (UIUserInterfaceStyle)overrideUserInterfaceStyle {
	return UIUserInterfaceStyleLight;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
	return NO;
}

- (UIColor *)navigationBarColor {
	return UIColor.grayColor;
}

- (UIImage *)navigationBarBackImage {
	return [UIImage imageNamed:@"left_arrow_white"];
}

- (UIImage *)navigationBarBackgroundImage {
	return [UIImage imageNamed:@"首页-头部背景"];
}

- (UIColor *)navigationBarTitleColor {
	return nil;
}

- (UIFont *)navigationBarTitleFont {
	return nil;
}

-(BOOL)isPresented {
	return self.presentingViewController || self.isBeingPresented;
}

- (BOOL)isNetworkAvailable {
//	return UPTAFNetworkReachable;
	return YES;
}

- (UIButton *)moreBtn {
	if (!_moreBtn) {
		_moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		_moreBtn.titleLabel.font = [UIFont systemFontOfSize:16];
		[_moreBtn setTitle:self.moreBtnTitle forState:UIControlStateNormal];
		[_moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		if(self.moreBtnImgName.length) {
			[_moreBtn setImage:[UIImage imageNamed:self.moreBtnImgName] forState:UIControlStateNormal];
		}
		[_moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
	}
	return _moreBtn ;
}

@end
