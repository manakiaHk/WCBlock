//
//  UIControl+WCBlock.h
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/16.
//  Copyright © 2018年 hello. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (WCBlock)
/**@!brief: bind event callback for an UIControl object , e.g :sliders,buttons,switch, etc.
 * @param controlEvents , event type of UIControlEvents.
 * @param block , will call this block when event emited.
 */
-(void)wc_bindForControlEvents:(UIControlEvents)controlEvents blockNext:(void (^)(id sender))block;
@end
