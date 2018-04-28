//
//  NSNotificationCenter+WCBlock.h
//  WCBlock
//
//  Created by zhao weicheng on 2018/4/28.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (WCBlock)
/**@!brief 通知中心添加监听者(内部自动管理移除observer)
 * @param name 通知名
 * @param contextObj  调用的上下文对象(一般是self) ***毕传**
 * @param queue  block执行队列
 * @param block 接收到通知的回调
 */
-(void)wc_addObserverForName:(nonnull NSString*)name
                      object:(id _Nullable)obj
                  contextObj:(nonnull id)contextObj
                       queue:(NSOperationQueue *_Nullable)queue
                   blockNext:(void (^_Nullable)(NSNotification * _Nullable note))block;
/**@!brief 通知中心添加监听者(内部自动管理移除observer)
 * @param name 通知名
 * @param contextObj  调用的上下文对象(一般是self) ***毕传**
 * @param block 接收到通知的回调
 */
-(void)wc_addObserverForName:(nonnull NSString*)name
                      object:(id _Nullable)obj
                  contextObj:(nonnull id)contextObj
                   blockNext:(void (^_Nullable)(NSNotification * _Nullable note))block;

@end
