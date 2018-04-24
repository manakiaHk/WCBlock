//
//  UISwitch+WCBlock.m
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/17.
//  Copyright © 2018年 hello. All rights reserved.
//

#import "UISwitch+WCBlock.h"
#import <objc/runtime.h>
static const int  wc_switchTarget_set_key;
@interface WCSwitchBlockTarget : NSObject
@property (nonatomic,copy)void(^block)(BOOL isOn);
@end
@implementation WCSwitchBlockTarget
-(void)wc_blockEmit:(UISwitch*)sender {
    if (self.block)self.block(sender.isOn);
}
@end
@implementation UISwitch (WCBlock)
-(void)wc_bindSwitchValueChangedBlockNext:(void (^)(BOOL isOn))block {
    WCSwitchBlockTarget *target = [WCSwitchBlockTarget new];
    target.block = block;
    [[self wc_blockTargetSet] addObject:target];
    [self addTarget:target action:@selector(wc_blockEmit:) forControlEvents:UIControlEventValueChanged];
}
-(NSMutableSet<WCSwitchBlockTarget*>*)wc_blockTargetSet{
    NSMutableSet *_targets = objc_getAssociatedObject(self, &wc_switchTarget_set_key);
    if (!_targets) {
        _targets = [NSMutableSet new];
        objc_setAssociatedObject(self,&wc_switchTarget_set_key,_targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _targets;
}

@end
