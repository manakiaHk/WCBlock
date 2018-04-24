//
//  NSObject+WCKVOBlock.m
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/17.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import "NSObject+WCKVOBlock.h"
#import <objc/runtime.h>
static const int  wc_observer_set_key;
@interface WCKeyPathObserver: NSObject
@property (nonatomic,strong)NSString *keyPath;
@property (nonatomic,copy)void(^valueBlock)(NSString *keyPath,id ofObj,id oldValue,id newValue);
@property (nonatomic,copy)void(^changeBlock)(NSString *keyPath,id ofObj,NSDictionary<NSKeyValueChangeKey,id> *change);
@end
@implementation WCKeyPathObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    id newValue = [change objectForKey:NSKeyValueChangeNewKey];
    if (self.valueBlock&&[keyPath isEqualToString:self.keyPath]){
        self.valueBlock(keyPath, object, oldValue, newValue);
    }
    if (self.changeBlock&&[keyPath isEqualToString:self.keyPath]){
        self.changeBlock(keyPath, object, change);
    }
}
@end
@implementation NSObject (WCKVOBlock)
- (void)wc_addObserverForKeyPath:(NSString*)keyPath
                  valueBlockNext:(void(^)(NSString *keypath,id ofObj, id oldValue,id newValue))block {
    if (!keyPath)return;
    WCKeyPathObserver *observer = [WCKeyPathObserver new];
    observer.valueBlock  = block;
    observer.keyPath = keyPath;
    [self addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew  context:nil];
    [[self wc_observerSet] addObject:observer];
}
- (void)wc_addObserverForKeyPaths:(NSArray<NSString*>*)keyPaths
                   valueBlockNext:(void(^)(NSString *keypath,id ofObj, id oldValue,id newValue))block {
    [keyPaths enumerateObjectsUsingBlock:^(NSString * _Nonnull keyPath, NSUInteger idx, BOOL * _Nonnull stop) {
        [self wc_addObserverForKeyPath:keyPath valueBlockNext:block];
    }];
}
- (void)wc_addObserverForKeyPath:(NSString*)keyPath
                         options:(NSKeyValueObservingOptions)options
                 changeBlockNext:(void(^)(NSString *keypath,id ofObj, NSDictionary<NSKeyValueChangeKey,id> *change))block{
    if (!keyPath)return;
    WCKeyPathObserver *observer = [WCKeyPathObserver new];
    observer.changeBlock  = block;
    observer.keyPath = keyPath;
    [self addObserver:observer forKeyPath:keyPath options:options context:nil];
     [[self wc_observerSet] addObject:observer];
}

- (void)wc_addObserverForKeyPaths:(NSArray<NSString*>*)keyPaths
                          options:(NSKeyValueObservingOptions)options
                  changeBlockNext:(void(^)(NSString *keypath,id ofObj, NSDictionary<NSKeyValueChangeKey,id> *change))block{
    [keyPaths enumerateObjectsUsingBlock:^(NSString * _Nonnull keyPath, NSUInteger idx, BOOL * _Nonnull stop) {
        [self wc_addObserverForKeyPath:keyPath options:options changeBlockNext:block];
    }];
}
-(NSMutableSet<WCKeyPathObserver*>*)wc_observerSet{
    NSMutableSet<WCKeyPathObserver*> *_observerSet = objc_getAssociatedObject(self, &wc_observer_set_key);
    if (!_observerSet) {
        _observerSet = [NSMutableSet new];
        objc_setAssociatedObject(self,&wc_observer_set_key,_observerSet, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _observerSet;
}
- (void)wc_removeObserverForKeyPath:(NSString*)keyPath {
    [[self wc_observerSet]  enumerateObjectsUsingBlock:^(WCKeyPathObserver * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj.keyPath isEqualToString:keyPath]){
           [self removeObserver:obj forKeyPath:keyPath];
           [[self wc_observerSet]  removeObject:obj];
        }
    }];
}
- (void)wc_removeObserverForKeyPaths:(NSArray<NSString*>*)keyPaths {
    [keyPaths enumerateObjectsUsingBlock:^(NSString * _Nonnull keyPath, NSUInteger idx, BOOL * _Nonnull stop) {
        [self wc_removeObserverForKeyPath:keyPath];
    }];
}
- (void)wc_removeAllKeyValueObservers{
    [[self wc_observerSet]  enumerateObjectsUsingBlock:^(WCKeyPathObserver * _Nonnull obj, BOOL * _Nonnull stop) {
        [self removeObserver:obj forKeyPath:obj.keyPath];
        if (stop) {
            [[self wc_observerSet] removeAllObjects];
        }
    }];
}
@end
