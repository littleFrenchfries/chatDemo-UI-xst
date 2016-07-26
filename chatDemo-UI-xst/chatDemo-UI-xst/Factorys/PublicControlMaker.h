//
//  PublicControlMaker.h
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/25.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PasswdEncrypt.h"
@interface PublicControlMaker : NSObject

+(UITextField *)createCustomTextFieldWithFrame:(CGRect )frame delegate:(id)sender WithPlaceholder:(NSString *)st_placeholer;

+(UILabel *)createLabelWithFrame:(CGRect )frame WithText:(NSString *)text;

+(UIButton *)createButtonWithImageFrame:(CGRect )frame normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;

+(UIButton *)createButtonWithTitleFrame:(CGRect )frame title:(NSString *)title;

+(PasswdEncrypt *)createPasswdEncryptWithFrame:(CGRect )frame delegate:(id)sender WithPlaceholder:(NSString *)st_placeholer;
@end
