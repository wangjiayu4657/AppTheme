//
//  RootViewController.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/3.
//

#import "RootViewController.h"
#import "ThemeCommon.h"
#import "NotificationNameConst.h"

@interface RootViewController ()

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *moreBtn;

@end


@implementation RootViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self initUI];
//	[self initNavigationBarAppearance];
	[self addNotification];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self initNavigationBarAppearance];
}


#pragma mark - public

- (void)dismiss {
	if(self.isPresented) {
		[self dismissViewControllerAnimated:YES completion:nil];
	} else {
		[self.navigationController popViewControllerAnimated:YES];
	}
}


#pragma mark - events

- (void)backBtnClick {
	[self dismiss];
}

- (void)moreBtnClick { }

- (void)networkStateDidChange:(BOOL)available { }

- (void)themeFontSizeDidChanged { }


#pragma mark - private

- (void)initUI {
	self.view.backgroundColor = UIColor.whiteColor;

	UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
	self.navigationItem.leftBarButtonItem = backItem;
	
	UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithCustomView:self.moreBtn];
	self.navigationItem.rightBarButtonItem = moreItem;
	
	self.navigationController.navigationBar.backgroundColor = self.navigationBarColor;
	self.navigationController.navigationBar.barTintColor = self.navigationBarColor;
	[self.navigationController.navigationBar setBackgroundImage:self.navigationBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)initNavigationBarAppearance {
	// 设置navigationBar颜色, 这里的主要是为了处理push或者pop时的过渡效果
	if(!self.hidesNavigationBarWhenPush) {
		NSDictionary *textAttributes = @{
			NSForegroundColorAttributeName: UIColor.whiteColor,
			NSFontAttributeName: [UIFont boldSystemFontOfSize:18]
		};
//		[self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
			if (@available(iOS 13.0, *)) {
				UINavigationBarAppearance *navigationBarAppearance = [UINavigationBarAppearance new];
				navigationBarAppearance.backgroundColor = self.navigationBarColor;
				navigationBarAppearance.backgroundImage = self.navigationBarBackgroundImage;
				navigationBarAppearance.shadowColor = [UIColor clearColor];
				navigationBarAppearance.shadowImage = [UIImage new];
				navigationBarAppearance.titleTextAttributes = textAttributes;
				self.navigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearance;
				self.navigationController.navigationBar.standardAppearance = navigationBarAppearance;
			} else {
				self.navigationController.navigationBar.translucent = NO;
				self.navigationController.navigationBar.shadowImage = [UIImage new];
				self.navigationController.navigationBar.backgroundColor = self.navigationBarColor;
				[self.navigationController.navigationBar setBackgroundImage:self.navigationBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
				self.navigationController.navigationBar.titleTextAttributes = textAttributes;
			}
//		} completion:nil];
	}
}

- (void)addNotification {
	[[NSNotificationCenter defaultCenter] addObserver:self
																					 selector:@selector(themeFontSizeDidChanged)
																							 name:kFontSizeDidChangeNotification
																						 object:nil];
}

#pragma mark - setter

- (void)setHidesNavigationBarWhenPush:(BOOL)hidesNavigationBarWhenPush {
	_hidesNavigationBarWhenPush = hidesNavigationBarWhenPush;
	[self.navigationController setNavigationBarHidden:hidesNavigationBarWhenPush];
}

- (void)setIsHiddenBackBtn:(BOOL)isHiddenBackBtn {
	_isHiddenBackBtn = isHiddenBackBtn;
	self.backBtn.hidden = isHiddenBackBtn;
}

- (void)setBackBtnTitle:(NSString *)backBtnTitle {
	_backBtnTitle = backBtnTitle;
	[self.backBtn setTitle:backBtnTitle forState:UIControlStateNormal];
	[self.backBtn setImage:nil forState:UIControlStateNormal];
}

- (void)setBackBtnImgName:(NSString *)backBtnImgName {
	_backBtnImgName = backBtnImgName;
	[self.backBtn setImage:[UIImage imageNamed:backBtnImgName] forState:UIControlStateNormal];
	[self.backBtn setTitle:nil forState:UIControlStateNormal];
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
	return [UIColor whiteColor];
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

- (UIButton *)backBtn {
	if (!_backBtn) {
		_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		_backBtn.isNotSupportScale = YES;
		_backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
		_backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		_backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
		UIImage *backImg = self.backBtnImgName.length ? [UIImage imageNamed:self.backBtnImgName] : self.navigationBarBackImage;
		[_backBtn setTitle:self.moreBtnTitle forState:UIControlStateNormal];
		[_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_backBtn setImage:backImg forState:UIControlStateNormal];
		[_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
	}
	return _backBtn ;
}

- (UIButton *)moreBtn {
	if (!_moreBtn) {
		_moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		_moreBtn.isNotSupportScale = YES;
		_moreBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
		[_moreBtn setTitle:self.moreBtnTitle forState:UIControlStateNormal];
		[_moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		if(self.moreBtnImgName.length) {
			[_moreBtn setImage:[UIImage imageNamed:self.moreBtnImgName] forState:UIControlStateNormal];
		}
		[_moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
	}
	return _moreBtn ;
}

@end
