//
//  UIView+WCBlock.h
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/16.
//  Copyright © 2018年 hello. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WCBlock)
/**@!brief EN: bind view object clicked call back . zh-CN:绑定view点击回调
 * @param block  call back.  zh-CN :回调
 */
-(void)wc_bindViewClickedBlockNext:(void (^)(UIView *view))block;
@end
