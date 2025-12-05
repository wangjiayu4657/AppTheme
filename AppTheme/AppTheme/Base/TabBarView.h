//
//  TabbarView.h
//  AppTheme
//
//  Created by 王家玉 on 2025/12/2.
//

#import <UIKit/UIKit.h>
@class TabBarView;


NS_ASSUME_NONNULL_BEGIN

@interface UPTabBar : UITabBar

@end

@protocol TabbarViewDelegate <NSObject>

@optional
- (void)tabBar:(TabBarView *_Nullable)tabBar didSelectItemAtIndex:(NSInteger)index;
- (void)tabBarDidClickCenterButton:(TabBarView *_Nullable)tabBar;

@end


@interface TabBarView : UIView

@property (nonatomic, weak) id<TabbarViewDelegate> delegate;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat afeAreaBottom;

- (void)setupItemsWithTitles:(NSArray<NSString *> *)titles
								normalImages:(NSArray<NSString *> *)normalImages
							selectedImages:(NSArray<NSString *> *)selectedImages;

@end

NS_ASSUME_NONNULL_END
