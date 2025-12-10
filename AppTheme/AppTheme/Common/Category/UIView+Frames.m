//
//  UIView+Frames.m
//  UPBaseUI
//
//  Created by Jimmy on 17/2/22.
//  Copyright © 2017年 UpChina. All rights reserved.
//

#import "UIView+Frames.h"

@implementation UIView (UPFrames)

- (void)setUp_x:(CGFloat)x {
    self.up_left = x;
}

- (CGFloat)up_x {
    return self.up_left;
}

- (void)setUp_y:(CGFloat)y {
    self.up_top = y;
}

- (CGFloat)up_y {
    return self.up_top;
}

- (void)setUp_left:(CGFloat)left {
    CGFloat right = self.up_right;
    CGRect frame = self.frame;
    frame.origin.x = left;
    frame.size.width = right - left;
    self.frame = frame;
}

- (CGFloat)up_left {
    return self.frame.origin.x;
}

- (void)setUp_right:(CGFloat)right {
    CGFloat left = self.up_left;
    CGRect frame = self.frame;
    frame.size.width = right - left;
    self.frame = frame;
}

- (CGFloat)up_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setUp_top:(CGFloat)top {
    CGFloat bottom = self.up_bottom;
    CGRect frame = self.frame;
    frame.origin.y = top;
    frame.size.height = bottom - top;
    self.frame = frame;
}

- (CGFloat)up_top {
    return self.frame.origin.y;
}

- (void)setUp_bottom:(CGFloat)bottom {
    CGFloat top = self.up_top;
    CGRect frame = self.frame;
    frame.size.height = bottom - top;
    self.frame = frame;
}

- (CGFloat)up_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setUp_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)up_width {
    return self.frame.size.width;
}

- (void)setUp_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)up_height {
    return self.frame.size.height;
}

- (void)setUp_centerX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)up_centerX {
    return self.center.x;
}

- (void)setUp_centerY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)up_centerY {
    return self.center.y;
}

- (void)setUp_size:(CGSize)up_size {
    CGRect frame = self.frame;
    frame.size = up_size;
    self.frame = frame;
}

- (CGSize)up_size {
    return self.frame.size;
}

- (void)setUp_origin:(CGPoint)up_origin {
    CGRect frame = self.frame;
    frame.origin = up_origin;
    self.frame = frame;
}

- (CGPoint)up_origin {
    return self.frame.origin;
}

- (CGFloat)up_maxX {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)up_maxY {
    return self.frame.origin.y + self.frame.size.height;
}

- (UIEdgeInsets)up_safeAreaInsets {
    if (@available(iOS 11.0,*)) {
        return self.safeAreaInsets;
    } else {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

@end
