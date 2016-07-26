//
//  XSTTabBarViewController.m
//  XSTHttpConnect
//
//  Created by shinyhub on 16/7/14.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "XSTTabBarViewController.h"
#import "XSTabBar.h"
@interface XSTTabBarViewController ()

@end

@implementation XSTTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 处理tabBar，使用自定义 tabBar 添加 发布按钮
    [self setUpTabBar];
    
    // Do any additional setup after loading the view.
}
/**
 *  利用 KVC 把系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar {
    [self setValue:[[XSTabBar alloc] init] forKey:@"tabBar"];
}
- (void)addOneChildViewController:(UIViewController *)viewController
                        WithTitle:(NSString *)title
                  normalImageName:(NSString *)normalImageName
                selectedImageName:(NSString *)selectedImageName{
    [self addOneChildViewController:viewController WithTitle:title WithTitleNormalColor:nil WithTitleSelectedColor:nil normalImageName:normalImageName selectedImageName:selectedImageName];
}
- (void)addOneChildViewController:(UIViewController *)viewController
                        WithTitle:(NSString *)title
             WithTitleNormalColor:(UIColor *)normalColor
           WithTitleSelectedColor:(UIColor *)selectedColor
                  normalImageName:(NSString *)normalImageName
                selectedImageName:(NSString *)selectedImageName {
    viewController.tabBarItem.title = title;
    if (normalImageName) {
        UIImage *normalImage = [UIImage imageNamed:normalImageName];
        normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.image = normalImage;
    }
    if (selectedImageName) {
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.selectedImage = selectedImage;
        
    }
    if (normalColor) {
        [viewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:normalColor,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    }
    if (selectedColor) {
        [viewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:selectedColor,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }
    
    if (title.length == 0) {
        [(XSTabBar *)self.tabBar setIsHaveTitle:NO];
    }else{
        [(XSTabBar *)self.tabBar setIsHaveTitle:YES];
    }
    int i = [(XSTabBar *)self.tabBar XSTabbarItemsCount]+1;
    [(XSTabBar *)self.tabBar setXSTabbarItemsCount:i];
    [self addChildViewController:viewController];
}

- (void)addChildViewControllers:(NSArray *)viewControllers WithTitle:(NSArray *)titles normalImageNames:(NSArray *)normalImageNames selectedImageNames:(NSArray *)selectedImageNames{
    if (viewControllers.count != normalImageNames.count||viewControllers.count != selectedImageNames.count) {
        NSString *reason = [NSString stringWithFormat:@"控制器与图片个数不匹配！%@,%@",
                            @(__PRETTY_FUNCTION__),
                            @(__LINE__)];
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:reason
                                     userInfo:nil];
        return;
    }
    for (int i = 0; i<viewControllers.count; i++) {
        if (titles.count == 0) {
            [self addOneChildViewController:viewControllers[i] WithTitle:nil normalImageName:normalImageNames[i] selectedImageName:selectedImageNames[i]];
        }else{
            [self addOneChildViewController:viewControllers[i] WithTitle:titles[i] normalImageName:normalImageNames[i] selectedImageName:selectedImageNames[i]];
        }
    }
}

-(void)setPlusButton:(UIButton *)btn{
    [(XSTabBar *)self.tabBar setPlusButton:btn];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
