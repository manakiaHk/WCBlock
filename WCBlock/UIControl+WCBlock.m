//
//  UIControl+WCBlock.m
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/16.
//  Copyright © 2018年 hello. All rights reserved.
//

#import "UIControl+WCBlock.h"
#import <objc/runtime.h>
static const int  wc_control_blockTarget_set_key;
@interface WCControlBlockTarget : NSObject
@property (nonatomic,copy)void(^block)(id sender);
@end
@implementation WCControlBlockTarget
-(void)wc_blockEmit:(id)sender {
    if (self.block)self.block(sender);
}
@end
@implementation UIControl (WCBlock)
-(void)wc_bindForControlEvents:(UIControlEvents)controlEvents blockNext:(void (^)(id sender))block {
    WCControlBlockTarget *target = [WCControlBlockTarget new];
     target.block = block;
    [[self wc_blockTargetSet] addObject:target];
    [self addTarget:target action:@selector(wc_blockEmit:) forControlEvents:controlEvents];
}
-(NSMutableSet<WCControlBlockTarget*>*)wc_blockTargetSet{
    NSMutableSet *_targets = objc_getAssociatedObject(self, &wc_control_blockTarget_set_key);
    if (!_targets) {
        _targets = [NSMutableSet new];
    objc_setAssociatedObject(self,&wc_control_blockTarget_set_key,_targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _targets;
}
@end
