//
//  SettingViewController.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/3.
//

#import "SettingViewController.h"
#import "ThemeFontViewController.h"
#import "LoginViewController.h"
#import "SettingCell.h"

typedef enum : NSUInteger {
	SettingCellTypeInformation,					//个人资料
	SettingCellTypeAcountSafe,					//账号安全
	SettingCellTypeThemeSkin,						//主题皮肤
	SettingCellTypeThemeFont,						//主题字体
	SettingCellTypeThemeLanguage,			  //主题语言
	SettingCellTypeNotification,				//通知
	SettingCellTypeDevice,							//设备
	SettingCellTypeInformationRights,		//个人信息与权限
	SettingCellTypeInformationList,			//个人信息收集清单
	SettingCellTypeShareList,						//第三方信息共享清单
	SettingCellTypeLoginOut		  				//退出登录
} SettingCellType;

static NSString * const kSettingCellID = @"kSettingCellID";

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray<NSArray<NSDictionary *> *> *sources;
@end


@implementation SettingViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"设置";
	self.view.backgroundColor = UIColor.jy_bgContentColor;
	
	[self initDataSource];
	[self jy_layoutSubviews];
}


- (void)initDataSource {
	self.hidesNavigationBarWhenPush = NO;
	
	self.sources = @[
		@[
			@{
				@"title": @"个人资料",
				@"style": @(SettingCellRihgtStyleArrow),
				@"type": @(SettingCellTypeInformation)
			},
			@{
				@"title": @"账号安全",
				@"style": @(SettingCellRihgtStyleArrow),
				@"type" : @(SettingCellTypeAcountSafe)
			}
		],
		@[
			@{
				@"title": @"主题皮肤",
				@"style": @(SettingCellRihgtStyleArrow),
				@"type" : @(SettingCellTypeThemeSkin)
			},
			@{
				@"title": @"主题字体",
				@"style": @(SettingCellRihgtStyleArrow),
				@"type" : @(SettingCellTypeThemeFont)
			},
			@{
				@"title": @"主题语言",
				@"style": @(SettingCellRihgtStyleArrow),
				@"type" : @(SettingCellTypeThemeLanguage)
			}
		],
		@[
			@{
				@"title": @"通知",
				@"style": @(SettingCellRihgtStyleArrow),
				@"type" : @(SettingCellTypeNotification)
			},
			@{
				@"title": @"设备",
				@"style": @(SettingCellRihgtStyleArrow),
				@"type" : @(SettingCellTypeDevice)
			}
		],
		@[
			@{
				@"title": @"个人信息与权限",
				@"style": @(SettingCellRihgtStyleArrow),
				@"type" : @(SettingCellTypeInformationRights)
			},
			@{
				@"title": @"个人信息收集清单",
				@"style": @(SettingCellRihgtStyleArrow),
				@"type" : @(SettingCellTypeInformationList)
			},
			@{
				@"title": @"第三方信息共享清单",
				@"style": @(SettingCellRihgtStyleArrow),
				@"type" : @(SettingCellTypeShareList)
			}
		],
		@[
			@{
				@"title": @"退出登录",
				@"style": @(SettingCellRihgtStyleNone),
				@"type" : @(SettingCellTypeLoginOut)
			}
		]
	];
}


#pragma mark - 设置 UI

- (void)jy_layoutSubviews {
	[self.view addSubview:self.tableView];
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.sources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.sources[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingCellID forIndexPath:indexPath];
	cell.param = self.sources[indexPath.section][indexPath.row];
	cell.callBack = [self callBack];
	return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	UIView *footerView = [[UIView alloc] init];
	return footerView;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	NSDictionary *param = self.sources[indexPath.section][indexPath.row];
	SettingCellType type = [param[@"type"] integerValue];
	[self gotoTargetControllerWithType:type];
}


#pragma mark - events

- (void)moreBtnClick {
	NSLog(@"更多");
}


#pragma mark - private

- (void(^)(void))callBack {
	return ^{
		
	};
}

- (void)gotoTargetControllerWithType:(SettingCellType)type {
	switch (type) {
		case SettingCellTypeInformation: {
			
		} break;
			
		case SettingCellTypeAcountSafe: {
			
		}	break;
			
		case SettingCellTypeThemeSkin: {
			
		}	break;
			
		case SettingCellTypeThemeFont: {
			ThemeFontViewController *fontCtrl = [[ThemeFontViewController alloc] init];
			[self.navigationController pushViewController:fontCtrl animated:YES];
		} break;
			
		case SettingCellTypeThemeLanguage: {
			
		}	break;
	
		case SettingCellTypeNotification: {
	
		}	break;
			
		case SettingCellTypeDevice: {
			
		} break;
			
		case SettingCellTypeInformationRights: {
			
		}	break;
			
		case SettingCellTypeInformationList: {
			
		}	break;
			
		case SettingCellTypeShareList: {
			
		}	break;
			
		case SettingCellTypeLoginOut: {
			LoginViewController *loginCtrl = [[LoginViewController alloc] init];
			loginCtrl.modalPresentationStyle = UIModalPresentationFullScreen;
			[self.navigationController presentViewController:loginCtrl animated:YES completion:nil];
		} break;
			
		default:
			break;
	}
}


#pragma mark - getter

- (NSString *)moreBtnImgName {
	return @"设置-更多";
}

- (UIImage *)navigationBarBackImage {
	return [UIImage imageNamed:@"left_arrow_white"];
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.sectionHeaderHeight = 0;
		_tableView.sectionFooterHeight = 10;
		_tableView.estimatedRowHeight = 44;
		_tableView.rowHeight = UITableViewAutomaticDimension;
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_tableView.backgroundColor = UIColor.jy_bgColor;
		[_tableView registerClass:[SettingCell class] forCellReuseIdentifier:kSettingCellID];
	}
	return _tableView;
}

@end
