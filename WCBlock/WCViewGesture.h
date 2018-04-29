//
//  WCViewGesture.h
//  WCBlock
//
//  Created by zhao weicheng on 2018/4/29.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WCViewTap:UITapGestureRecognizer
@end
@interface WCViewSwipe:UISwipeGestureRecognizer
@end
@interface WCViewLongPress:UILongPressGestureRecognizer
@end
@interface WCViewPan:UIPanGestureRecognizer
@end
@interface WCViewPinch: UIPinchGestureRecognizer
@end
@interface WCViewRotation:UIRotationGestureRecognizer
@end
@interface WCViewScreenEdgePan:UIScreenEdgePanGestureRecognizer
@end
