//
//  WeChatHomeViewController.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/22.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "WeChatHomeViewController.h"

@interface WeChatHomeViewController ()

@end

@implementation WeChatHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    list<EMGroup>
    EMError *error = nil;
    NSArray *myGroups = [[EMClient sharedClient].groupManager getMyGroupsFromServerWithError:&error];
    if (!error) {
        DLog(@"获取成功 -- %@",myGroups);
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
