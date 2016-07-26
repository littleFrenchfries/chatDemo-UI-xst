//
//  PasswdEncrypt.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/25.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "PasswdEncrypt.h"

@interface PasswdEncrypt (){
}

@end

@implementation PasswdEncrypt

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isnt = NO;
    }
    return self;
}
-(void)setPasswdEncrypt:(BOOL)isnt{
    self.isnt = isnt;
    if (isnt) {
        NSMutableString * text = [NSMutableString string];
        for (int i = 0; i<self.text.length; i++) {
            [text appendString:@"*"];
        }
        self.origlText = self.text;
        self.text = text;
    }else{
        self.text = self.origlText;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
