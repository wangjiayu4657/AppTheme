//
//  LoginView.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/16.
//

#import "LoginView.h"
#import "InputView.h"

@interface LoginView()<UITextViewDelegate>
@property(nonatomic, strong) UILabel *titleLb;								//标题
@property(nonatomic, strong) InputView *accountInputView;			//账号输入文本框
@property(nonatomic, strong) InputView *codeInputView;				//验证码输入文本框
@property(nonatomic, strong) UIButton *checkBtn;							//检查按钮
@property(nonatomic, strong) UITextView *textView;						//协议内容
@property(nonatomic, strong) UIButton *sureBtn;								//确定按钮
@end


@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self jy_layoutSubviews];
		[self handlerProtocolContent];
	}
	return self;
}


#pragma mark - 设置 UI

- (void)jy_layoutSubviews {
	self.backgroundColor = UIColor.jy_bgContentColor;
	
	[self addSubview:self.titleLb];
	[self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(12);;
		make.left.mas_equalTo(12);
	}];
	
	[self addSubview:self.accountInputView];
	[self.accountInputView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.titleLb.mas_bottom).offset(40);
		make.left.equalTo(self.titleLb.mas_left);
		make.right.mas_equalTo(-12);
		make.height.mas_equalTo(48);
	}];
	
	[self addSubview:self.codeInputView];
	[self.codeInputView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.accountInputView.mas_bottom);
		make.left.right.height.equalTo(self.accountInputView);
	}];
	
	[self addSubview:self.checkBtn];
	[self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(15);
		make.top.equalTo(self.codeInputView.mas_bottom).offset(15);
		make.width.height.mas_equalTo(16);
	}];
	
	[self addSubview:self.textView];
	[self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.checkBtn.mas_right).offset(4);
		make.top.equalTo(self.checkBtn.mas_top).offset(-9);
		make.right.equalTo(self.codeInputView.mas_right);
		make.height.mas_equalTo(58);
	}];
	
	[self addSubview:self.sureBtn];
	[self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.textView.mas_bottom).offset(15);
		make.left.mas_equalTo(15);
		make.right.mas_equalTo(-15);
		make.height.mas_equalTo(44);
		make.bottom.mas_equalTo(-12);
	}];
}


#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView
		shouldInteractWithURL:(NSURL *)URL
				 inRange:(NSRange)characterRange
		 interaction:(UITextItemInteraction)interaction{
	NSLog(@"点击的文本: %@", URL.absoluteString);
	
	return YES;
}


#pragma mark - event

- (void)checkBtnClick:(UIButton *)btn {
	btn.selected = !btn.selected;
}

- (void)sureBtnClick {
	
}


#pragma mark - private

- (void)handlerProtocolContent {
	NSString *leadingText = @"我已阅读并同意";
	NSString *serviceText = @"华安证券服务协议、";
	NSString *privateText = @"华安证券互联网平台隐私条款";
	NSString *trailingText = @",未注册的手机号将自动注册";
	NSString *content = [NSString stringWithFormat:@"%@%@%@%@",leadingText,serviceText,privateText,trailingText];
	NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:content];
	
	NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
	style.lineSpacing = 6;
	
	[attributedText addAttributes:@{
		NSParagraphStyleAttributeName: style,
		NSFontAttributeName : [UIFont systemFontOfSize:12],
		NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]
	} range:NSMakeRange(0, content.length)];
	
	NSRange serviceRange = [content rangeOfString:serviceText];
	[attributedText addAttributes:@{
		NSLinkAttributeName : @"service",
		NSForegroundColorAttributeName: [UIColor blueColor],
	} range:serviceRange];
	
	NSRange privateRange = [content rangeOfString:privateText];
	[attributedText addAttributes:@{
		NSLinkAttributeName : @"private",
		NSForegroundColorAttributeName: [UIColor blueColor],
	} range:privateRange];
	
	self.textView.attributedText = attributedText;
}


#pragma mark - setter


#pragma mark - getter

- (UILabel *)titleLb {
	if (!_titleLb) {
		_titleLb = [[UILabel alloc] init];
		_titleLb.text = @"手机号注册/登录";
		_titleLb.textColor = UIColor.jy_textPrimaryColor;
		_titleLb.font = [UIFont boldSystemFontOfSize:18];
	}
	return _titleLb;
}

- (InputView *)accountInputView {
	if (!_accountInputView) {
		_accountInputView = [[InputView alloc] init];
		_accountInputView.leadingText = @"+86";
		_accountInputView.isShowVerticalLine = YES;
		_accountInputView.placeholder = @"请输入手机号";
	}
	return _accountInputView;
}

- (InputView *)codeInputView {
	if (!_codeInputView) {
		_codeInputView = [[InputView alloc] init];
		_codeInputView.isShowCodeBtn = YES;
		_codeInputView.isShowVerticalLine = NO;
		_codeInputView.leadingText = @"验证码";
		_codeInputView.placeholder = @"请输入验证码";
	}
	return _codeInputView;
}

- (UIButton *)checkBtn {
	if (!_checkBtn) {
		_checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[_checkBtn setImage:[UIImage imageNamed:@"check_unselect"] forState:UIControlStateNormal];
		[_checkBtn setImage:[UIImage imageNamed:@"check_selected"] forState:UIControlStateSelected];
		[_checkBtn addTarget:self action:@selector(checkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _checkBtn ;
}

- (UITextView *)textView{
	if (!_textView) {
		_textView = [[UITextView alloc] init];
		_textView.delegate = self;
		_textView.editable = NO;
		_textView.scrollEnabled = NO;
		_textView.font = [UIFont systemFontOfSize:12];
		_textView.backgroundColor = UIColor.jy_bgContentColor;
	}
	return _textView;
}

- (UIButton *)sureBtn {
	if (!_sureBtn) {
		_sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		_sureBtn.layer.cornerRadius = 22;
		_sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
		_sureBtn.backgroundColor = [UIColor colorWithHexString:@"#f25c5c"];
		[_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
		[_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
	}
	return _sureBtn ;
}

@end
