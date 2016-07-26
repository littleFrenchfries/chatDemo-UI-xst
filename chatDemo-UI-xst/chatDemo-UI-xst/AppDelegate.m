//
//  AppDelegate.m
//  chatDemo-UI-xst
//
//  Created by shinyhub on 16/7/21.
//  Copyright © 2016年 shinyhub. All rights reserved.
//

#import "AppDelegate.h"
#import "WeChatMeViewController.h"
#import "WeChatHomeViewController.h"
#import "WeChatAddressViewController.h"
#import "WeChatFindViewController.h"
#import "XSTTabBarViewController.h"
#import "LoadingViewController.h"
#import "IQKeyboardManager.h"
@interface AppDelegate ()<EMClientDelegate,EMContactManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    XSTTabBarViewController * tabBarVtr = [[XSTTabBarViewController alloc]init];
    
    NSArray * titles = @[NSLocalizedStringFromTable(@"Chats", XTLocalizedString, @"微信"),NSLocalizedStringFromTable(@"Contacts",XTLocalizedString, @"通讯录"),NSLocalizedStringFromTable(@"Discover",XTLocalizedString, @"发现"),NSLocalizedStringFromTable(@"Me",XTLocalizedString, @"我")];
    NSArray * normalImageNames =@[@"tabbar_mainframe",@"tabbar_contacts",@"tabbar_discover",@"tabbar_me"];
    NSArray * selectedImageNames = @[@"tabbar_mainframeHL",@"tabbar_contactsHL",@"tabbar_discoverHL",@"tabbar_meHL"];
   
    WeChatHomeViewController * homeVtr = [[WeChatHomeViewController alloc]init];
    UINavigationController * homeNavi = [[UINavigationController alloc]initWithRootViewController:homeVtr];
    WeChatAddressViewController * addressVtr =[[WeChatAddressViewController alloc]init];
    UINavigationController * addressNavi =[[UINavigationController alloc]initWithRootViewController:addressVtr];
    WeChatFindViewController * findVtr =[[WeChatFindViewController alloc]init];
    UINavigationController * findNavi = [[UINavigationController alloc]initWithRootViewController:findVtr];
    WeChatMeViewController * meVtr =[[WeChatMeViewController alloc]init];
    UINavigationController * meNavi = [[UINavigationController alloc]initWithRootViewController:meVtr];
    
    NSArray * childViewControllers = @[homeNavi,addressNavi,findNavi,meNavi];
    [tabBarVtr addChildViewControllers:childViewControllers WithTitle:titles normalImageNames:normalImageNames selectedImageNames:selectedImageNames];
    self.window.rootViewController = tabBarVtr;
    
    [self setBassSetting:application WithOptions:launchOptions];
    
    [self.window makeKeyAndVisible];
    
    
    
    [self pushToLoginViewController];
    // Override point for customization after application launch.
    return YES;

}

-(void)pushToLoginViewController{
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        LoadingViewController * loginVtr = [[LoadingViewController alloc]init];
        UINavigationController * naviCtr = [[UINavigationController alloc]initWithRootViewController:loginVtr];
        [self.window.rootViewController presentViewController:naviCtr animated:YES completion:nil];
    }else{
        DLog(@"已经自动登录成功！");
    }
}


-(void)setBassSetting:(UIApplication *)application WithOptions:(NSDictionary *)launchOptions{
    IQKeyboardManager * manager =[IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    [[EaseSDKHelper shareHelper] easemobApplication:application
                      didFinishLaunchingWithOptions:launchOptions
                                             appkey:@"wangxu19921004#xsthttpconnect"
                                       apnsCertName:@"XSTHttpConnect"
                                        otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    //添加回调监听代理:
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

/*!
 *  自动登录返回结果
 *
 *  @param aError 错误信息
 */
- (void)didAutoLoginWithError:(EMError *)aError{
    DLog(@"error == %@",aError.errorDescription);
}
/*!
 *  SDK连接服务器的状态变化时会接收到该回调
 *
 *  有以下几种情况，会引起该方法的调用：
 *  1. 登录成功后，手机无法上网时，会调用该回调
 *  2. 登录成功后，网络状态变化时，会调用该回调
 *
 *  @param aConnectionState 当前状态
 */
- (void)didConnectionStateChanged:(EMConnectionState)aConnectionState{
    switch (aConnectionState) {
        case EMConnectionConnected:{
            DLog(@"网络已连接");
            break;
        }
        case EMConnectionDisconnected:{
            DLog(@"网络未连接");
            break;
        }
            
        default:
            break;
    }
}
/*!
 *  当前登录账号在其它设备登录时会接收到该回调
 */
- (void)didLoginFromOtherDevice{
    DLog(@"账号在其他设备上登录");
}

/*!
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
- (void)didRemovedFromServer{
    DLog(@"账号已删除");
}

/*!
 *  \~chinese
 *  用户B申请加A为好友后，用户A会收到这个回调
 *
 *  @param aUsername   用户B
 *  @param aMessage    好友邀请信息
 *
 *  \~english
 *  User A will receive this callback after user B requested to add user A as a friend
 *
 *  @param aUsername   User B
 *  @param aMessage    Friend invitation message
 */
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage
{
    if (!aUsername) {
        return;
    }
    
    if (!aMessage) {
        aMessage = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyAddWithName", @"%@ add you as a friend"), aUsername];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":aUsername, @"username":aUsername, @"applyMessage":aMessage, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleFriend]}];
    NSMutableArray * dataSource =  [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"applyCation"]];
    [dataSource addObject:dic];
    [[NSUserDefaults standardUserDefaults] setObject:dataSource forKey:@"applyCation"];
    BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
    if (!isAppActivity) {
        //发送本地推送
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate date]; //触发通知的时间
        notification.alertBody = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyAddWithName", @"%@ add you as a friend"), aUsername];
        notification.alertAction = NSLocalizedString(@"open", @"Open");
        notification.timeZone = [NSTimeZone defaultTimeZone];
    }
    
}

#pragma mark - App Delegate

// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient] bindDeviceToken:deviceToken];
    });
}

// 注册deviceToken失败，此处失败，与环信SDK无关，一般是您的环境配置或者证书配置有误
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.failToRegisterApns", Fail to register apns)
                                                    message:error.description
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
