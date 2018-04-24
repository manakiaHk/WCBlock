//
//  UISwitch+WCBlock.h
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/17.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISwitch (WCBlock)
/**@!brief EN: bind switch object call back.  zh-CN:绑定switch切换回调
 * @param block EN: call back.  zh-CN :回调
 */
-(void)wc_bindSwitchValueChangedBlockNext:(void (^)(BOOL isOn))block;
@end
