//
//  NSNotificationCenter+WCBlock.m
//  WCBlock
//
//  Created by zhao weicheng on 2018/4/28.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import "NSNotificationCenter+WCBlock.h"
#import <objc/runtime.h>

@interface WCNotifObserverTarget:NSObject
@property (nonatomic,weak) id notifObserver;
@property (nonatomic,weak) id notifName;
@property (nonatomic,weak) id notifObj;
@property (nonatomic,copy) void (^notifBlock)(NSNotification *note);
@end
@implementation WCNotifObserverTarget
- (void)dealloc {
    NSLog(@"%@",[WCNotifObserverTarget description]);
    [[NSNotificationCenter defaultCenter]  removeObserver:self.notifObserver name:self.notifName object:self.notifObj];
}

- (void)notifReceived:(NSNotification*)note {
    if (self.notifBlock) {
        self.notifBlock(note);
    }
}
@end
static const int wc_notification_observer_target_set_key;
@implementation NSNotificationCenter (WCBlock)
-(void)wc_addObserverForName:(NSString*)name
                      object:(id)obj
                  contextObj:(id)contextObj
                       queue:(NSOperationQueue *)queue
                   blockNext:(void (^)(NSNotification *note))block {
    
    // 原理： contextObj --> set<WCNotifObserverTarget*> --> target --> observers  当contextObj 销毁后 observers随着销毁 dealloc 中移除 observer
    WCNotifObserverTarget  *target = [WCNotifObserverTarget new];
    [[self wc_observerTargetSetOfContextObj:contextObj]addObject:target];
    target.notifObj = obj;
    target.notifName = name;
    target.notifBlock = block;
    __weak typeof(target) weakTarget = target;
    target.notifObserver =  [[NSNotificationCenter defaultCenter] addObserverForName:name object:obj queue:queue usingBlock:^(NSNotification * _Nonnull note) {
        __strong typeof(weakTarget) strongTarget = weakTarget;
        if (strongTarget.notifBlock) strongTarget.notifBlock(note);
    }];
}
-(void)wc_addObserverForName:(nonnull NSString*)name
                      object:(id _Nullable)obj
                  contextObj:(nonnull id)contextObj
                   blockNext:(void (^_Nullable)(NSNotification * _Nullable note))block {
    
    WCNotifObserverTarget  *target = [WCNotifObserverTarget new];
    [[self wc_observerTargetSetOfContextObj:contextObj]addObject:target];
    target.notifObj = obj;
    target.notifName = name;
    target.notifBlock = block;
    [[NSNotificationCenter defaultCenter]  addObserver:target selector:@selector(notifReceived:) name:name object:obj];
}
-(NSMutableSet<WCNotifObserverTarget*>*)wc_observerTargetSetOfContextObj:(id)obj{
    NSMutableSet *_set = objc_getAssociatedObject(obj, &wc_notification_observer_target_set_key);
    if (!_set) {
        _set = [NSMutableSet new];
        objc_setAssociatedObject(obj,&wc_notification_observer_target_set_key,_set, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _set;
}
@end
