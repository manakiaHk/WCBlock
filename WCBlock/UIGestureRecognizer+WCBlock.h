//
//  UIGestureRecognizer+WCBlock.h
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/16.
//  Copyright © 2018年 hello. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (WCBlock)
/**@!brief EN: bind gesturerecognizer  object call back . ch-ZN:绑定手势回调
 * @param block  call back.  zh-CN :回调
 */
-(void)wc_bindGestureBlockNext:(void (^)(UIGestureRecognizer *sender))block;
@end
