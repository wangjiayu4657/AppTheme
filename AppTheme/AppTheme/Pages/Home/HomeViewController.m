//
//  HomeViewController.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/2.
//

#import "HomeViewController.h"
#import "SettingViewController.h"
#import "Aspects.h"


@interface HomeViewController ()
@property(nonatomic, assign) SkinType skinType;
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
//	[self aspect_hookSelector:@selector(viewWillAppear:)
//								withOptions:AspectPositionAfter
//								 usingBlock:^(id<AspectInfo> aspectInfo,BOOL animation){
//		NSLog(@"================");
//	} error:nil];
}


#pragma mark - events

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	if(self.skinType == SkinTypeLight) {
		self.skinType = SkinTypeDark;
	} else if(self.skinType == SkinTypeDark) {
		self.skinType = SkinTypeLight;
	}
	
	[[ThemeManager manager] updateSkinType:self.skinType];
}


#pragma mark - getter


@end
