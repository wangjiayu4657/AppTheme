//
//  TabbarView.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/2.
//

#import "TabBarView.h"
#import "Masonry.h"

@interface TabBarItem : UIView

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIImageView *normalImgView;
@property (nonatomic, strong) UIImageView *selectedImgView;

@end


@implementation TabBarItem

- (instancetype)initWithFrame:(CGRect)frame
												title:(NSString *)title
									normalImage:(NSString *)normalImage
								selectedImage:(NSString *)selectedImage {
	self = [super initWithFrame:frame];
	if (self) {
		[self jy_layoutSubviews];
		
		self.titleLb.text = title;
		self.normalImgView.image = [UIImage imageNamed:normalImage];
		self.selectedImgView.image = [UIImage imageNamed:selectedImage];
	}
	return self;
}


#pragma mark - 设置 UI

- (void)jy_layoutSubviews {
	[self addSubview:self.normalImgView];
	[self.normalImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_offset(12);
		make.left.right.equalTo(self);
		make.height.mas_equalTo(24);
	}];
	
	[self addSubview:self.selectedImgView];
	[self.selectedImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_offset(12);
		make.left.right.equalTo(self);
		make.height.mas_equalTo(24);
	}];
	
	[self addSubview:self.titleLb];
	[self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.selectedImgView.mas_bottom).offset(4);
		make.left.right.equalTo(self);
	}];
}


#pragma mark - setter

- (void)setSelected:(BOOL)selected {
	_selected = selected;
	
	self.normalImgView.hidden = selected;
	self.selectedImgView.hidden = !selected;
	self.titleLb.textColor = selected ? [UIColor redColor] : [UIColor blackColor];
}


#pragma mark - getter

- (UILabel *)titleLb {
	if (!_titleLb) {
		_titleLb = [[UILabel alloc] init];
		_titleLb.textColor = [UIColor blackColor];
		_titleLb.textAlignment = NSTextAlignmentCenter;
		_titleLb.font = [UIFont boldSystemFontOfSize:12];
	}
	return _titleLb;
}

- (UIImageView *)normalImgView {
	if (!_normalImgView) {
		_normalImgView = [[UIImageView alloc] init];
		_normalImgView.contentMode = UIViewContentModeScaleAspectFit;
	}
	return _normalImgView;
}

- (UIImageView *)selectedImgView {
	if (!_selectedImgView) {
		_selectedImgView = [[UIImageView alloc] init];
		_selectedImgView.contentMode = UIViewContentModeScaleAspectFit;
	}
	return _selectedImgView;
}

@end




@interface TabBarView()

@property (nonatomic, strong) NSArray<TabBarItem *> *items;

@end


@implementation TabBarView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {

	}
	return self;
}


#pragma mark - 设置 UI

- (void)jy_layoutSubviews {
	if(!self.items.count) return;
	
	self.backgroundColor = UIColor.whiteColor;
	
	NSInteger count = self.items.count;
	CGFloat itemWidth = (self.frame.size.width - 8 * 2 - (count - 1) * 8) / count;
	
	[self.items mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:8 leadSpacing:8 tailSpacing:8];
	[self.items mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.bottom.equalTo(self);
		make.width.mas_equalTo(itemWidth);
	}];
}


#pragma mark - public

- (void)setupItemsWithTitles:(NSArray<NSString *> *)titles
								normalImages:(NSArray<NSString *> *)normalImages
							selectedImages:(NSArray<NSString *> *)selectedImages {
	NSMutableArray *items = [NSMutableArray arrayWithCapacity:titles.count];
	for (int i = 0; i < titles.count; i++) {
		TabBarItem *item = [[TabBarItem alloc] initWithFrame:CGRectZero
																									 title:titles[i]
																						 normalImage:normalImages[i]
																					 selectedImage:selectedImages[i]];
		
		item.tag = i;
		item.selected = i == 0; //默认选中第一个
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapped:)];
		[item addGestureRecognizer:tap];
		[self addSubview:item];
		[items addObject:item];
	}
	
	self.items = [items copy];
	[self jy_layoutSubviews];
}


#pragma mark - private

- (void)itemTapped:(UITapGestureRecognizer *)gesture {
	TabBarItem *item = (TabBarItem *)gesture.view;
	[self resetSelectedState];
	item.selected = YES;
	
	self.selectedIndex = item.tag;
	
	if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]) {
		[self.delegate tabBar:self didSelectItemAtIndex:item.tag];
	}
}

- (void)resetSelectedState {
	for (TabBarItem *item in self.items) {
		item.selected = NO;
	}
}


@end
