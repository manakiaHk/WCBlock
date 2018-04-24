//
//  UISegmentedControl+WCBlock.m
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/17.
//  Copyright © 2018年 hello. All rights reserved.
//

#import "UISegmentedControl+WCBlock.h"
#import <objc/runtime.h>
static const int  wc_segmentControlTarget_set_key;
@interface WCSegmentControlBlockTarget : NSObject
@property (nonatomic,copy)void(^block)(NSInteger selectedIndex);
@end
@implementation WCSegmentControlBlockTarget
-(void)wc_blockEmit:(UISegmentedControl*)sender {
    if (self.block)self.block(sender.selectedSegmentIndex);
}
@end
@implementation UISegmentedControl (WCBlock)
-(void)wc_bindSegmentControlValueChangedBlockNext:(void (^)(NSInteger selectedIndex))block {
    WCSegmentControlBlockTarget *target = [WCSegmentControlBlockTarget new];
    target.block = block;
    [[self wc_blockTargetSet] addObject:target];
    [self addTarget:target action:@selector(wc_blockEmit:) forControlEvents:UIControlEventValueChanged];
}
-(NSMutableSet<WCSegmentControlBlockTarget*>*)wc_blockTargetSet{
    NSMutableSet *_targets = objc_getAssociatedObject(self, &wc_segmentControlTarget_set_key);
    if (!_targets) {
        _targets = [NSMutableSet new];
        objc_setAssociatedObject(self,&wc_segmentControlTarget_set_key,_targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _targets;
}

@end
