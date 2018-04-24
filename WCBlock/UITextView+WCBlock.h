//
//  UITextView+WCBlock.h
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/17.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (WCBlock)
/**@!brief EN: bind TextView object editingChanged call back. zh-CN:绑定textView编辑中回调
 * @param block  call back.  zh-CN :回调
 */
- (void)wc_bindTextViewEditingChangedBlockNext:(void (^)(UITextView *textView,NSString *value))block;
/**@!brief EN: bind TextView object editing did begin call back. zh-CN:绑定textView开始编辑回调
 * @param block  call back.  zh-CN :回调
 */
- (void)wc_bindTextViewEditingDidBeginBlockNext:(void (^)(UITextView *textField))block;
/**@!brief EN: bind TextView object editing did end call back. zh-CN:绑定textView结束编辑回调
 * @param block  call back.  zh-CN :回调
 */
- (void)wc_bindTextViewEditingDidEndBlockNext:(void (^)(UITextView *textField))block;

//>>>>>>>>>>>>>>>>textView hander block>>>>>>>>>>>>>
// EN:for using methods as bellow you need to be knowed that if you use its delegate to listen UITextView object and also use the following block handler at the same time,it will be effective by only one way , this depends on your  opportunity to set up delegate  and block handler for UITextField object (later effective), it's important about this.
// zh-CN: 如果你在监听textView行为的时候使用了代理实现的方式又使用了以下方法绑定回调的方式，将只有一种方案有效，取决于你为textField设置代理delegate的时机,最终都是后来者有效。这点你需要知晓并希望你选者其一。
///bind  block handler for textView object "shouldChangeText"
- (void)wc_bindTextViewShouldChangeTextWithHandlerBlock:(BOOL (^)(UITextView*textView,NSRange inRange ,NSString*replacementText))block;// return NO to not change text
///bind  block handler for textView object "shouldBeginEditing"
- (void)wc_bindTextViewdShouldBeginEditingHandlerBlock:(BOOL (^)(UITextView*textView))block;// return NO to disallow editing.

///bind block handler for textView object "shouldEndEditing"
- (void)wc_bindTextViewShouldEndEditingHandlerBlock:(BOOL (^)(UITextView*textView))block;// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)wc_bindTextViewShouldInteractWithUrlHandlerBlock:(BOOL (^)(UITextView*textView,NSURL *url,NSRange inRange,UITextItemInteraction interaction NS_AVAILABLE_IOS(10_0)))block;
- (void)wc_bindTextViewShouldInteractWithTextAttachmentHandlerBlock:(BOOL (^)(UITextView*textView,NSTextAttachment *textAttachment,NSRange inRange,UITextItemInteraction interaction NS_AVAILABLE_IOS(10_0)))block;
//>>>>>>>>>>>>>>>>textView hander block  end >>>>>>>>>>>>>

@end
