//
//  UIView+WCBlock.m
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/16.
//  Copyright © 2018年 hello. All rights reserved.
//

#import "UIView+WCBlock.h"
#import <objc/runtime.h>
static const int  wc_view_blockTarget_set_key;
@interface WCViewBlockTarget : NSObject
@property (nonatomic,copy)void(^block)(UIView *view);
@end
@implementation WCViewBlockTarget
@end
@implementation UIView (WCBlock)
-(void)wc_bindViewClickedBlockNext:(void (^)(UIView *view))block {
    [self wc_setTapGestureWithBlock:block];
}
-(void)wc_setTapGestureWithBlock:(void (^)(UIView *view))block {
    WCViewBlockTarget *target = [WCViewBlockTarget new];
    target.block = block;
    [[self wc_blockTargetSet] addObject:target];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wc_tapedView:)];
    [self addGestureRecognizer:gesture];
}
-(NSMutableSet<WCViewBlockTarget*>*)wc_blockTargetSet{
    NSMutableSet *_targets = objc_getAssociatedObject(self, &wc_view_blockTarget_set_key);
    if (!_targets) {
        _targets = [NSMutableSet new];
        objc_setAssociatedObject(self,&wc_view_blockTarget_set_key,_targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _targets;
}
- (void)wc_tapedView:(UIGestureRecognizer*)gesture {
    [[self wc_blockTargetSet]enumerateObjectsUsingBlock:^(WCViewBlockTarget * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.block) obj.block(gesture.view);
    }];
}
@end
