//
//  SettingCell.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/8.
//

#import "SettingCell.h"


@interface SettingCell()

@property(nonatomic, strong) UILabel *titleLb;
@property(nonatomic, strong) UISwitch *switchBtn;
@property(nonatomic, strong) UIImageView *arrowImgView;
@property(nonatomic, strong) UIView *lineView;

@property(nonatomic, assign) SettingCellRihgtStyle style;
@end


@implementation SettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		[self jy_layoutSubviews];
	}
	return self;
}

#pragma mark - 设置 UI

- (void)jy_layoutSubviews {
	[self.contentView addSubview:self.titleLb];
	[self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.left.mas_equalTo(15);
		make.bottom.mas_equalTo(-15);
		make.height.mas_equalTo(18);
	}];
	
	[self.contentView addSubview:self.switchBtn];
	[self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(-15);
		make.centerY.equalTo(self.contentView.mas_centerY);
	}];
	
	[self.contentView addSubview:self.arrowImgView];
	[self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(-15);
		make.centerY.equalTo(self.contentView.mas_centerY);
		make.width.height.mas_equalTo(16);
	}];
	
	[self.contentView addSubview:self.lineView];
	[self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.bottom.equalTo(self.contentView.mas_bottom);
		make.right.mas_equalTo(-15);
		make.height.mas_equalTo(1);
	}];
}


#pragma mark - events

- (void)switchBtnChanged:(UISwitch *)switchBtn {
	NSLog(@"切换 ---");
	self.callBack ? self.callBack() : nil;
}


#pragma mark - setter

- (void)setParam:(NSDictionary *)param {
	_param = param;
	
	self.titleLb.text = param[@"title"];
	self.style = [param[@"style"] integerValue];
	
	self.switchBtn.hidden = !(self.style == SettingCellRihgtStyleSwitch);
	self.arrowImgView.hidden = !(self.style == SettingCellRihgtStyleArrow);
}


#pragma mark - getter

- (UILabel *)titleLb {
	if (!_titleLb) {
		_titleLb = [[UILabel alloc] init];
		_titleLb.text = @"--";
		_titleLb.textColor = [UIColor blackColor];
		_titleLb.font = [UIFont systemFontOfSize:16];
	}
	return _titleLb;
}

- (UISwitch *)switchBtn {
	if (!_switchBtn) {
		_switchBtn = [[UISwitch alloc] init];
		_switchBtn.hidden = YES;
		[_switchBtn addTarget:self action:@selector(switchBtnChanged:) forControlEvents:UIControlEventValueChanged];
	}
	return _switchBtn;
}

- (UIImageView *)arrowImgView {
	if (!_arrowImgView) {
		_arrowImgView = [[UIImageView alloc] init];
		_arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
		_arrowImgView.image = [UIImage imageNamed:@"right_arrow_grey"];
	}
	return _arrowImgView;
}

- (UIView *)lineView {
	if (!_lineView) {
		_lineView = [[UIView alloc] init];
		_lineView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
	}
	return _lineView;
}

@end
