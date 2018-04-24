//
//  UIGestureRecognizer+WCBlock.m
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/16.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import "UIGestureRecognizer+WCBlock.h"
#import <objc/runtime.h>
static const int  wc_gesture_blockTarget_set_key;
@interface WCGestureBlockTarget : NSObject
@property (nonatomic,copy)void(^block)(id sender);
@end
@implementation WCGestureBlockTarget
-(void)wc_blockEmit:(id)sender {
    if (self.block)self.block(sender);
}
@end
@implementation UIGestureRecognizer (WCBlock)
-(void)wc_bindGestureBlockNext:(void (^)(UIGestureRecognizer *sender))block{
    WCGestureBlockTarget *target = [WCGestureBlockTarget new];
    target.block = block;
    [self addTarget:target action:@selector(wc_blockEmit:)];
    [[self wc_blockTargetSet] addObject:target];
}
-(NSMutableSet<WCGestureBlockTarget*>*)wc_blockTargetSet{
    NSMutableSet *_targets = objc_getAssociatedObject(self, &wc_gesture_blockTarget_set_key);
    if (!_targets) {
        _targets = [NSMutableSet new];
        objc_setAssociatedObject(self,&wc_gesture_blockTarget_set_key,_targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _targets;
}
@end
