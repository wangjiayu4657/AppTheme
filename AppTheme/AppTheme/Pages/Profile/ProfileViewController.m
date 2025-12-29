//
//  ProfileViewController.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/2.
//

#import "ProfileViewController.h"
#import "NavigationBar.h"
#import "SettingViewController.h"

@interface ProfileViewController ()<NavigationBarDelegate>
@property (nonatomic, strong) NavigationBar *navBar;
@end

@implementation ProfileViewController

#pragma mark - lift circle

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = UIColor.jy_bgContentColor;
	
	[self jy_layoutSubviews];
	[self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewSafeAreaInsetsDidChange {
	[super viewSafeAreaInsetsDidChange];
	self.navBar.topSafeArea = self.view.up_safeAreaInsets.top;
}


#pragma mark - 设置 UI

- (void)jy_layoutSubviews {
	[self.view addSubview:self.navBar];
	[self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.top.right.equalTo(self.view);
		make.height.mas_equalTo(100);
	}];
}


#pragma mark - NavigationBarDelegate

- (void)didSelectedMore {
	SettingViewController *settingCtrl = [[SettingViewController alloc] init];
	settingCtrl.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:settingCtrl animated:YES];
}


#pragma mark - getter

- (NavigationBar *)navBar {
	if (!_navBar) {
		_navBar = [[NavigationBar alloc] init];
		_navBar.title = @"我的";
		_navBar.isHiddenBackBtn = YES;
		_navBar.rightImgName = @"我的-设置";
		_navBar.delegate = self;
		_navBar.textColor = UIColor.whiteColor;
		_navBar.backgroundColor = UIColor.purpleColor;
	}
	return _navBar;
}

@end
