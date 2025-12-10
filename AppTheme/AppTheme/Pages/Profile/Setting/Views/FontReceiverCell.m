//
//  FontCell.m
//  AppTheme
//
//  Created by 王家玉 on 2025/12/9.
//

#import "FontReceiverCell.h"

@interface FontReceiverCell()

@property(nonatomic, strong) UILabel *contentLb;
@property(nonatomic, strong) UIImageView *avatar;
@property(nonatomic, strong) UIImageView *backgroundImage;

@end


@implementation FontReceiverCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if(self = [super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
		self.backgroundColor = UIColor.clearColor;
		[self jy_layoutSubviews];
	}
	return self;
}


#pragma mark - 设置 UI

- (void)jy_layoutSubviews {
	CGFloat screenWidth = self.up_width ? self.up_width : [UIScreen mainScreen].bounds.size.width;
	CGFloat maxWidth = screenWidth - 12 - 24 - 8;
	
	[self.contentView addSubview:self.avatar];
	[self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(6);
		make.left.mas_equalTo(12);
		make.width.height.mas_equalTo(24);
	}];
	
	[self.contentView addSubview:self.backgroundImage];
	[self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.bottom.equalTo(self.contentView);
		make.left.equalTo(self.avatar.mas_right).offset(8);
	}];
	
	[self.contentView addSubview:self.contentLb];
	[self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.backgroundImage).insets(UIEdgeInsetsMake(12, 18, 12, 15));
		make.width.mas_greaterThanOrEqualTo(40);
		make.width.mas_lessThanOrEqualTo(maxWidth);
	}];
}


#pragma mark - setter

- (void)setParam:(NSDictionary *)param {
	_param = param;
	
	NSString *content = param[@"content"];
	self.contentLb.text = content;
}


#pragma mark - getter

- (UILabel *)contentLb {
	if (!_contentLb) {
		_contentLb = [[UILabel alloc] init];
		_contentLb.text = @"内容";
		_contentLb.numberOfLines = 0;
		_contentLb.textColor = [UIColor blackColor];
		_contentLb.font = [UIFont systemFontOfSize:16];
	}
	return _contentLb;
}

- (UIImageView *)avatar {
	if (!_avatar) {
		_avatar = [[UIImageView alloc] init];
		_avatar.image = [UIImage imageNamed:@"receiver_avatar"];
	}
	return _avatar;
}

- (UIImageView *)backgroundImage {
	if (!_backgroundImage) {
		_backgroundImage = [[UIImageView alloc] init];
		_backgroundImage.image = [UIImage imageNamed:@"receiver_background"];
	}
	return _backgroundImage;
}

@end
