//
//  UIView+Frames.h
//  UPBaseUI
//
//  Created by Jimmy on 17/2/22.
//  Copyright © 2017年 UpChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UPFrames)

@property (nonatomic, assign) CGFloat up_x;
@property (nonatomic, assign) CGFloat up_y;
@property (nonatomic, assign) CGFloat up_left;
@property (nonatomic, assign) CGFloat up_right;
@property (nonatomic, assign) CGFloat up_top;
@property (nonatomic, assign) CGFloat up_bottom;
@property (nonatomic, assign) CGFloat up_width;
@property (nonatomic, assign) CGFloat up_height;
@property (nonatomic, assign) CGFloat up_centerX;
@property (nonatomic, assign) CGFloat up_centerY;
@property (nonatomic, assign) CGSize  up_size;
@property (nonatomic, assign) CGPoint up_origin;
@property (nonatomic, assign, readonly) CGFloat up_maxX;
@property (nonatomic, assign, readonly) CGFloat up_maxY;

@property(nonatomic, assign, readonly) UIEdgeInsets up_safeAreaInsets;

@end
