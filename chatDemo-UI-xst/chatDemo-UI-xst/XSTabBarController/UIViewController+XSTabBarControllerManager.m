//
//  UIViewController+XSTabBarControllerManager.m
//  XSTHttpConnect
//
//  Created by shinyhub on 16/7/15.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "UIViewController+XSTabBarControllerManager.h"
#import "XSTTabBarViewController.h"
#import "IQKeyboardManager.h"
@implementation UIViewController (XSTabBarControllerManager)


- (UIViewController *)xst_popSelectTabBarChildViewControllerAtIndex:(NSUInteger) index{
    /**
     *  检查是否有此控制器 没有抛出异常
     */
    [self checkTabBarChildControllerValidityAtIndex:index];
    XSTTabBarViewController * tabBarVC = (XSTTabBarViewController *)self.tabBarController;
    self.tabBarController.selectedIndex = index;
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    UIViewController *selectedTabBarChildViewController = tabBarVC.selectedViewController;
    BOOL isNavigationController = [[selectedTabBarChildViewController class] isSubclassOfClass:[UINavigationController class]];
    if (isNavigationController) {
        return ((UINavigationController *)selectedTabBarChildViewController).viewControllers[0];
    }
    return selectedTabBarChildViewController;
}

-(void)xst_popSelectTabBarChildViewControllerAtIndex:(NSUInteger)index completion:(XSTPopSelectTabBarChildViewControllerCompletion)completion{
    UIViewController *selectedTabBarChildViewController = [self xst_popSelectTabBarChildViewControllerAtIndex:index];
    dispatch_async(dispatch_get_main_queue(), ^{
        !completion ?: completion(selectedTabBarChildViewController);
    });
}

- (UIViewController *)xst_popSelectTabBarChildViewControllerForClassType:(Class)classType{
    XSTTabBarViewController *tabBarController = (XSTTabBarViewController *)self.tabBarController;
    __block NSInteger atIndex = NSNotFound;
    [tabBarController.viewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id obj_ = nil;
        BOOL isNavigationController = [[tabBarController.viewControllers[idx] class] isSubclassOfClass:[UINavigationController class]];
        if (isNavigationController) {
            obj_ = ((UINavigationController *)obj).viewControllers[0];
        } else {
            obj_ = obj;
        }
        if ([obj_ isKindOfClass:classType]) {
            atIndex = idx;
            *stop = YES;
            return;
        }
    }];
    
    return [self xst_popSelectTabBarChildViewControllerAtIndex:atIndex];
}

- (void)xst_popSelectTabBarChildViewControllerForClassType:(Class)classType
                                                completion:(XSTPopSelectTabBarChildViewControllerCompletion)completion{
    UIViewController * selectedTabBarChildViewController = [self xst_popSelectTabBarChildViewControllerForClassType:classType];
    dispatch_async(dispatch_get_main_queue(), ^{
        !completion ?: completion(selectedTabBarChildViewController);
    });
}

- (void)checkTabBarChildControllerValidityAtIndex:(NSUInteger)index {
    XSTTabBarViewController *tabBarController = (XSTTabBarViewController *)self.tabBarController;
    @try {
        UIViewController *viewController;
        viewController = tabBarController.viewControllers[index];
    } @catch (NSException *exception) {
        NSString *formatString = @"\n\n\
        ------ BEGIN NSException Log ---------------------------------------------------------------------\n \
        class name: %@                                                                                    \n \
        ------line: %@                                                                                    \n \
        ----reason: The Class Type or the index or its NavigationController you pass in method `-cyl_popSelectTabBarChildViewControllerAtIndex` or `-cyl_popSelectTabBarChildViewControllerForClassType` is not the item of CYLTabBarViewController \n \
        ------ END ---------------------------------------------------------------------------------------\n\n";
        NSString *reason = [NSString stringWithFormat:formatString,
                            @(__PRETTY_FUNCTION__),
                            @(__LINE__)];
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:reason
                                     userInfo:nil];
    }
}

-(void)closeOrOpenKeyboardManager:(BOOL)isnt{
    IQKeyboardManager * manager =[IQKeyboardManager sharedManager];
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    if (isnt) {
         manager.enable = YES;
    }else{
        manager.enable = NO;
    }
    
}

@end
