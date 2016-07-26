//
//  PublicControlMaker.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/25.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "PublicControlMaker.h"

@implementation PublicControlMaker

+(UITextField *)createCustomTextFieldWithFrame:(CGRect )frame delegate:(id)sender WithPlaceholder:(NSString *)st_placeholer{
    UITextField * textField = [[UITextField alloc]initWithFrame:frame];
    textField.attributedPlaceholder=[[NSAttributedString alloc] initWithString:st_placeholer attributes:@{NSForegroundColorAttributeName:[UIColor hex_getColor:PLAYHODLETEXTCOLOR]}];
    textField.font = [UIFont systemFontOfSize:TEXTFEILDFOND];
    textField.delegate = sender;
    textField.backgroundColor = [UIColor hex_getColor:TEXTFILEDTEXTCOLOR];
    textField.layer.cornerRadius = 5.0f;
    
    return textField;
}

+(PasswdEncrypt *)createPasswdEncryptWithFrame:(CGRect )frame delegate:(id)sender WithPlaceholder:(NSString *)st_placeholer{
    PasswdEncrypt * textField = [[PasswdEncrypt alloc]initWithFrame:frame];
    textField.attributedPlaceholder=[[NSAttributedString alloc] initWithString:st_placeholer attributes:@{NSForegroundColorAttributeName:[UIColor hex_getColor:PLAYHODLETEXTCOLOR]}];
    textField.font = [UIFont systemFontOfSize:TEXTFEILDFOND];
    textField.delegate = sender;
    textField.backgroundColor = [UIColor hex_getColor:TEXTFILEDTEXTCOLOR];
    textField.layer.cornerRadius = 5.0f;
    return textField;
}

+(UILabel *)createLabelWithFrame:(CGRect )frame WithText:(NSString *)text{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.font = [UIFont systemFontOfSize:TITLEFOND];
    label.textColor = [UIColor hex_getColor:TITLECOLOR];
    return label;
}

+(UIButton *)createButtonWithImageFrame:(CGRect)frame normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:normalImage forState:UIControlStateNormal|UIControlStateHighlighted];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    [btn setImage:selectedImage forState:UIControlStateNormal|UIControlStateHighlighted];
    btn.frame = frame;
    btn.layer.cornerRadius = 5.0f;
    return btn;
}

+(UIButton *)createButtonWithTitleFrame:(CGRect)frame title:(NSString *)title{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor hex_getColor:ACTIONBUTTONCOLOR];
    btn.frame = frame;
    btn.layer.cornerRadius = 5.0f;
    return btn;
}
@end
