//
//  UIView+WCBlock.m
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/16.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import "UIView+WCBlock.h"
#import <objc/runtime.h>

@interface WCViewBlockTarget : NSObject
@property (nonatomic,copy)void(^tapBlock)(UIView *,WCViewTap *);
@property (nonatomic,copy)void(^swipeBlock)(UIView *,WCViewSwipe *);
@property (nonatomic,copy)void(^longPressBlock)(UIView*,WCViewLongPress *);
@property (nonatomic,copy)void(^panBlock)(UIView *,WCViewPan *);
@property (nonatomic,copy)void(^pinchBlock)(UIView *,WCViewPinch *);
@property (nonatomic,copy)void(^rotationBlock)(UIView *,WCViewRotation *);
@property (nonatomic,copy)void(^screenEdgePanBlock)(UIView *,WCViewScreenEdgePan *);
@property (nonatomic,weak) UIView *view;
@end
@implementation WCViewBlockTarget
@end
@implementation UIView (WCBlock)

-(WCViewTap*)wc_bindViewTapBlockNext:(void (^)(UIView *view,WCViewTap *tap))block{
     return [self wc_setTapGestureWithBlock:block];
}

-(WCViewSwipe*)wc_bindViewSwipeBlockNext:(void (^)(UIView *view,WCViewSwipe *swipe))block {
   return [self wc_setSwipeGestureWithBlock:block];
}

-(WCViewLongPress*)wc_bindViewLongPressBlockNext:(void (^)(UIView *view,WCViewLongPress *longPress))block {
   return [self wc_setLongPressGestureWithBlock:block];
}

-(WCViewPan*)wc_bindViewPanBlockNext:(void (^)(UIView *view,WCViewPan *pan))block {
    return  [self wc_setPanGestureWithBlock:block];
}

-(WCViewPinch*)wc_bindViewPinchBlockNext:(void (^)(UIView *view,WCViewPinch *pinch))block {
    return [self wc_setPinchGestureWithBlock:block];
}

-(WCViewRotation*)wc_bindViewRotationBlockNext:(void (^)(UIView *view,WCViewRotation *rotation))block {
    return [self wc_setRotationGestureWithBlock:block];
}

-(WCViewScreenEdgePan*)wc_bindViewScreenEdgePanBlockNext:(void (^)(UIView *view,WCViewScreenEdgePan *screenEdgePan))block {
    return [self wc_setScreenEdgePanGestureWithBlock:block];
}

-(WCViewTap*)wc_setTapGestureWithBlock:(void (^)(UIView*,WCViewTap*))block {
    WCViewBlockTarget *target = [WCViewBlockTarget new];
    target.tapBlock  = block;
    [[self wc_blockTargetSet] addObject:target];
    WCViewTap *gesture = (WCViewTap*)[self wc_gestureRecognizerOf:[WCViewTap class]];
    if (!gesture) {
        gesture = [[WCViewTap alloc] initWithTarget:self action:@selector(wc_viewGestrueEmit:)];
        [self addGestureRecognizer:gesture];
    }
    return gesture;
}
-(WCViewSwipe*)wc_setSwipeGestureWithBlock:(void (^)(UIView*,WCViewSwipe*))block {
    WCViewBlockTarget *target = [WCViewBlockTarget new];
    target.swipeBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    WCViewSwipe *gesture = (WCViewSwipe*)[self wc_gestureRecognizerOf:[WCViewSwipe class]];
    if (!gesture) {
        gesture = [[WCViewSwipe alloc] initWithTarget:self action:@selector(wc_viewGestrueEmit:)];
        [self addGestureRecognizer:gesture];
    }
    return gesture;
}
-(WCViewLongPress*)wc_setLongPressGestureWithBlock:(void (^)(UIView*,WCViewLongPress*))block {
    WCViewBlockTarget *target = [WCViewBlockTarget new];
    target.longPressBlock  = block;
    [[self wc_blockTargetSet] addObject:target];
    WCViewLongPress *gesture = (WCViewLongPress*)[self wc_gestureRecognizerOf:[WCViewLongPress class]];
    if (!gesture) {
        gesture = [[WCViewLongPress alloc] initWithTarget:self action:@selector(wc_viewGestrueEmit:)];
        [self addGestureRecognizer:gesture];
    }
    return gesture;
}
-(WCViewPan*)wc_setPanGestureWithBlock:(void (^)(UIView*,WCViewPan*))block {
    WCViewBlockTarget *target = [WCViewBlockTarget new];
    target.panBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    WCViewPan *gesture = (WCViewPan*)[self wc_gestureRecognizerOf:[WCViewPan class]];
    if (!gesture) {
        gesture = [[WCViewPan alloc] initWithTarget:self action:@selector(wc_viewGestrueEmit:)];
        [self addGestureRecognizer:gesture];
    }
    return gesture;
}
-(WCViewPinch*)wc_setPinchGestureWithBlock:(void (^)(UIView*,WCViewPinch*))block {
    WCViewBlockTarget *target = [WCViewBlockTarget new];
    target.pinchBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    WCViewPinch *gesture = (WCViewPinch*)[self wc_gestureRecognizerOf:[WCViewPinch class]];
    if (!gesture) {
        gesture = [[WCViewPinch alloc] initWithTarget:self action:@selector(wc_viewGestrueEmit:)];
        [self addGestureRecognizer:gesture];
    }
    return gesture;
}
-(WCViewRotation*)wc_setRotationGestureWithBlock:(void (^)(UIView*,WCViewRotation*))block {
    WCViewBlockTarget *target = [WCViewBlockTarget new];
    target.rotationBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    WCViewRotation *gesture = (WCViewRotation*)[self wc_gestureRecognizerOf:[WCViewRotation class]];
    if (!gesture) {
        gesture = [[WCViewRotation alloc] initWithTarget:self action:@selector(wc_viewGestrueEmit:)];
        [self addGestureRecognizer:gesture];
    }
    return gesture;
}
-(WCViewScreenEdgePan*)wc_setScreenEdgePanGestureWithBlock:(void (^)(UIView*,WCViewScreenEdgePan*))block {
    WCViewBlockTarget *target = [WCViewBlockTarget new];
    target.screenEdgePanBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    WCViewScreenEdgePan *gesture = (WCViewScreenEdgePan*)[self wc_gestureRecognizerOf:[WCViewScreenEdgePan class]];
    if (!gesture) {
        gesture = [[WCViewScreenEdgePan alloc] initWithTarget:self action:@selector(wc_viewGestrueEmit:)];
        [self addGestureRecognizer:gesture];
    }
    return gesture;
}

-(NSMutableSet<WCViewBlockTarget*>*)wc_blockTargetSet{
    static const int  wc_view_blockTarget_set_key;
    NSMutableSet *_targets = objc_getAssociatedObject(self, &wc_view_blockTarget_set_key);
    if (!_targets) {
        _targets = [NSMutableSet new];
        objc_setAssociatedObject(self,&wc_view_blockTarget_set_key,_targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _targets;
}
- (UIGestureRecognizer*)wc_gestureRecognizerOf:(Class)gestureCalss{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        if ([gesture isKindOfClass:gestureCalss]) {
            return gesture;
            break;
        }
    }
    return nil;
}
- (void)wc_viewGestrueEmit:(id)sender {
    [[self wc_blockTargetSet]enumerateObjectsUsingBlock:^(WCViewBlockTarget * _Nonnull target, BOOL * _Nonnull stop) {
        if ([sender isKindOfClass:[WCViewTap class]]) {
            WCViewTap *tap = (WCViewTap*)sender;
            if (target.tapBlock) target.tapBlock(tap.view, tap);
        }else if ([sender isKindOfClass:[WCViewSwipe class]]) {
            WCViewSwipe *swipe = (WCViewSwipe*)sender;
            if (target.swipeBlock) target.swipeBlock(swipe.view, swipe);
        }else if ([sender isKindOfClass:[WCViewLongPress class]]) {
            WCViewLongPress *longPress = (WCViewLongPress*)sender;
            if (target.longPressBlock) target.longPressBlock(longPress.view, longPress);
        }else if ([sender isKindOfClass:[WCViewPan class]]) {
            WCViewPan *pan = (WCViewPan*)sender;
            if (target.panBlock) target.panBlock(pan.view, pan);
        }else if ([sender isKindOfClass:[WCViewPinch class]]) {
            WCViewPinch *pinch = (WCViewPinch*)sender;
            if (target.pinchBlock) target.pinchBlock(pinch.view, pinch);
        }else if ([sender isKindOfClass:[WCViewRotation class]]) {
            WCViewRotation *rotation = (WCViewRotation*)sender;
            if (target.rotationBlock) target.rotationBlock(rotation.view, rotation);
        }else if ([sender isKindOfClass:[WCViewScreenEdgePan class]]){
            WCViewScreenEdgePan *screenEdgePan = (WCViewScreenEdgePan*)sender;
            if (target.screenEdgePanBlock) target.screenEdgePanBlock(screenEdgePan.view, screenEdgePan);
        }else {
            ///..none
        }
    }];
}

@end
