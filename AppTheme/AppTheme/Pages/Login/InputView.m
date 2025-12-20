//
//  InputView.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/16.
//

#import "InputView.h"

@interface InputView()

@property(nonatomic, strong) UILabel *leadingLb;
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UIButton *codeBtn;
@property(nonatomic, strong) UIView *verticalLine;
@property(nonatomic, strong) UIView *horizontalLine;

@end


@implementation InputView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self jy_layoutSubviews];
	}
	return self;
}


#pragma mark - 设置 UI

- (void)jy_layoutSubviews {
	[self addSubview:self.leadingLb];
	[self.leadingLb mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(12);
		make.centerY.equalTo(self);
		make.width.mas_equalTo(50);
	}];
	
	[self addSubview:self.verticalLine];
	[self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(12);
		make.left.equalTo(self.leadingLb.mas_right).offset(8);
		make.bottom.mas_equalTo(-12);
		make.width.mas_equalTo(1);
	}];
	
	[self addSubview:self.textField];
	[self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.verticalLine.mas_right).offset(15);
		make.top.bottom.equalTo(self);
	}];
	
	[self addSubview:self.codeBtn];
	[self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(-12);
		make.top.bottom.equalTo(self);
	}];
	
	[self addSubview:self.horizontalLine];
	[self.horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(12);
		make.right.mas_equalTo(-12);
		make.bottom.equalTo(self);
		make.height.mas_equalTo(1);
	}];
}


#pragma mark - events

- (void)codeClick {
	NSLog(@"开始计时...");
}


#pragma mark - setter

- (void)setIsShowCodeBtn:(BOOL)isShowCodeBtn {
	_isShowCodeBtn = isShowCodeBtn;
	self.codeBtn.hidden = !isShowCodeBtn;
}

- (void)setIsShowVerticalLine:(BOOL)isShowVerticalLine {
	_isShowVerticalLine = isShowVerticalLine;
	self.verticalLine.hidden = !isShowVerticalLine;
}

- (void)setLeadingText:(NSString *)leadingText {
	_leadingText = leadingText;
	self.leadingLb.text = leadingText;
}

- (void)setPlaceholder:(NSString *)placeholder {
	_placeholder = placeholder;
	
	NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:placeholder];
	[attribute addAttributes:@{
		NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]
	} range:NSMakeRange(0, placeholder.length)];
	
	self.textField.attributedPlaceholder = attribute;
}


#pragma mark - getter

- (UILabel *)leadingLb {
	if (!_leadingLb) {
		_leadingLb = [[UILabel alloc] init];
		_leadingLb.text = @"+86";
		_leadingLb.textColor = [UIColor blackColor];
		_leadingLb.font = [UIFont systemFontOfSize:14];
		_leadingLb.textAlignment = NSTextAlignmentCenter;
	}
	return _leadingLb;
}

- (UITextField *)textField {
	if (!_textField) {
		_textField = [[UITextField alloc] init];
		_textField.font = [UIFont systemFontOfSize:14];
		_textField.textColor = [UIColor colorWithHexString:@"#333333"];
	}
	return _textField;
}

- (UIButton *)codeBtn {
	if (!_codeBtn) {
		_codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		_codeBtn.hidden = YES;
		_codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
		[_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
		[_codeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[_codeBtn addTarget:self action:@selector(codeClick) forControlEvents:UIControlEventTouchUpInside];
	}
	return _codeBtn ;
}

- (UIView *)verticalLine {
	if (!_verticalLine) {
		_verticalLine = [[UIView alloc] init];
		_verticalLine.hidden = YES;
		_verticalLine.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
	}
	return _verticalLine;
}

- (UIView *)horizontalLine {
	if (!_horizontalLine) {
		_horizontalLine = [[UIView alloc] init];
		_horizontalLine.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
	}
	return _horizontalLine;
}

- (NSString *)inputText {
	return self.textField.text;
}

@end
