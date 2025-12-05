//
//  SettingViewController.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/3.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"设置";
	self.view.backgroundColor = UIColor.systemTealColor;
	
	self.hidesNavigationBarWhenPush = NO;
}

- (void)moreBtnClick {
	NSLog(@"更多");
}

- (NSString *)moreBtnImgName {
	return @"设置-更多";
}

- (UIImage *)navigationBarBackImage {
	return [UIImage imageNamed:@"nav_arrow_left_white"];
}

@end
