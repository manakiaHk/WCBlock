//
//  UISlider+WCBlock.m
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/17.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import "UISlider+WCBlock.h"
#import <objc/runtime.h>
static const int  wc_sliderTarget_set_key;
@interface WCSliderBlockTarget : NSObject
@property (nonatomic,copy)void(^block)(CGFloat value);
@end
@implementation WCSliderBlockTarget
-(void)wc_blockEmit:(UISlider*)sender {
    if (self.block)self.block(sender.value);
}
@end
@implementation UISlider (WCBlock)
-(void)wc_bindSliderValueChangedBlockNext:(void (^)(CGFloat value))block {
    WCSliderBlockTarget *target = [WCSliderBlockTarget new];
    target.block = block;
    [[self wc_blockTargetSet] addObject:target];
    [self addTarget:target action:@selector(wc_blockEmit:) forControlEvents:UIControlEventValueChanged];
}
-(NSMutableSet<WCSliderBlockTarget*>*)wc_blockTargetSet{
    NSMutableSet *_targets = objc_getAssociatedObject(self, &wc_sliderTarget_set_key);
    if (!_targets) {
        _targets = [NSMutableSet new];
        objc_setAssociatedObject(self,&wc_sliderTarget_set_key,_targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _targets;
}
@end
