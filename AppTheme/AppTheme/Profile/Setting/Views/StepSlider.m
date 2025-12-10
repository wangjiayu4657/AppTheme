//
//  StepSlider.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/9.
//

#import "StepSlider.h"

@implementation StepSlider

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		_stepValue = 1.0f;
		[self addTarget:self
						 action:@selector(sliderValueChanged:)
	 forControlEvents:UIControlEventValueChanged];
		
		[self addTapGesture];
	}
	return self;
}

- (void)addTapGesture {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
	[self addGestureRecognizer:tap];
}


#pragma mark - events

- (void)handleTap:(UITapGestureRecognizer *)gesture {
	// 获取点击点在视图坐标系中的位置
	CGPoint location = [gesture locationInView:gesture.view];
	CGFloat itemWidth = (self.up_width / 6);
	CGFloat item = round(location.x / itemWidth) + 1;
	CGFloat stepValue = item * self.stepValue + 10;
	[super setValue:stepValue animated:NO];
	
	if(self.delegate && [self.delegate respondsToSelector:@selector(slider:valueDidChanged:)]) {
		[self.delegate slider:self valueDidChanged:stepValue];
	}
}

- (void)sliderValueChanged:(UISlider *)slider {
	// 计算最接近的步进值
	CGFloat newValue = round(slider.value / self.stepValue) * self.stepValue;
	
	// 如果值有变化，更新 slider
	if (newValue != slider.value) {
		[slider setValue:newValue animated:YES];
	}
}


#pragma mark - setter

- (void)setValue:(float)value {
	CGFloat steppedValue = round(value / self.stepValue) * self.stepValue;
	
	if(steppedValue != self.value) { // 如果值有变化，更新 slider
		[super setValue:steppedValue];
		
		if(self.delegate && [self.delegate respondsToSelector:@selector(slider:valueDidChanged:)]) {
			[self.delegate slider:self valueDidChanged:steppedValue];
		}
	}
}

// 重写 setValue:animated: 方法确保步进
- (void)setValue:(float)value animated:(BOOL)animated {
	CGFloat steppedValue = round(value / self.stepValue) * self.stepValue;
	
	if(steppedValue != self.value) { // 如果值有变化，更新 slider
		[super setValue:steppedValue animated:animated];
		
		if(self.delegate && [self.delegate respondsToSelector:@selector(slider:valueDidChanged:)]) {
			[self.delegate slider:self valueDidChanged:steppedValue];
		}
	}
}

@end
