//
//  NavigationBar.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/3.
//

#import "NavigationBar.h"
#import "Masonry.h"


@interface NavigationBar()

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIImageView *bgImgView;

@property (nonatomic, strong) UIView *middleView;


@end


@implementation NavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self jy_layoutSubviews];
	}
	return self;
}


#pragma mark - 设置 UI

- (void)jy_layoutSubviews {
	[self addSubview:self.bgImgView];
	[self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self);
	}];
	
	//中间视图
	if(self.delegate && [self.delegate respondsToSelector:@selector(titleViewForNavigationBar)]) {
		self.middleView = [self.delegate titleViewForNavigationBar];
		
		[self addSubview:self.middleView];
		[self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(62);
			make.centerX.equalTo(self.mas_centerX);
			make.width.mas_equalTo(self.mas_width).multipliedBy(0.3);
		}];
	} else {
		self.middleView = self.titleLb;
		
		[self addSubview:self.middleView];
		[self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(62);
			make.centerX.equalTo(self);
		}];
	}
	
	//左边视图
	if(self.delegate && [self.delegate respondsToSelector:@selector(leadingViewForNavigationBar)]) {
		UIView *leadingView = [self.delegate leadingViewForNavigationBar];
		[self addSubview:leadingView];
		[leadingView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(15);
			make.centerY.equalTo(self.middleView.mas_centerY);
		}];
	} else {
		[self addSubview:self.backBtn];
		[self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(15);
			make.centerY.equalTo(self.middleView.mas_centerY);
		}];
	}
	
	//右边视图
	if(self.delegate && [self.delegate respondsToSelector:@selector(trailingViewForNavigationBar)]) {
		UIView *trailingView = [self.delegate trailingViewForNavigationBar];
		[self addSubview:trailingView];
		[trailingView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.mas_equalTo(-15);
			make.centerY.equalTo(self.middleView.mas_centerY);
		}];
	} else {
		[self addSubview:self.moreBtn];
		[self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.mas_equalTo(-15);
			make.centerY.equalTo(self.middleView.mas_centerY);
		}];
	}
}


#pragma mark - events

- (void)backBtnClick {
	NSLog(@"返回");
	
	if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedBack)]) {
		[self.delegate didSelectedBack];
	}
}

- (void)moreBtnClick {
	NSLog(@"更多");
	
	if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedMore)]) {
		[self.delegate didSelectedMore];
	}
}


#pragma mark - setter

- (void)setTopSafeArea:(CGFloat)topSafeArea {
	_topSafeArea = topSafeArea;
	
	if(topSafeArea == 62) return;
	[self.middleView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(topSafeArea);
	}];
}

- (void)setTitle:(NSString *)title {
	_title = title;
	self.titleLb.text = title;
}

- (void)setBgImgName:(NSString *)bgImgName {
	_bgImgName = bgImgName;
	
	self.bgImgView.hidden = !bgImgName.length;
	self.bgImgView.image = [UIImage imageNamed:bgImgName];
}

- (void)setTextColor:(UIColor *)textColor {
	_textColor = textColor;
	
	self.titleLb.textColor = textColor;
	[self.backBtn setTitleColor:textColor forState:UIControlStateNormal];
	[self.moreBtn setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)setIsHiddenBackBtn:(BOOL)isHiddenBackBtn {
	_isHiddenBackBtn = isHiddenBackBtn;
	
	self.backBtn.hidden = isHiddenBackBtn;
}

- (void)setIsHiddenRightBtn:(BOOL)isHiddenRightBtn {
	_isHiddenRightBtn = isHiddenRightBtn;
	
	self.moreBtn.hidden = isHiddenRightBtn;
}

- (void)setRightBtnTitle:(NSString *)rightBtnTitle {
	_rightBtnTitle = rightBtnTitle;
	
	[self.moreBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
}

- (void)setRightBtnImgName:(NSString *)rightBtnImgName {
	_rightBtnImgName = rightBtnImgName;
	
	UIImage *btnImg = [UIImage imageNamed:rightBtnImgName];
	[self.moreBtn setImage:btnImg forState:UIControlStateNormal];
}


#pragma mark - getter

- (UIImageView *)bgImgView {
	if (!_bgImgView) {
		_bgImgView = [[UIImageView alloc] init];
		_bgImgView.contentMode = UIViewContentModeScaleAspectFill;
		_bgImgView.hidden = YES;
	}
	return _bgImgView;
}

- (UILabel *)titleLb {
	if (!_titleLb) {
		_titleLb = [[UILabel alloc] init];
		_titleLb.text = @"";
		_titleLb.textColor = [UIColor blackColor];
		_titleLb.font = [UIFont boldSystemFontOfSize:18];
	}
	return _titleLb;
}

- (UIButton *)backBtn {
	if (!_backBtn) {
		_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		_backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
		[_backBtn setImage:[UIImage imageNamed:@"nav_arrow_left_white"] forState:UIControlStateNormal];
		[_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
	}
	return _backBtn ;
}

- (UIButton *)moreBtn {
	if (!_moreBtn) {
		_moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		_moreBtn.titleLabel.font = [UIFont systemFontOfSize:16];
		[_moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
	}
	return _moreBtn ;
}

@end
