//
//  SettingCell.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/8.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
	SettingCellRihgtStyleArrow,		//右侧为箭头
	SettingCellRihgtStyleSwitch,		//右侧为切换按钮
	SettingCellRihgtStyleNone,			//右侧为空
} SettingCellRihgtStyle;

NS_ASSUME_NONNULL_BEGIN

typedef void(^SwitchCallBack)(void);


@interface SettingCell : UITableViewCell

@property(nonatomic, strong) NSDictionary *param;
@property(nonatomic, copy) SwitchCallBack callBack;

@end

NS_ASSUME_NONNULL_END
