//
//  UISlider+WCBlock.h
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/17.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISlider (WCBlock)
/**@!brief EN:bind slider object call back. zh-CN: 绑定slider切换回调
 * @param block  call back.  zh-CN :回调
 */
-(void)wc_bindSliderValueChangedBlockNext:(void (^)(CGFloat value))block;
@end
