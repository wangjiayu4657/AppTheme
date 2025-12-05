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
@property (nonatomic, strong) TabBarView *tabBarView;
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
		appearance.backgroundColor = [UIColor blueColor];
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
	homeCtrl.hidesBottomBarWhenPushed = NO;
	NavigationViewController *homeNav = [[NavigationViewController alloc] initWithRootViewController:homeCtrl];
	
	MarketViewController *marketCtrl = [[MarketViewController alloc] init];
	marketCtrl.hidesBottomBarWhenPushed = NO;
	NavigationViewController *marketNav = [[NavigationViewController alloc] initWithRootViewController:marketCtrl];
	
	DiscoverViewController *discoverCtrl = [[DiscoverViewController alloc] init];
	discoverCtrl.hidesBottomBarWhenPushed = NO;
	NavigationViewController *discoverNav = [[NavigationViewController alloc] initWithRootViewController:discoverCtrl];
	
	ProfileViewController *profileCtrl = [[ProfileViewController alloc] init];
	profileCtrl.hidesBottomBarWhenPushed = NO;
	NavigationViewController *profileNav = [[NavigationViewController alloc] initWithRootViewController:profileCtrl];
	
	self.viewControllers = @[homeNav, marketNav, discoverNav, profileNav];
}

- (void)loadTabbarView {
	UPTabBar *upTabBar = [[UPTabBar alloc] initWithFrame:self.tabBar.frame];
	[self setValue:upTabBar forKey:@"tabBar"];
	
	self.tabBar.translucent = NO;
	self.tabBar.tintColor = UIColor.clearColor;
	self.tabBar.barTintColor = UIColor.clearColor;
	
	TabBarView *tabBarView = [[TabBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.up_width, 49)];
	tabBarView.delegate = self;
	tabBarView.backgroundColor = UIColor.whiteColor;
	
	NSArray *titles = @[@"首页", @"市场", @"发现", @"我的"];
	NSArray *normalImages = @[@"首页-默认", @"市场-默认", @"发现-默认", @"我的-默认"];
	NSArray *selectedImages = @[@"首页-选中", @"市场-选中", @"发现-选中", @"我的-选中"];
	
	[tabBarView setupItemsWithTitles:titles
											normalImages:normalImages
										selectedImages:selectedImages];
	
	[self.tabBar addSubview:tabBarView];
	self.tabBarView = tabBarView;
}

- (void)viewSafeAreaInsetsDidChange {
	[super viewSafeAreaInsetsDidChange];
	
	CGFloat safeBottom = self.view.up_safeAreaInsets.bottom;
	
	CGRect rect = self.tabBarView.frame;
	rect.size.height += safeBottom;
	self.tabBarView.frame = rect;
	self.tabBarView.afeAreaBottom = safeBottom;
}


#pragma mark - TabbarViewDelegate

- (void)tabBar:(TabBarView *)tabBar didSelectItemAtIndex:(NSInteger)index {
	self.selectedIndex = index;
}

@end
