//
//  LoginViewController.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/16.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "NavigationBar.h"

@interface LoginViewController ()<NavigationBarDelegate>

@property(nonatomic, strong) NavigationBar *navBar;
@property(nonatomic, strong) LoginView *loginView;

@end


@implementation LoginViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	[self jy_layoutSubviews];
}


#pragma mark - 设置 UI

- (void)jy_layoutSubviews {
	
	[self.view addSubview:self.navBar];
	[self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.top.right.equalTo(self.view);
		make.height.mas_equalTo(106);
	}];
	
	[self.view addSubview:self.loginView];
	[self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.navBar.mas_bottom).offset(20);
		make.left.right.equalTo(self.view);
	}];
}


#pragma mark - NavigationBarDelegate

- (void)didSelectedBack {
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter

- (NavigationBar *)navBar {
	if (!_navBar) {
		_navBar = [[NavigationBar alloc] init];
		_navBar.backgroundColor = [UIColor cyanColor];
		_navBar.delegate = self;
	}
	return _navBar;
}

- (LoginView *)loginView {
	if (!_loginView) {
		_loginView = [[LoginView alloc] init];
	}
	return _loginView;
}

@end
