//
//  UITextField+WCBlock.m
//  WCBlockKit
//
//  Created by zhao weicheng on 2018/4/16.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import "UITextField+WCBlock.h"
#import "UIControl+WCBlock.h"
#import <objc/runtime.h>

static const int  wc_textField_blockTarget_set_key;
static const int  wc_textField_shouldChangeCharactersHandlerBlock_key;
static const int  wc_textField_shouldBeginEditingHandlerBlock_key;
static const int  wc_textField_shouldEndEditingHandlerBlock_key;
static const int  wc_textField_shouldReturnHandlerBlock_key;
static const int  wc_textField_shouldClearHandlerBlock_key;

@interface WCTextFieldBlockTarget : NSObject
@property (nonatomic,copy)void(^editingDidBeginBlock)(UITextField *textField);
@property (nonatomic,copy)void(^editingChangedBlock)(UITextField *textField,NSString *value);
@property (nonatomic,copy)void(^editingDidEndBlock)(UITextField *textField);
@property (nonatomic,copy)void(^editingDidEndOnExitBlock)(UITextField *textField);
@end
@implementation WCTextFieldBlockTarget
- (void)wc_textFieldTextEditingDidBegin:(UITextField*)textField {
    if (self.editingDidBeginBlock)self.editingDidBeginBlock(textField);
}
- (void)wc_textFieldEditingChanged:(UITextField*)textField {
   if (self.editingChangedBlock)self.editingChangedBlock(textField,textField.text);
}
- (void)wc_textFieldTextEditingDidEnd:(UITextField*)textField {
   if (self.editingDidEndBlock)self.editingDidEndBlock(textField);
}
- (void)wc_textEditingDidEndOnExit:(UITextField*)textField {
   if (self.editingDidEndOnExitBlock)self.editingDidEndOnExitBlock(textField);
}
@end
@interface UITextField()<UITextFieldDelegate>
@end
@implementation UITextField (WCBlock)
- (void)wc_bindTextFieldEditingDidBeginBlockNext:(void (^)(UITextField *textField))block {
    WCTextFieldBlockTarget *target = [WCTextFieldBlockTarget new];
    target.editingDidBeginBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    [self addTarget:target action:@selector(wc_textFieldTextEditingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
}
- (void)wc_bindTextFieldEditingChangedBlockNext:(void (^)(UITextField *textField,NSString *value))block {
    WCTextFieldBlockTarget *target = [WCTextFieldBlockTarget new];
    target.editingChangedBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    [self addTarget:target action:@selector(wc_textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (void)wc_bindTextFieldEditingDidEndBlockNext:(void (^)(UITextField *textField))block {
    WCTextFieldBlockTarget *target = [WCTextFieldBlockTarget new];
    target.editingDidEndBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    [self addTarget:target action:@selector(wc_textFieldTextEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
}
- (void)wc_bindTextFieldEditingDidEndOnExitBlockNext:(void (^)(UITextField *textField))block {
    WCTextFieldBlockTarget *target = [WCTextFieldBlockTarget new];
    target.editingDidEndOnExitBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    [self addTarget:target action:@selector(wc_textEditingDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
}
- (void)wc_bindTextFieldShouldChangeCharactersHandlerBlock:(BOOL (^)(UITextField*textField,NSRange inRange ,NSString*replacementString))block {
    objc_setAssociatedObject(self,&wc_textField_shouldChangeCharactersHandlerBlock_key,block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = self;
}
- (void)wc_bindTextFieldShouldClearHandlerBlock:(BOOL (^)(UITextField*textField))block {
    objc_setAssociatedObject(self,&wc_textField_shouldClearHandlerBlock_key,block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = self;
}
- (void)wc_bindTextFieldShouldEndEditingHandlerBlock:(BOOL (^)(UITextField*textField))block{
    objc_setAssociatedObject(self,&wc_textField_shouldEndEditingHandlerBlock_key,block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = self;
}
- (void)wc_bindTextFieldShouldReturnHandlerBlock:(BOOL (^)(UITextField*textField))block{
    objc_setAssociatedObject(self,&wc_textField_shouldReturnHandlerBlock_key,block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = self;
}
- (void)wc_bindTextFieldShouldBeginEditingHandlerBlock:(BOOL (^)(UITextField*textField))block {
     objc_setAssociatedObject(self,&wc_textField_shouldBeginEditingHandlerBlock_key,block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = self;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
   BOOL(^block)(UITextField*,NSRange,NSString*) = objc_getAssociatedObject(self, &wc_textField_shouldChangeCharactersHandlerBlock_key);
    if (block) return block(textField,range,string);
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    BOOL(^block)(UITextField*) = objc_getAssociatedObject(self, &wc_textField_shouldBeginEditingHandlerBlock_key);
    if (block) return block(textField);
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    BOOL(^block)(UITextField*) = objc_getAssociatedObject(self, &wc_textField_shouldEndEditingHandlerBlock_key);
    if (block) return block(textField);
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL(^block)(UITextField*) = objc_getAssociatedObject(self, &wc_textField_shouldReturnHandlerBlock_key);
    if (block) return block(textField);
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    BOOL(^block)(UITextField*) = objc_getAssociatedObject(self, &wc_textField_shouldClearHandlerBlock_key);
    if (block) return block(textField);
    return YES;
}
-(NSMutableSet<WCTextFieldBlockTarget*>*)wc_blockTargetSet{
    NSMutableSet *_targets = objc_getAssociatedObject(self, &wc_textField_blockTarget_set_key);
    if (!_targets) {
        _targets = [NSMutableSet new];
        objc_setAssociatedObject(self,&wc_textField_blockTarget_set_key,_targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _targets;
}
@end

