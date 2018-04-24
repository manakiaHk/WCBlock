//
//  UIAlertView+WCBlock.h
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/16.
//  Copyright © 2018年 hello. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (WCBlock)
/**@!brief EN:alertView object call back . zh-CN:绑定alertView回调
 * @param  block  call back.  zh-CN :回调
 * EN:for using methods as bellow you need to be knowed that if you use its delegate to listen UIAlertView object user click and also use the following block  at the same time,it will be effective by only one way , this depends on your  opportunity to set up delegate  and block  for UIAlertView object (later effective), it's important about this.
 * zh-CN:  如果你在使用UIAlertView用了代理监听点击,又用了此方法绑定，那么只有一种方案有效。这取决于你为UIAlertView 设置delegate的时机(后来者有效)。这点你需要知晓并希望你选者其一。
 */
-(void)wc_bindAlertButtonClickedBlockNext:(void (^)(NSInteger index))block;
@end
