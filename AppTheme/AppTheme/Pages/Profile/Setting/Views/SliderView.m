//
//  SliderView.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/9.
//

#import "SliderView.h"
#import "StepSlider.h"
#import "FontManager.h"

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
	self.backgroundColor = UIColor.whiteColor;
	
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
	NSLog(@"value == %f", value);
	
	FontScale fontScale = [self getFontScale:value / 10];
	[[FontManager sharedManager] updateFontScale:fontScale];
}


#pragma mark - private

- (FontScale)getFontScale:(CGFloat)scale {
	FontScale fontScale = FontScale10;
	
	if(scale == 1.0) {
		fontScale = FontScale10;
	} else if(scale == 1.1) {
		fontScale = FontScale11;
	} else if(scale == 1.2) {
		fontScale = FontScale12;
	} else if(scale == 1.3) {
		fontScale = FontScale13;
	} else if(scale == 1.4) {
		fontScale = FontScale14;
	} else if(scale == 1.5) {
		fontScale = FontScale15;
	} else if(scale == 1.6) {
		fontScale = FontScale16;
	}
	
	return fontScale;
}


#pragma mark - getter

- (UILabel *)smallLb {
	if (!_smallLb) {
		_smallLb = [[UILabel alloc] init];
		_smallLb.text = @"A";
		_smallLb.textColor = [UIColor blackColor];
		_smallLb.font = [UIFont systemFontOfSize:12];
	}
	return _smallLb;
}

- (UILabel *)standardLb {
	if (!_standardLb) {
		_standardLb = [[UILabel alloc] init];
		_standardLb.text = @"标准";
		_standardLb.textColor = [UIColor blackColor];
		_standardLb.font = [UIFont systemFontOfSize:14];
	}
	return _standardLb;
}

- (UILabel *)largerLb {
	if (!_largerLb) {
		_largerLb = [[UILabel alloc] init];
		_largerLb.text = @"A";
		_largerLb.textColor = [UIColor blackColor];
		_largerLb.font = [UIFont systemFontOfSize:24];
	}
	return _largerLb;
}

- (StepSlider *)slider {
	if (!_slider) {
		_slider = [[StepSlider alloc] init];
		_slider.stepValue = 1;
		_slider.minimumValue = 10;
		_slider.maximumValue = 16;
		_slider.value = [FontManager sharedManager].fontScale * 10;
		_slider.delegate = self;
	}
	return _slider;
}

@end
