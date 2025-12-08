//
//  ThemeFontViewController.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/8.
//

#import "ThemeFontViewController.h"
#import "NavigationBar.h"

@interface ThemeFontViewController ()<NavigationBarDelegate>
@property(nonatomic, strong) NavigationBar *navBar;
@end

@implementation ThemeFontViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self jy_layoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
//	self.hidesNavigationBarWhenPush = YES;
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	self.hidesNavigationBarWhenPush = NO;
}


#pragma mark - 设置 UI

- (void)jy_layoutSubviews {
	[self.view addSubview:self.navBar];
	[self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.top.right.equalTo(self.view);
		make.height.mas_equalTo(100);
	}];
}

- (void)viewSafeAreaInsetsDidChange {
	[super viewSafeAreaInsetsDidChange];
	
	self.navBar.topSafeArea = self.view.up_safeAreaInsets.top;
}


#pragma mark - NavigationBarDelegate

- (void)didSelectedBack {
	[self dismiss];
}


#pragma mark - getter

- (NavigationBar *)navBar {
	if (!_navBar) {
		_navBar = [[NavigationBar alloc] init];
		_navBar.bgImgName = @"首页-头部背景";
		_navBar.backBtnTitle = @"取消";
		_navBar.title = @"设置字体大小";
		_navBar.delegate = self;
	}
	return _navBar;
}

@end
