//
//  BaseViewController.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/22.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hex_getColor:BACKVIEWCOLOR];
    [self setNavigationBar];
    [self setNavigationgController];
    // Do any additional setup after loading the view.
}

-(void)setNavigationgController{
    
    self.navigationController.navigationBar.barTintColor = [UIColor hex_getColor:NAVI_BAR_TINT_COLOR];
    
    UIColor * color = [UIColor whiteColor];
    
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
}

-(void)setNavigationBar{
    
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
