//
//  AppDelegate.h
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/21.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,ApplyStyle){
    ApplyStyleFriend            = 0,
    ApplyStyleGroupInvitation,
    ApplyStyleJoinGroup,
};

@interface AppDelegate : UIResponder <UIApplicationDelegate,EMChatManagerDelegate,EMGroupManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)pushToLoginViewController;
@end

