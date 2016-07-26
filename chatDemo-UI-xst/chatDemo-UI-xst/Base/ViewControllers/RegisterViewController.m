
//
//  RegisterViewController.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/25.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "RegisterViewController.h"
#import "VerificationCodeButton.h"
@interface RegisterViewController ()

@property (strong, nonatomic)UITextField * phoneTextField;

@property (strong, nonatomic)UITextField * codeTextField;

@property (strong, nonatomic)PasswdEncrypt * passwdOneTextField;

@property (strong, nonatomic)PasswdEncrypt * passwdTwoTextFeild;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)setNavigationBar{
    [super setNavigationBar];
    self.navigationItem.title = NSLocalizedStringFromTable(@"Register", XTLocalizedString, @"用户注册");
    
}

-(void)createUI{
    self.phoneTextField = [PublicControlMaker createCustomTextFieldWithFrame:CGRectMake(SPACING*2, SPACING*2+64, kScreenW-SPACING*4, CELLHEIGHT) delegate:self WithPlaceholder:@"请输入手机号"];

    VerificationCodeButton * veriBtn = [[VerificationCodeButton alloc] init];
    [veriBtn addTargitWith:self action:@selector(veriBtnClick:)];
    [self.phoneTextField setLOrRView:veriBtn type:RIGHTVIEW];
    
    [self.view addSubview:self.phoneTextField];
    
    self.codeTextField = [PublicControlMaker createCustomTextFieldWithFrame:CGRectMake(SPACING*2, self.phoneTextField.mj_h+self.phoneTextField.mj_y+SPACING*2, kScreenW-SPACING*4, CELLHEIGHT) delegate:self WithPlaceholder:@"请输入验证码"];
    [self.view addSubview:self.codeTextField];
    
    
    self.passwdOneTextField = [PublicControlMaker createPasswdEncryptWithFrame:CGRectMake(SPACING*2, self.codeTextField.mj_y+self.codeTextField.mj_h+SPACING*2, kScreenW-SPACING*4, CELLHEIGHT) delegate:self WithPlaceholder:@"请输入6到16个字符登录密码，区分大小写"];
    UIButton * passwdOneBtn = [PublicControlMaker createButtonWithTitleFrame:CGRectMake(0, 0, CELLHEIGHT, CELLHEIGHT) title:@"保密"];
    [passwdOneBtn addTarget:self action:@selector(passwdOneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.passwdOneTextField setLOrRView:passwdOneBtn type:RIGHTVIEW];
    [self.view addSubview:self.passwdOneTextField];
    
    self.passwdTwoTextFeild = [PublicControlMaker createPasswdEncryptWithFrame:CGRectMake(SPACING*2, self.passwdOneTextField.mj_y+self.passwdOneTextField.mj_h+SPACING*2, kScreenW-SPACING*4, CELLHEIGHT) delegate:self WithPlaceholder:@"请再次输入登录密码"];
    UIButton * passwdTwoBtn = [PublicControlMaker createButtonWithTitleFrame:CGRectMake(0, 0, CELLHEIGHT, CELLHEIGHT) title:@"保密"];
    [passwdTwoBtn addTarget:self action:@selector(passwdTwoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.passwdTwoTextFeild setLOrRView:passwdTwoBtn type:RIGHTVIEW];
    [self.view addSubview:self.passwdTwoTextFeild];
    
    UIButton * footerBtn = [PublicControlMaker createButtonWithTitleFrame:CGRectMake(SPACING*2, self.passwdTwoTextFeild.mj_h+self.passwdTwoTextFeild.mj_y+SPACING*2, kScreenW-SPACING*4, CELLHEIGHT) title:@"下一步"];
    [footerBtn addTarget:self action:@selector(footerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:footerBtn];
}

-(void)passwdOneBtn:(UIButton *)btn{
    btn.selected = ! btn.selected;
    if (btn.selected) {
        [self.passwdOneTextField setPasswdEncrypt:YES];
    }else{
        [self.passwdOneTextField setPasswdEncrypt:NO];
    }
}

-(void)passwdTwoBtn:(UIButton *)btn{
    btn.selected = ! btn.selected;
    if (btn.selected) {
        [self.passwdTwoTextFeild setPasswdEncrypt:YES];
    }else{
        [self.passwdTwoTextFeild setPasswdEncrypt:NO];
    }
}

-(void)footerBtnClick:(UIButton *)btn{
    //开始注册
    EMError *error = [[EMClient sharedClient] registerWithUsername:self.phoneTextField.text password:self.passwdOneTextField.text];
    if (error==nil) {
        DLog(@"注册成功");
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        DLog(@"%@",error.errorDescription);
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.passwdOneTextField) {
        NSString * str = self.passwdOneTextField.origlText;
        self.passwdOneTextField.origlText = [str stringByReplacingCharactersInRange:range withString:string];
    }
    if (self.passwdOneTextField.isnt&&string.length>0&&textField == self.passwdOneTextField&&![string isEqualToString:@"*"]) {
        
        NSString * strt = self.passwdOneTextField.text;
        self.passwdOneTextField.text = [strt stringByAppendingString:@"*"];
        return NO;
    }
    if (textField == self.passwdTwoTextFeild) {
        NSString * str = self.passwdTwoTextFeild.origlText;
        self.passwdTwoTextFeild.origlText = [str stringByReplacingCharactersInRange:range withString:string];
    }
    if (self.passwdTwoTextFeild.isnt&&string.length>0&&textField == self.passwdTwoTextFeild&&![string isEqualToString:@"*"]) {
        
        NSString * strt = self.passwdTwoTextFeild.text;
        self.passwdTwoTextFeild.text = [strt stringByAppendingString:@"*"];
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
