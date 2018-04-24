//
//  UISegmentedControl+WCBlock.h
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/17.
//  Copyright © 2018年 hello. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISegmentedControl (WCBlock)
/**@!brief EN:bind segmentControl object call back. zh-CN:绑定segmentControl切换回调
 * @param block  call back.  zh-CN :回调
 */
-(void)wc_bindSegmentControlValueChangedBlockNext:(void (^)(NSInteger selectedIndex))block;
@end
