//
//  UITextField+TextFieldLeftOrReightView.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/25.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "UITextField+TextFieldLeftOrRightView.h"

@implementation UITextField (TextFieldLeftOrRightView)
-(UITextField *)setLOrRView:(__kindof UIView *)view type:(TextFeildType)modelType{
    switch (modelType) {
        case LEFTVIEW:{
            self.leftView = view;
            self.leftViewMode = UITextFieldViewModeAlways;
            break;
        }
        case RIGHTVIEW:{
            self.rightView = view;
            self.rightViewMode = UITextFieldViewModeAlways;
            break;
        }
        default:
            break;
    }
    return self;
}
@end
