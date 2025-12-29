//
//  ThemeFontViewController.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/8.
//

#import "ThemeFontViewController.h"
#import "NavigationBar.h"
#import "FontSenderCell.h"
#import "FontReceiverCell.h"
#import "SliderView.h"
#import "FontManager.h"


static NSString * const kFontSenderCellID = @"kFontSenderCellID";
static NSString * const kFontReceiverCellID = @"kFontReceiverCellID";

@interface ThemeFontViewController ()<UITableViewDelegate, UITableViewDataSource, SliderViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) SliderView *sliderView;
@property(nonatomic, strong) NSArray<NSArray<NSDictionary *> *> *sources;

@property(nonatomic, assign) FontType fontType;
@property(nonatomic, assign) CGFloat originalScale;

@end


@implementation ThemeFontViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"设置字体大小";
	self.backBtnTitle = @"取消";
	self.moreBtnTitle = @"完成";
	self.originalScale = [FontManager sharedManager].fontScale;
	
	[self initData];
	[self jy_layoutSubviews];
}

- (void)themeFontSizeDidChanged {
	[self.tableView reloadData];
}


#pragma mark - 设置 UI

- (void)jy_layoutSubviews {
	[self.view addSubview:self.tableView];
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.top.right.equalTo(self.view);
	}];
	
	[self.view addSubview:self.sliderView];
	[self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.tableView.mas_bottom);
		make.left.bottom.right.equalTo(self.view);
		make.height.mas_equalTo(120);
	}];
}

- (void)initData {
	self.sources = @[
		@[
			@{
				@"content": @"预览字体大小",
				@"isSender": @(YES)
			}
		],
		@[
			@{
				@"content": @"拖动下面的滑块, 可设置字体大小",
				@"isSender": @(NO)
			}
		],
		@[
			@{
				@"content": @"设置后, 会改变聊天和朋友圈中的字体大小. 如果在使用过程中存在问题或意见, 可以反馈给coderJy团队",
				@"isSender": @(NO)
			}
		],
	];
	
	[self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.sources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.sources[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *param = self.sources[indexPath.section][indexPath.row];
	BOOL isSender = [param[@"isSender"] boolValue];
	
	UITableViewCell *cell;
	
	if(isSender) {
		FontSenderCell *senderCell = [tableView dequeueReusableCellWithIdentifier:kFontSenderCellID forIndexPath:indexPath];
		senderCell.param = param;
		cell = senderCell;
	} else {
		FontReceiverCell *receiverCell = [tableView dequeueReusableCellWithIdentifier:kFontReceiverCellID forIndexPath:indexPath];
		receiverCell.param = param;
		cell = receiverCell;
	}
	
	return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return section == 0 ? 24 : 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *headerView = [[UIView alloc] init];
//	headerView.backgroundColor = UIColor.clearColor;
	return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	UIView *footerView = [[UIView alloc] init];
//	footerView.backgroundColor = UIColor.clearColor;
	return footerView;
}


#pragma mark - SliderViewDelegate

- (void)sliderView:(SliderView *)sliderView updateFontScale:(CGFloat)fontScale FontType:(FontType)fontType {
	self.fontType = fontType;
	[FontManager sharedManager].fontScale = fontScale;
	[self.tableView reloadData];
}


#pragma mark - events

- (void)backBtnClick {
	[FontManager sharedManager].fontScale = self.originalScale;
	[super backBtnClick];
}

- (void)moreBtnClick {
	[[FontManager sharedManager] updateFontType:self.fontType];
	[self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - getter

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		_tableView.estimatedRowHeight = 34;
		_tableView.rowHeight = UITableViewAutomaticDimension;
		_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_tableView.backgroundColor = UIColor.jy_bgColor;
		[_tableView registerClass:[FontSenderCell class] forCellReuseIdentifier:kFontSenderCellID];
		[_tableView registerClass:[FontReceiverCell class] forCellReuseIdentifier:kFontReceiverCellID];
	}
	return _tableView;
}

- (SliderView *)sliderView {
	if (!_sliderView) {
		_sliderView = [[SliderView alloc] init];
		_sliderView.delegate = self;
	}
	return _sliderView;
}

@end
