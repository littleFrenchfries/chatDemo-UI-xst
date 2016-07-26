//
//  GYNotificationCenter.m
//  WeRead
//
//  Created by on 16/7/4.
//  Copyright © 2016年 tencent. All rights reserved.
//

#import "XTNotificationCenter.h"
#import <pthread.h>
#import <objc/runtime.h>

#define GY_NOTIFICATION_CONTAINER_KEY @"gyNotificationContainerKey"

@implementation XTNotificationCenter

+ (instancetype)defaultCenter {
    
    static XTNotificationCenter *defaultCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCenter = [[XTNotificationCenter alloc] init];
    });
    return defaultCenter;
    
}

#pragma mark -- add observer

- (void)addObserver:(nonnull id)observer
               name:(nonnull NSString *)aName
              block:(nonnull XTNotificatioObserverBlock)block {
    
    [self addObserver:observer name:aName object:nil dispatchQueue:nil block:block];
    
}

- (void)addObserver:(nonnull id)observer
               name:(nonnull NSString *)aName
      dispatchQueue:(nullable dispatch_queue_t)disPatchQueue
              block:(nonnull XTNotificatioObserverBlock)block {
    
    [self addObserver:observer name:aName object:nil dispatchQueue:disPatchQueue block:block];
    
}

- (void)addObserver:(nonnull id)observer
               name:(nonnull NSString *)aName
             object:(nullable id)anObject
              block:(nonnull XTNotificatioObserverBlock)block {
    
    [self addObserver:observer name:aName object:anObject dispatchQueue:nil block:block];
    
}

- (void)addObserver:(nonnull id)observer
               name:(nonnull NSString *)aName
             object:(nullable id)anObject
      dispatchQueue:(nullable dispatch_queue_t)disPatchQueue
              block:(nonnull XTNotificatioObserverBlock)block {
    
    [self addWithContainerBlock:^(XTNotificationOberverIdentifersContainer *container) {
        
        XTNotificationOberverIdentifer *identifier = [[XTNotificationOberverIdentifer alloc] init];
        [identifier congifureWithName:aName withObject:anObject withDispatchQueue:disPatchQueue withBlock:block];
        
        [container addNotificationOberverIdentifer:identifier];
        
    } toObserver:observer];
}

- (void)addWithContainerBlock:(void (^)(XTNotificationOberverIdentifersContainer *container)) block
                   toObserver:(id)observer {
    
    NotificationPerformLocked(^{
        
        //get container
        XTNotificationOberverIdentifersContainer *notificationOberverIdentifersContainer = (XTNotificationOberverIdentifersContainer *)objc_getAssociatedObject(observer, GY_NOTIFICATION_CONTAINER_KEY);
        
        //add to container
        if (!notificationOberverIdentifersContainer) {
            notificationOberverIdentifersContainer = [[XTNotificationOberverIdentifersContainer alloc] init];
            objc_setAssociatedObject(observer, GY_NOTIFICATION_CONTAINER_KEY, notificationOberverIdentifersContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
        block(notificationOberverIdentifersContainer);
    });
}


#pragma mark -- remove observer

- (void)removerObserver:(nonnull id)observer
                   name:(nonnull NSString *)anName
                 object:(nullable id)anObject {
    
    NotificationPerformLocked(^{
        
        //get container
        XTNotificationOberverIdentifersContainer *notificationOberverIdentifersContainer = (XTNotificationOberverIdentifersContainer *)objc_getAssociatedObject(observer, GY_NOTIFICATION_CONTAINER_KEY);
        
        //add to container
        if (notificationOberverIdentifersContainer) {
            [notificationOberverIdentifersContainer removeObserverWithName:anName];
        }
    });
}

- (void)removerObserver:(nonnull id)observer {
    
    NotificationPerformLocked(^{
        
        //get container
        XTNotificationOberverIdentifersContainer *notificationOberverIdentifersContainer = (XTNotificationOberverIdentifersContainer *)objc_getAssociatedObject(observer, GY_NOTIFICATION_CONTAINER_KEY);
        
        //add to container
        if (notificationOberverIdentifersContainer) {
            [notificationOberverIdentifersContainer removeObserver];
        }
    });
}

#pragma mark - post Notification

- (void)postNotification:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
    
}

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];
    
}

#pragma mark -- helper

static void NotificationPerformLocked(dispatch_block_t block) {
    static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
    pthread_mutex_lock(&mutex);
    block();
    pthread_mutex_unlock(&mutex);
}
@end
