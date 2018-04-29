//
//  UITextView+WCBlock.h
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/17.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (WCBlock)

- (void)wc_bindTextViewEditingChangedBlockNext:(void (^)(UITextView *textView,NSString *value))block;
- (void)wc_bindTextViewEditingDidBeginBlockNext:(void (^)(UITextView *textField))block;
- (void)wc_bindTextViewEditingDidEndBlockNext:(void (^)(UITextView *textField))block;

// EN:for using handler as bellow you need to be knowed that if you use its delegate to listen UITextView object and also use the following block handler at the same time,it will be effective by only one way , this depends on your  opportunity to set up delegate  and block handler for UITextField object (later effective), it's important about this.
// zh-CN: 对于以下handler回调你需要知道， 如果你使用了自己的代理实现的方式又使用了以下handlerBlock回调的方式，将只有一种方案有效，取决于你为textView设置代理delegate的时机,最终都是后来者有效。这点你需要知晓并希望你选者其一。

- (void)wc_bindTextViewShouldChangeTextWithHandlerBlock:(BOOL (^)(UITextView*textView,NSRange inRange ,NSString*replacementText))block;// return NO to not change text
///bind  block handler for textView object "shouldBeginEditing"

- (void)wc_bindTextViewdShouldBeginEditingHandlerBlock:(BOOL (^)(UITextView*textView))block;// return NO to disallow editing.

- (void)wc_bindTextViewShouldEndEditingHandlerBlock:(BOOL (^)(UITextView*textView))block;// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)wc_bindTextViewShouldInteractWithUrlHandlerBlock:(BOOL (^)(UITextView*textView,NSURL *url,NSRange inRange,UITextItemInteraction interaction NS_AVAILABLE_IOS(10_0)))block;

- (void)wc_bindTextViewShouldInteractWithTextAttachmentHandlerBlock:(BOOL (^)(UITextView*textView,NSTextAttachment *textAttachment,NSRange inRange,UITextItemInteraction interaction NS_AVAILABLE_IOS(10_0)))block;

@end
