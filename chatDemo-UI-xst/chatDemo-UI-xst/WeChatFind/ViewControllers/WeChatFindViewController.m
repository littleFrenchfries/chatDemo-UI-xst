//
//  WeChatFindViewController.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/22.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "WeChatFindViewController.h"

@interface WeChatFindViewController ()

@end

@implementation WeChatFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedStringFromTable(@"Discover", XTLocalizedString, @"发现");
    // Do any additional setup after loading the view.
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
