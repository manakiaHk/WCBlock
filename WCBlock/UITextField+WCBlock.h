//
//  UITextField+WCBlock.h
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/16.
//  Copyright © 2018年 hello. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UITextField (WCBlock)
///EN:bind callback for textField object editing did begin. zh-CN: 绑定textField开始编辑回调
- (void)wc_bindTextFieldEditingDidBeginBlockNext:(void (^)(UITextField *textField))block; // became first responder

///EN:bind callback for textField object in editing. zh-CN: 绑定textField正在编辑回调
- (void)wc_bindTextFieldEditingChangedBlockNext:(void (^)(UITextField *textField,NSString *value))block;

///EN:bind callback for textField object editing did end. zh-CN: 绑定textField结束编辑回调
- (void)wc_bindTextFieldEditingDidEndBlockNext:(void (^)(UITextField *textField))block;// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

///EN:bind callback for textField object editing did end on exit.zh-CN: 绑定textField “return”键结束编辑回调
- (void)wc_bindTextFieldEditingDidEndOnExitBlockNext:(void (^)(UITextField *textField))block;

//>>>>>>>>>>>>>>>>>TextField hander block>>>>>>>>>>>>>>>>>>>
// EN:for using methods as bellow you need to be knowed that if you use its delegate to listen UITextField object and also use the following block handler at the same time,it will be effective by only one way , this depends on your  opportunity to set up delegate  and block handler for UITextField object (later effective), it's important about this.
// zh-CN: 如果你在监听textField行为的时候使用了代理实现的方式又使用了以下方法绑定回调的方式，将只有一种方案有效，取决于你为textField设置代理delegate的时机,最终都是后来者有效。这点你需要知晓并希望你选者其一。
///bind  block handler for TextField object "shouldChangeCharacters"
- (void)wc_bindTextFieldShouldChangeCharactersHandlerBlock:(BOOL (^)(UITextField*textField,NSRange shouldChangeCharactersInRange ,NSString*replacementString))block;// return NO to not change text
///bind  block handler for TextField object "shouldBeginEditing"
- (void)wc_bindTextFieldShouldBeginEditingHandlerBlock:(BOOL (^)(UITextField*textField))block;// return NO to disallow editing.

///bind block handler for TextField object "shouldEndEditing"
- (void)wc_bindTextFieldShouldEndEditingHandlerBlock:(BOOL (^)(UITextField*textField))block;// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end

///bind block handler for TextField object "shouldReturn"
- (void)wc_bindTextFieldShouldReturnHandlerBlock:(BOOL (^)(UITextField*textField))block; // when 'return' key pressed. return NO to ignore.

///bind block handler  handler or TextField object "shouldClear"
- (void)wc_bindTextFieldShouldClearHandlerBlock:(BOOL (^)(UITextField*textField))block;// when clear button pressed. return NO to ignore (no notifications)

//>>>>>>>>>>>>>>>>> TextField hander block end>>>>>>>>>>>>>>>>>>>
@end
