//
//  UIView+HelperKitUIKit.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/25.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "UIView+HelperKitUIKit.h"

@implementation UIView (HelperKitUIKit)
- (void)setSt_origin:(CGPoint)st_origin{
    CGRect frame = self.frame;
    frame.origin = st_origin;
    self.frame = frame;
}

- (CGPoint)st_origin {
    return self.frame.origin;
}

- (void)setSt_originX:(CGFloat)st_originX{
    [self setSt_origin:CGPointMake(st_originX, self.st_originY)];
}

- (CGFloat)st_originX {
    return self.st_origin.x;
}

- (void)setSt_originY:(CGFloat)st_originY {
    [self setSt_origin:CGPointMake(self.st_originX, st_originY)];
}

- (CGFloat)st_originY {
    return self.st_origin.y;
}

- (void)setSt_center:(CGPoint)st_center {
    self.center = st_center;
}

- (CGPoint)st_center {
    return self.center;
}

- (void)setSt_centerX:(CGFloat)st_centerX {
    [self setSt_center:CGPointMake(st_centerX, self.st_centerY)];
}

- (CGFloat)st_centerX {
    return self.st_center.x;
}

- (void)setSt_centerY:(CGFloat)st_centerY {
    [self setSt_center:CGPointMake(self.st_centerX, st_centerY)];
}

- (CGFloat)st_centerY {
    return self.st_center.y;
}

- (void)setSt_size:(CGSize)st_size {
    CGRect frame = self.frame;
    frame.size = st_size;
    self.frame = frame;
}

- (CGSize)st_size {
    return self.frame.size;
}

- (void)setSt_width:(CGFloat)st_width {
    self.st_size = CGSizeMake(st_width, self.st_height);
}

- (CGFloat)st_width {
    return self.st_size.width;
}

- (void)setSt_height:(CGFloat)st_height {
    self.st_size = CGSizeMake(self.st_width, st_height);
}

- (CGFloat)st_height {
    return self.st_size.height;
}

- (CGFloat)st_bottomY {
    return self.st_originY + self.st_height;
}

- (void)setSt_bottomY:(CGFloat)st_bottomY {
    self.st_originY = st_bottomY - self.st_height;
}

- (CGFloat)st_rightX {
    return self.st_originX + self.st_width;
}

- (void)setSt_rightX:(CGFloat)st_rightX {
    self.st_originX = st_rightX - self.st_width;
}

@end
