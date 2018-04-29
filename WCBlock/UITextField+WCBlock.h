//
//  UITextField+WCBlock.h
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/16.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UITextField (WCBlock)

- (void)wc_bindTextFieldEditingDidBeginBlockNext:(void (^)(UITextField *textField))block;
- (void)wc_bindTextFieldEditingChangedBlockNext:(void (^)(UITextField *textField,NSString *value))block;
- (void)wc_bindTextFieldEditingDidEndBlockNext:(void (^)(UITextField *textField))block;
- (void)wc_bindTextFieldEditingDidEndOnExitBlockNext:(void (^)(UITextField *textField))block;

//>>>>>>>>>>>>>>>>>TextField hander block>>>>>>>>>>>>>>>>>>>
// EN:for using methods as bellow you need to be knowed that if you use its delegate to listen UITextField object and also use the following block handler at the same time,it will be effective by only one way , this depends on your  opportunity to set up delegate  and block handler for UITextField object (later effective), it's important about this.
// zh-CN:对于以下handler回调你需要知道， 如果你使用了自己的代理实现的方式又使用了以下handlerBlock回调的方式，将只有一种方案有效，取决于你为textField设置代理delegate的时机,最终都是后来者有效。这点你需要知晓，并希望你选者其一。

- (void)wc_bindTextFieldShouldChangeCharactersHandlerBlock:(BOOL (^)(UITextField*textField,NSRange inRange ,NSString*replacementString))block;// return NO to not change text

- (void)wc_bindTextFieldShouldBeginEditingHandlerBlock:(BOOL (^)(UITextField*textField))block;// return NO to disallow editing.

- (void)wc_bindTextFieldShouldEndEditingHandlerBlock:(BOOL (^)(UITextField*textField))block;// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end

- (void)wc_bindTextFieldShouldReturnHandlerBlock:(BOOL (^)(UITextField*textField))block; // when 'return' key pressed. return NO to ignore.

- (void)wc_bindTextFieldShouldClearHandlerBlock:(BOOL (^)(UITextField*textField))block;// when clear button pressed. return NO to ignore (no notifications)

@end
