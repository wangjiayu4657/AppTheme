//
//  InputView.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputView : UIView

@property(nonatomic, assign) BOOL isShowCodeBtn; 				//是否需要显示`获取验证码`按钮
@property(nonatomic, assign) BOOL isShowVerticalLine;		//是否需要显示竖直分割线
@property(nonatomic, strong) NSString *leadingText;		  //开头文本
@property(nonatomic, strong) NSString *placeholder;			//占位提示文本
@property(nonatomic, strong, readonly) NSString *inputText;				//输入内容


@end

NS_ASSUME_NONNULL_END
