//
//  XSTTabBarViewController.h
//  XSTHttpConnect
//
//  Created by shinyhub on 16/7/14.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XSTTabBarViewController : UITabBarController


/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param normalImageName   图片
 *  @param selectedImageName 选中图片
 */
- (void)addOneChildViewController:(UIViewController *)viewController
                        WithTitle:(NSString *)title
                  normalImageName:(NSString *)normalImageName
                selectedImageName:(NSString *)selectedImageName;
/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param normalColor      普通状态下的颜色
 *  @param selectedColor     选中状态下的颜色
 *  @param normalImageName   图片
 *  @param selectedImageName 选中图片
 */
- (void)addOneChildViewController:(UIViewController *)viewController
                        WithTitle:(NSString *)title
             WithTitleNormalColor:(UIColor *)normalColor
           WithTitleSelectedColor:(UIColor *)selectedColor
                  normalImageName:(NSString *)normalImageName
                selectedImageName:(NSString *)selectedImageName;

/**
 *  添加一组子控制器
 *
 *  @param viewControllers   控制器数组(必填)
 *  @param titles            标题数组（选填）
 *  @param normalImageNames  图片数组（必填切与控制器数组个数相同）
 *  @param selectedImageName 选中图片数组（必填切与控制器数组个数相同）
 */
- (void)addChildViewControllers:(NSArray *)viewControllers WithTitle:(NSArray *)titles normalImageNames:(NSArray *)normalImageNames selectedImageNames:(NSArray *)selectedImageNames;

/**
 *  设置中间按钮
 */
- (void)setPlusButton:(UIButton *)btn;

@end
