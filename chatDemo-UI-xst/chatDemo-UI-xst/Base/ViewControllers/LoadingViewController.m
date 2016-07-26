


//
//  LoadingViewController.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/25.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "LoadingViewController.h"

#import "RegisterViewController.h"

@interface LoadingViewController ()<UITextFieldDelegate>

@property (strong, nonatomic)UITextField * nameTextField;

@property (strong, nonatomic)PasswdEncrypt * passwdTextField;

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviBar];
    [self createUI];
    // Do any additional setup after loading the view.
}
-(void)createNaviBar{
    self.navigationItem.title = NSLocalizedStringFromTable(@"Login", XTLocalizedString, @"登录");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"Register", XTLocalizedString, @"注册") style:UIBarButtonItemStylePlain target:self action:@selector(signUpClick:)];
}
-(void)createUI{
    self.nameTextField = [PublicControlMaker createCustomTextFieldWithFrame:CGRectMake(SPACING*2, 74, kScreenW-SPACING*4, CELLHEIGHT) delegate:self WithPlaceholder:@"请输入手机号"];
    UILabel * nameLabel = [PublicControlMaker createLabelWithFrame:CGRectMake(0, 0, CELLHEIGHT, CELLHEIGHT) WithText:@"手机:"];
    [self.nameTextField setLOrRView:nameLabel type:LEFTVIEW];
    [self.view addSubview:self.nameTextField];
    
    self.passwdTextField = [PublicControlMaker createPasswdEncryptWithFrame:CGRectMake(SPACING*2, self.nameTextField.mj_h+self.nameTextField.mj_y+SPACING*2, kScreenW-SPACING*4, CELLHEIGHT) delegate:self WithPlaceholder:@"请输入密码"];
    UILabel * passwdLabel = [PublicControlMaker createLabelWithFrame:CGRectMake(0, 0, CELLHEIGHT, CELLHEIGHT) WithText:@"密码:"];
    [self.passwdTextField setLOrRView:passwdLabel type:LEFTVIEW];
    [self.view addSubview:self.passwdTextField];
    
    UIButton *passwdBtn = [PublicControlMaker createButtonWithTitleFrame:CGRectMake(0, 0, CELLHEIGHT, CELLHEIGHT) title:@"保密"];
    [passwdBtn addTarget:self action:@selector(passwdClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.passwdTextField setLOrRView:passwdBtn type:RIGHTVIEW];
    
    UIButton * signIn =[PublicControlMaker createButtonWithTitleFrame:CGRectMake(2*SPACING, self.passwdTextField.mj_h+10+self.passwdTextField.mj_y, kScreenW-4*SPACING, CELLHEIGHT) title:@"登录"];
    signIn.backgroundColor = [UIColor hex_getColor:ACTIONBUTTONCOLOR];
    [signIn addTarget:self action:@selector(signInClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signIn];
    
}

-(void)signUpClick:(UIBarButtonItem *)item{
    
    RegisterViewController * registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)signInClick:(UIButton *)btn{
    
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.nameTextField.text password:self.passwdTextField.text];
    if (!error) {
        DLog(@"登录成功");
        [[EMClient sharedClient].options setIsAutoLogin:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        
        // 显示错误信息的警告
        DLog(@"%@",error.errorDescription);
    }

}

-(void)passwdClick:(UIButton *)btn{
    btn.selected = ! btn.selected;
    if (btn.selected) {
        [self.passwdTextField setPasswdEncrypt:YES];
    }else{
        [self.passwdTextField setPasswdEncrypt:NO];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.passwdTextField) {
        NSString * str = self.passwdTextField.origlText;
        self.passwdTextField.origlText = [str stringByReplacingCharactersInRange:range withString:string];
    }
    if (self.passwdTextField.isnt&&string.length>0&&textField == self.passwdTextField&&![string isEqualToString:@"*"]) {
        
        NSString * strt = self.passwdTextField.text;
        self.passwdTextField.text = [strt stringByAppendingString:@"*"];
        return NO;
    }
    return YES;
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
