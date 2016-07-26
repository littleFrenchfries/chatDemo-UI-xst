//
//  UITextField+TextFieldLeftOrReightView.h
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/25.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,TextFeildType){
    LEFTVIEW = 1,
    RIGHTVIEW = 2
};

@interface UITextField (TextFieldLeftOrRightView)

-(UITextField *)setLOrRView:(__kindof UIView *)view type:(TextFeildType)modelType;

@end
