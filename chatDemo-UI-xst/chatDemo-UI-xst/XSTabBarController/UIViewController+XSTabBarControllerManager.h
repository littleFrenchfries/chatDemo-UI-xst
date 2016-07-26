//
//  UIViewController+XSTabBarControllerManager.h
//  XSTHttpConnect
//
//  Created by shinyhub on 16/7/15.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^XSTPopSelectTabBarChildViewControllerCompletion)(__kindof UIViewController *selectedTabBarChildViewController);

@interface UIViewController (XSTabBarControllerManager)

/**
 *  跳到制定的tabBarController 的子控制器 并pop到导航栏控制器的根控制器
 *
 *  @param index 跳到自控制器的下标
 *
 *  @return 返回跳转之后控制器
 */
- (UIViewController *)xst_popSelectTabBarChildViewControllerAtIndex:(NSUInteger) index;

- (void)xst_popSelectTabBarChildViewControllerAtIndex:(NSUInteger)index
                                       completion:(XSTPopSelectTabBarChildViewControllerCompletion)completion;
/**
 *  跳到制定的tabBarController 的子控制器 并pop到导航栏控制器的根控制器
 *
 *  @param classType 跳到自控制器的类名
 *
 *  @return 返回跳转之后控制器
 */
- (UIViewController *)xst_popSelectTabBarChildViewControllerForClassType:(Class)classType;

- (void)xst_popSelectTabBarChildViewControllerForClassType:(Class)classType
                                                completion:(XSTPopSelectTabBarChildViewControllerCompletion)completion;

-(void)closeOrOpenKeyboardManager:(BOOL)isnt;
@end
