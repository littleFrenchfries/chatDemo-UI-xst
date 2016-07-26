//
//  GYNotificationCenter.h
//  WeRead
//
//  Created by  on 16/7/4.
//  Copyright © 2016年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTNotificationOberverIdentifer.h"

@interface XTNotificationCenter : NSObject

+ (nullable instancetype)defaultCenter;

#pragma mark -- add observer

- (void)addObserver:(nonnull id)observer
              name:(nonnull NSString *)aName
             block:(nonnull XTNotificatioObserverBlock)block;

- (void)addObserver:(nonnull id)observer
              name:(nonnull NSString *)aName
     dispatchQueue:(nullable dispatch_queue_t)disPatchQueue
             block:(nonnull XTNotificatioObserverBlock)block;

- (void)addObserver:(nonnull id)observer
              name:(nonnull NSString *)aName
            object:(nullable id)anObject
             block:(nonnull XTNotificatioObserverBlock)block;

- (void)addObserver:(nonnull id)observer
              name:(nonnull NSString *)aName
            object:(nullable id)anObject
     dispatchQueue:(nullable dispatch_queue_t)disPatchQueue
             block:(nonnull XTNotificatioObserverBlock)block;

#pragma mark -- remove observer

- (void)removerObserver:(nonnull id)observer
                   name:(nonnull NSString *)anName
                 object:(nullable id)anObject;

- (void)removerObserver:(nonnull id)observer;

#pragma mark - post Notification

- (void)postNotification:(nonnull NSNotification *)notification;

- (void)postNotificationName:(nonnull NSString *)aName object:(nullable id)anObject;

- (void)postNotificationName:(nonnull NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

@end
