//
//  GYNotificationOberverIdentifer.h
//  WeRead
//
//  Created by on 16/7/4.
//  Copyright © 2016年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^XTNotificatioObserverBlock)(NSNotification *notification);

@interface XTNotificationOberverIdentifer : NSObject

@property(nonatomic,strong) NSString *name;

- (void)congifureWithName:(NSString *)anName
               withObject:(id)object
        withDispatchQueue:(dispatch_queue_t)dispatchQueue
                withBlock:(XTNotificatioObserverBlock)block;

- (void)stopObserver;

@end


@interface XTNotificationOberverIdentifersContainer : NSObject

- (void)addNotificationOberverIdentifer:(XTNotificationOberverIdentifer *)identifier;

- (void)removeObserverWithName:(NSString *)name;

- (void)removeObserver;
@end