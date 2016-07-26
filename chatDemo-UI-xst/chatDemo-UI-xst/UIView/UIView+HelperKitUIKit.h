//
//  UIView+HelperKitUIKit.h
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/25.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HelperKitUIKit)
#pragma mark - Convenience frame api
/**
 * view.frame.origin.x
 */
@property (nonatomic, assign) CGFloat st_originX;

/**
 * view.frame.origin.y
 */
@property (nonatomic, assign) CGFloat st_originY;

/**
 * view.frame.origin
 */
@property (nonatomic, assign) CGPoint st_origin;

/**
 * view.center.x
 */
@property (nonatomic, assign) CGFloat st_centerX;

/**
 * view.center.y
 */
@property (nonatomic, assign) CGFloat st_centerY;

/**
 * view.center
 */
@property (nonatomic, assign) CGPoint st_center;

/**
 * view.frame.size.width
 */
@property (nonatomic, assign) CGFloat st_width;

/**
 * view.frame.size.height
 */
@property (nonatomic, assign) CGFloat st_height;

/**
 * view.frame.size
 */
@property (nonatomic, assign) CGSize  st_size;

/**
 * view.frame.size.height + view.frame.origin.y
 */
@property (nonatomic, assign) CGFloat st_bottomY;

/**
 * view.frame.size.width + view.frame.origin.x
 */
@property (nonatomic, assign) CGFloat st_rightX;

@end
