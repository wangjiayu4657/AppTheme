//
//  SliderView.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/9.
//

#import "SliderView.h"
#import "StepSlider.h"

@interface SliderView()<StepSliderDelegate>

@property(nonatomic, strong) UILabel *smallLb;
@property(nonatomic, strong) UILabel *standardLb;
@property(nonatomic, strong) UILabel *largerLb;
@property(nonatomic, strong) StepSlider *slider;

@end


@implementation SliderView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self jy_layoutSubviews];
	}
	return self;
}


#pragma mark - 设置 UI

- (void)jy_layoutSubviews {
	self.backgroundColor = UIColor.jy_bgContentColor;
	
	[self addSubview:self.slider];
	[self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(20);
		make.right.mas_equalTo(-20);
		make.height.mas_equalTo(20);
		make.centerY.equalTo(self);
	}];
	
	[self addSubview:self.smallLb];
	[self.smallLb mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.slider);
		make.bottom.equalTo(self.slider.mas_top).offset(-15);
	}];
	
	[self addSubview:self.standardLb];
	[self.standardLb mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.smallLb.mas_right).offset(15);
		make.centerY.equalTo(self.smallLb.mas_centerY);
	}];
	
	[self addSubview:self.largerLb];
	[self.largerLb mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.equalTo(self.slider.mas_right);
		make.centerY.equalTo(self.smallLb.mas_centerY);
	}];
}


#pragma mark - StepSliderDelegate

- (void)slider:(StepSlider *)slider valueDidChanged:(CGFloat)value {
	FontType fontType = [self getFontTypeWithValue:value];
	
	if(self.delegate && [self.delegate respondsToSelector:@selector(sliderView:updateFontScale:FontType:)]) {
		[self.delegate sliderView:self updateFontScale:value/100 FontType:fontType];
	}
}


#pragma mark - private

- (FontType)getFontTypeWithValue:(CGFloat)value {
	FontType fontType = FontType100;
	
	if(value == 95) {
		fontType = FontType095;
	} else if(value == 100) {
		fontType = FontType100;
	} else if(value == 105) {
		fontType = FontType105;
	} else if(value == 110) {
		fontType = FontType110;
	} else if(value == 115) {
		fontType = FontType115;
	} else if(value == 120) {
		fontType = FontType120;
	} else if(value == 125) {
		fontType = FontType125;
	}  else if(value == 130) {
		fontType = FontType130;
	}
	
	return fontType;
}


#pragma mark - getter

- (UILabel *)smallLb {
	if (!_smallLb) {
		_smallLb = [[UILabel alloc] init];
		_smallLb.text = @"A";
		_smallLb.textColor = UIColor.jy_textPrimaryColor;
		_smallLb.font = [UIFont systemFontOfSize:12];
	}
	return _smallLb;
}

- (UILabel *)standardLb {
	if (!_standardLb) {
		_standardLb = [[UILabel alloc] init];
		_standardLb.text = @"标准";
		_standardLb.textColor = UIColor.jy_textPrimaryColor;
		_standardLb.font = [UIFont systemFontOfSize:14];
	}
	return _standardLb;
}

- (UILabel *)largerLb {
	if (!_largerLb) {
		_largerLb = [[UILabel alloc] init];
		_largerLb.text = @"A";
		_largerLb.textColor = UIColor.jy_textPrimaryColor;
		_largerLb.font = [UIFont systemFontOfSize:18];
	}
	return _largerLb;
}

- (StepSlider *)slider {
	if (!_slider) {
		_slider = [[StepSlider alloc] init];
		_slider.stepValue = 5;
		_slider.minimumValue = 95;
		_slider.maximumValue = 125;
		_slider.value = [ThemeManager manager].fontScale * 100;
		_slider.delegate = self;
	}
	return _slider;
}

@end
