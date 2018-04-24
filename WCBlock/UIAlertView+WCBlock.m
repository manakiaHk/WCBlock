//
//  UIAlertView+WCBlock.m
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/16.
//  Copyright © 2018年 hello. All rights reserved.
//

#import "UIAlertView+WCBlock.h"
#import <objc/runtime.h>
static const int  wc_alertView_blockTarget_set_key;
@interface WCAlertViewBlockTarget : NSObject
@property (nonatomic,copy)void(^block)(NSInteger index);
@end
@implementation WCAlertViewBlockTarget
@end
@interface UIAlertView ()<UIAlertViewDelegate>
@end
@implementation UIAlertView (WCBlock)
-(void)wc_bindAlertButtonClickedBlockNext:(void (^)(NSInteger index))block {
    WCAlertViewBlockTarget *target = [WCAlertViewBlockTarget new];
    target.block = block;
    [[self wc_blockTargetSet] addObject:target];
    self.delegate = self;
}
-(NSMutableSet<WCAlertViewBlockTarget*>*)wc_blockTargetSet{
    NSMutableSet *_targets = objc_getAssociatedObject(self, &wc_alertView_blockTarget_set_key);
    if (!_targets) {
        _targets = [NSMutableSet new];
        objc_setAssociatedObject(self,&wc_alertView_blockTarget_set_key,_targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _targets;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  {
    [[self wc_blockTargetSet] enumerateObjectsUsingBlock:^(WCAlertViewBlockTarget * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.block)obj.block(buttonIndex);
    }];
}
@end
