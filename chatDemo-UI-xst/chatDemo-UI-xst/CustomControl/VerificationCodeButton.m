//
//  VerificationCodeButton.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/26.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "VerificationCodeButton.h"

@interface VerificationCodeButton ()

@property (strong, nonatomic) NSTimer * timer;

@property (strong, nonatomic) UIButton * btn;

@property (assign, nonatomic) NSUInteger second;

@property (strong, nonatomic)UILabel * label;

@end

@implementation VerificationCodeButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        
        self.btn.titleLabel.font = [UIFont systemFontOfSize:TITLEFOND];
        
        self.btn.frame = CGRectMake(0, 0, 150, CELLHEIGHT - SPACING*2);
        self.frame = self.btn.frame;
        self.btn.backgroundColor = [UIColor hex_getColor:ACTIONBUTTONCOLOR];
        
        self.btn.layer.cornerRadius = 5.0f;
        self.label = [[UILabel alloc]initWithFrame:self.frame];
        self.label.font = [UIFont systemFontOfSize:TITLEFOND];
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];
    }
    return self;
}


-(void)btnClick:(UIButton *)btn{
    btn.enabled = NO;
    [self startTimer];
    
}
#pragma mark- --------定时器相关方法--------
- (void)startTimer {
    self.second = 60;
    //如果定时器已开启，先停止再重新开启
    [self.btn setTitle:@"" forState:UIControlStateNormal];
    self.label.text = [NSString stringWithFormat:@"(%lds)后重新发送",self.second];
    [self.btn addSubview:self.label];
    if (self.timer) [self stopTimer];
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeIsUsed:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
    [self.btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.btn.enabled = YES;
    [self.label removeFromSuperview];
}

-(void)timeIsUsed:(NSTimer *)timer{
    self.second--;
    self.label.text = [NSString stringWithFormat:@"(%lds)后重新发送",self.second];
    
    if (self.second == 0) {
        [self stopTimer];
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
