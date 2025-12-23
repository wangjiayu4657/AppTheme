//
//  HomeViewController.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/2.
//

#import "HomeViewController.h"
#import "SettingViewController.h"
#import "ThemeManager.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"首页";
	self.view.backgroundColor = UIColor.jy_bgContentColor;

	[self jy_layoutSubviews];
}

#pragma mark - 设置 UI

- (void)jy_layoutSubviews {
	
}


#pragma mark - events

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[[ThemeManager manager] changeTheme:ThemeModeDark];
}


#pragma mark - getter


@end
