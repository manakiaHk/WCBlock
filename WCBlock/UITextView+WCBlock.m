//
//  UITextView+WCBlock.m
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/17.
//  Copyright © 2018年 hello. All rights reserved.
//

#import "UITextView+WCBlock.h"
#import <objc/runtime.h>

static const int  wc_textView_shouldEndEditingHandlerBlock_key;
static const int  wc_textView_shouldChangeTextHandlerBlock_key;
static const int  wc_textView_shouldBeginEditingHandlerBlock_key;
static const int  wc_textView_shouldInteractWithUrlHandlerBlock_key;
static const int  wc_textView_shouldInteractWithTextAttachmentHandlerBlock_key;
static const int  wc_textView_blockTarget_set_key;

@interface WCTextViewBlockTarget : NSObject
@property (nonatomic,weak)UITextView *textView;
@property (nonatomic,copy)void(^editingDidBeginBlock)(UITextView *textView);
@property (nonatomic,copy)void(^editingChangedBlock)(UITextView *textView,NSString *value);
@property (nonatomic,copy)void(^editingDidEndBlock)(UITextView *textView);
@end
@implementation WCTextViewBlockTarget
-(void)setTextView:(UITextView *)textView {
    _textView = textView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidBeginEditing) name:UITextViewTextDidBeginEditingNotification object:textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange) name:UITextViewTextDidChangeNotification object:textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidEndEditing) name:UITextViewTextDidEndEditingNotification object:textView];
}
- (void)textViewTextDidBeginEditing {
    if (self.editingDidBeginBlock)self.editingDidBeginBlock(self.textView);
}
- (void)textViewTextDidChange {
    if (self.editingChangedBlock) self.editingChangedBlock(self.textView,self.textView.text);
}
- (void)textViewTextDidEndEditing {
    if (self.editingDidEndBlock)self.editingDidEndBlock(self.textView);
}
- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:self.textView];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:self.textView];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self.textView];
}
- (void)dealloc {
    [self removeObserver];
}
@end
@interface UITextView()<UITextViewDelegate>
@end
@implementation UITextView (WCBlock)
-(NSMutableSet<WCTextViewBlockTarget*>*)wc_blockTargetSet{
    NSMutableSet *_targets = objc_getAssociatedObject(self, &wc_textView_blockTarget_set_key);
    if (!_targets) {
        _targets = [NSMutableSet new];
        objc_setAssociatedObject(self,&wc_textView_blockTarget_set_key,_targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _targets;
}
- (void)wc_bindTextViewEditingChangedBlockNext:(void (^)(UITextView *textView,NSString *value))block {
    WCTextViewBlockTarget *taget = [WCTextViewBlockTarget new];
    taget.editingChangedBlock = block;
    taget.textView = self;
    [[self wc_blockTargetSet] addObject:taget];
}
- (void)wc_bindTextViewEditingDidBeginBlockNext:(void (^)(UITextView *textField))block {
    WCTextViewBlockTarget *taget = [WCTextViewBlockTarget new];
    taget.editingDidBeginBlock = block;
    taget.textView = self;
    [[self wc_blockTargetSet] addObject:taget];
}
- (void)wc_bindTextViewEditingDidEndBlockNext:(void (^)(UITextView *textField))block {
    WCTextViewBlockTarget *taget = [WCTextViewBlockTarget new];
    taget.editingDidEndBlock = block;
    taget.textView = self;
    [[self wc_blockTargetSet] addObject:taget];
}
- (void)wc_bindTextViewShouldChangeTextWithHandlerBlock:(BOOL (^)(UITextView*textView,NSRange inRange ,NSString*replacementText))block {
    objc_setAssociatedObject(self,&wc_textView_shouldChangeTextHandlerBlock_key,block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = self;
}
- (void)wc_bindTextViewdShouldBeginEditingHandlerBlock:(BOOL (^)(UITextView*textView))block {
    objc_setAssociatedObject(self,&wc_textView_shouldBeginEditingHandlerBlock_key,block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = self;
}
- (void)wc_bindTextViewShouldEndEditingHandlerBlock:(BOOL (^)(UITextView*textView))block; {
    objc_setAssociatedObject(self,&wc_textView_shouldEndEditingHandlerBlock_key,block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = self;
}
- (void)wc_bindTextViewShouldInteractWithUrlHandlerBlock:(BOOL (^)(UITextView*textView,NSURL *url,NSRange inRange,UITextItemInteraction interaction NS_AVAILABLE_IOS(10_0)))block{
    objc_setAssociatedObject(self,&wc_textView_shouldInteractWithUrlHandlerBlock_key,block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = self;
}
- (void)wc_bindTextViewShouldInteractWithTextAttachmentHandlerBlock:(BOOL (^)(UITextView*textView,NSTextAttachment *textAttachment,NSRange inRange,UITextItemInteraction interaction NS_AVAILABLE_IOS(10_0)))block{
    objc_setAssociatedObject(self,&wc_textView_shouldInteractWithTextAttachmentHandlerBlock_key,block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = self;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    BOOL(^block)(UITextView*) = objc_getAssociatedObject(self, &wc_textView_shouldBeginEditingHandlerBlock_key);
    if (block) return block(textView);
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    BOOL(^block)(UITextView*) = objc_getAssociatedObject(self, &wc_textView_shouldEndEditingHandlerBlock_key);
    if (block) return block(textView);
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    BOOL(^block)(UITextView*,NSRange,NSString*) = objc_getAssociatedObject(self, &wc_textView_shouldChangeTextHandlerBlock_key);
    if (block) return block(textView,range,text);
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0){
    BOOL(^block)(UITextView*,NSURL*,NSRange,UITextItemInteraction) = objc_getAssociatedObject(self, &wc_textView_shouldInteractWithUrlHandlerBlock_key);
    if(block) return block(textView,URL,characterRange,interaction);
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0){
        BOOL(^block)(UITextView*,NSTextAttachment*,NSRange,UITextItemInteraction) = objc_getAssociatedObject(self, &wc_textView_shouldInteractWithTextAttachmentHandlerBlock_key);
        if(block)return block(textView,textAttachment,characterRange,interaction);
        return YES;
}

@end
