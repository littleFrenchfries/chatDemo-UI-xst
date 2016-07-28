//
//  WeChatMeViewController.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/22.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "WeChatMeViewController.h"
#import "AppDelegate.h"
@interface WeChatMeViewController ()

@end

@implementation WeChatMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedStringFromTable(@"Me", XTLocalizedString, @"我");
    
    UIButton * btn = [PublicControlMaker createButtonWithTitleFrame:CGRectMake(100, 100, 100, 100) title:@"注销"];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}

-(void)btnClick:(UIButton *)btn{
    //注销用户
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate pushToLoginViewController];
    }else{
        DLog(@"error == %@",error.errorDescription);
    }
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
