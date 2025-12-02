//
//  TabBarController.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/2.
//

#import "TabBarController.h"
#import "NavigationViewController.h"
#import "HomeViewController.h"
#import "MarketViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "TabBarView.h"


@interface TabBarController ()<TabbarViewDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	[self initAppearance];
	[self loadChildController];
	[self loadTabbarView];
}

- (void)initAppearance {
	if (@available(iOS 13.0, *)) {
		UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
		[appearance configureWithOpaqueBackground];
		appearance.backgroundColor = [UIColor whiteColor];
		appearance.shadowColor = nil; // 移除阴影/分割线
		self.tabBar.standardAppearance = appearance;
		if (@available(iOS 15.0, *)) {
			self.tabBar.scrollEdgeAppearance = appearance;
		}
	} else {
		self.tabBar.shadowImage = [[UIImage alloc] init];
		self.tabBar.backgroundImage = [[UIImage alloc] init];
	}
}

- (void)loadChildController {
	HomeViewController *homeCtrl = [[HomeViewController alloc] init];
	homeCtrl.hidesBottomBarWhenPushed = YES;
	NavigationViewController *homeNav = [[NavigationViewController alloc] initWithRootViewController:homeCtrl];
	
	MarketViewController *marketCtrl = [[MarketViewController alloc] init];
	marketCtrl.hidesBottomBarWhenPushed = YES;
	NavigationViewController *marketNav = [[NavigationViewController alloc] initWithRootViewController:marketCtrl];
	
	DiscoverViewController *discoverCtrl = [[DiscoverViewController alloc] init];
	discoverCtrl.hidesBottomBarWhenPushed = YES;
	NavigationViewController *discoverNav = [[NavigationViewController alloc] initWithRootViewController:discoverCtrl];
	
	ProfileViewController *profileCtrl = [[ProfileViewController alloc] init];
	profileCtrl.hidesBottomBarWhenPushed = YES;
	NavigationViewController *profileNav = [[NavigationViewController alloc] initWithRootViewController:profileCtrl];
	
	self.viewControllers = @[homeNav, marketNav, discoverNav, profileNav];
}

- (void)loadTabbarView {
	self.tabBar.hidden = YES;
	TabBarView *tabbarView = [[TabBarView alloc] initWithFrame:self.tabBar.frame];
	tabbarView.delegate = self;
	
	NSArray *titles = @[@"首页", @"市场", @"发现", @"我的"];
	NSArray *normalImages = @[@"首页-默认", @"市场-默认", @"发现-默认", @"我的-默认"];
	NSArray *selectedImages = @[@"首页-选中", @"市场-选中", @"发现-选中", @"我的-选中"];
	
	[tabbarView setupItemsWithTitles:titles
											normalImages:normalImages
										selectedImages:selectedImages];
	[self.view addSubview:tabbarView];
}



#pragma mark - TabbarViewDelegate

- (void)tabBar:(TabBarView *)tabBar didSelectItemAtIndex:(NSInteger)index {
	self.selectedIndex = index;
}

@end
