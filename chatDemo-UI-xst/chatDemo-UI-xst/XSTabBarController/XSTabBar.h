//
//  XSTabBar.h
//  XSTHttpConnect
//
//  Created by shinyhub on 16/7/14.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import <UIKit/UIKit.h>





@interface XSTabBar : UITabBar

/** 发布按钮 */
@property (nonatomic, strong) UIButton *plusButton;

/**
 *  设置tabBarItem的个数
 */
@property (assign, nonatomic)CGFloat XSTabbarItemsCount;

/**
 *  设置是否含有title（必填）
 */
@property (assign, nonatomic)BOOL isHaveTitle;

@end
