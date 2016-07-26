//
//  PasswdEncrypt.h
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/25.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswdEncrypt : UITextField

@property (copy, nonatomic)NSString * origlText;

@property (assign, nonatomic)BOOL isnt;

-(void)setPasswdEncrypt:(BOOL)isnt;

@end
