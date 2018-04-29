//
//  UIView+WCBlock.h
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/16.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCViewGesture.h"
@interface UIView (WCBlock)
///轻拍
-(WCViewTap*)wc_bindViewTapBlockNext:(void (^)(UIView *view,WCViewTap *tap))block;
///轻扫
-(WCViewSwipe*)wc_bindViewSwipeBlockNext:(void (^)(UIView *view,WCViewSwipe *swipe))block;
///长按
-(WCViewLongPress*)wc_bindViewLongPressBlockNext:(void (^)(UIView *view,WCViewLongPress *longPress))block;
///平移
-(WCViewPan*)wc_bindViewPanBlockNext:(void (^)(UIView *view,WCViewPan *pan))block;
///捏合（缩放）
-(WCViewPinch*)wc_bindViewPinchBlockNext:(void (^)(UIView *view,WCViewPinch *pinch))block;
///旋转
-(WCViewRotation*)wc_bindViewRotationBlockNext:(void (^)(UIView *view,WCViewRotation *rotation))block ;
///屏幕边缘平移
-(WCViewScreenEdgePan*)wc_bindViewScreenEdgePanBlockNext:(void (^)(UIView *view,WCViewScreenEdgePan *screenEdgePan))block;
@end
