//
//  UISearchBar+WCBlock.m
//  WCBlock
//
//  Created by zhao weicheng on 2018/4/29.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import "UISearchBar+WCBlock.h"
#import <objc/runtime.h>

static const int  wc_searchBar_blockTarget_set_key;
static const int  wc_searchBar_shouldChangeCharactersHandlerBlock_key;
static const int  wc_searchBar_shouldBeginEditingHandlerBlock_key;
static const int  wc_searchBar_shouldEndEditingHandlerBlock_key;

@interface WCSearchBarBlockTarget : NSObject
@property (nonatomic,copy)void(^editingDidBeginBlock)(UISearchBar *searchBar);
@property (nonatomic,copy)void(^editingChangedBlock)(UISearchBar *searchBar,NSString *searchText);
@property (nonatomic,copy)void(^editingDidEndBlock)(UISearchBar *searchBar);
@property (nonatomic,copy)void(^searchButtonClickedBlock)(UISearchBar *searchBar);
@property (nonatomic,copy)void(^bookmarkButtonClickedBlock)(UISearchBar *searchBar);
@property (nonatomic,copy)void(^cancelButtonClickedBlock)(UISearchBar *searchBar);
@property (nonatomic,copy)void(^resultsListButtonClickedBlock)(UISearchBar *searchBar);
@property (nonatomic,copy)void(^selectedScopeButtonIndexDidChangeBlock)(UISearchBar *searchBar,NSInteger selectedScope);
@end
@implementation WCSearchBarBlockTarget

@end

@interface UISearchBar()<UISearchBarDelegate>
@end
@implementation UISearchBar (WCBlock)
- (void)wc_bindSearchBarTextDidBeginEditingBlockNext:(void (^)(UISearchBar *searchBar))block {
    WCSearchBarBlockTarget *target = [WCSearchBarBlockTarget new];
    target.editingDidBeginBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    self.delegate = self;
}
- (void)wc_bindSearchBarTextDidEndEditingBlockNext:(void (^)(UISearchBar *searchBar))block {
    WCSearchBarBlockTarget *target = [WCSearchBarBlockTarget new];
    target.editingDidEndBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    self.delegate = self;
}
- (void)wc_bindSearchBarTextDidChangeBlockNext:(void (^)(UISearchBar *searchBar,NSString *searchText))block {
    
    WCSearchBarBlockTarget *target = [WCSearchBarBlockTarget new];
    target.editingChangedBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    self.delegate = self;
}
- (void)wc_bindSearchBarSearchButtonClickedBlockNext:(void (^)(UISearchBar *searchBar))block {
    WCSearchBarBlockTarget *target = [WCSearchBarBlockTarget new];
    target.searchButtonClickedBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    self.delegate = self;
}
- (void)wc_bindSearchBarBookmarkButtonClickedBlockNext:(void (^)(UISearchBar *searchBar))block {
    WCSearchBarBlockTarget *target = [WCSearchBarBlockTarget new];
    target.bookmarkButtonClickedBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    self.delegate = self;
}
- (void)wc_bindSearchBarCancelButtonClickedBlockNext:(void (^)(UISearchBar *searchBar))block {
    WCSearchBarBlockTarget *target = [WCSearchBarBlockTarget new];
    target.cancelButtonClickedBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    self.delegate = self;
}
- (void)wc_bindSearchBarResultsListButtonClickedBlockNext:(void (^)(UISearchBar *searchBar))block {
    WCSearchBarBlockTarget *target = [WCSearchBarBlockTarget new];
    target.resultsListButtonClickedBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    self.delegate = self;
}
- (void)wc_bindSearchBarSelectedScopeButtonIndexDidChangeBlockNext:(void (^)(UISearchBar *searchBar,NSInteger selectedScope))block {
    WCSearchBarBlockTarget *target = [WCSearchBarBlockTarget new];
    target.selectedScopeButtonIndexDidChangeBlock = block;
    [[self wc_blockTargetSet] addObject:target];
    self.delegate = self;
}
- (void)wc_bindSearchBarShouldBeginEditingHandlerBlock:(BOOL (^)(UISearchBar*searchBar))block {
    objc_setAssociatedObject(self,&wc_searchBar_shouldBeginEditingHandlerBlock_key,block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = self;
}
- (void)wc_bindSearchBarShouldChangeCharactersHandlerBlock:(BOOL (^)(UISearchBar*searchBar,NSRange inRange ,NSString*replacementString))block {
    objc_setAssociatedObject(self,&wc_searchBar_shouldChangeCharactersHandlerBlock_key,block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = self;
}
- (void)wc_bindSearchBarShouldEndEditingHandlerBlock:(BOOL (^)(UISearchBar*searchBar))block {
    objc_setAssociatedObject(self,&wc_searchBar_shouldEndEditingHandlerBlock_key,block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = self;
}

/// delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [[self wc_blockTargetSet] enumerateObjectsUsingBlock:^(WCSearchBarBlockTarget * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.editingDidBeginBlock)obj.editingDidBeginBlock(searchBar);
    }];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [[self wc_blockTargetSet] enumerateObjectsUsingBlock:^(WCSearchBarBlockTarget * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.editingDidEndBlock)obj.editingDidEndBlock(searchBar);
    }];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [[self wc_blockTargetSet] enumerateObjectsUsingBlock:^(WCSearchBarBlockTarget * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.editingChangedBlock)obj.editingChangedBlock(searchBar, searchText);
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [[self wc_blockTargetSet] enumerateObjectsUsingBlock:^(WCSearchBarBlockTarget * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.searchButtonClickedBlock)obj.searchButtonClickedBlock(searchBar);
    }];
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED {
    [[self wc_blockTargetSet] enumerateObjectsUsingBlock:^(WCSearchBarBlockTarget * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.bookmarkButtonClickedBlock)obj.bookmarkButtonClickedBlock(searchBar);
    }];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED {
    [[self wc_blockTargetSet] enumerateObjectsUsingBlock:^(WCSearchBarBlockTarget * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.cancelButtonClickedBlock)obj.cancelButtonClickedBlock(searchBar);
    }];
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED {
    [[self wc_blockTargetSet] enumerateObjectsUsingBlock:^(WCSearchBarBlockTarget * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.resultsListButtonClickedBlock)obj.resultsListButtonClickedBlock(searchBar);
    }];
}
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0) {
    [[self wc_blockTargetSet] enumerateObjectsUsingBlock:^(WCSearchBarBlockTarget * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.selectedScopeButtonIndexDidChangeBlock)obj.selectedScopeButtonIndexDidChangeBlock(searchBar, selectedScope);
    }];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    BOOL(^block)(UISearchBar*) = objc_getAssociatedObject(self, &wc_searchBar_shouldEndEditingHandlerBlock_key);
    if (block) return block(searchBar);
    return YES;
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    BOOL(^block)(UISearchBar*) = objc_getAssociatedObject(self, &wc_searchBar_shouldBeginEditingHandlerBlock_key);
    if (block) return block(searchBar);
    return YES;
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0){
    BOOL(^block)(UISearchBar*,NSRange,NSString*) = objc_getAssociatedObject(self, &wc_searchBar_shouldChangeCharactersHandlerBlock_key);
    if (block) return block(searchBar,range,text);
    return YES;
}

-(NSMutableSet<WCSearchBarBlockTarget*>*)wc_blockTargetSet{
    NSMutableSet *_targets = objc_getAssociatedObject(self, &wc_searchBar_blockTarget_set_key);
    if (!_targets) {
        _targets = [NSMutableSet new];
        objc_setAssociatedObject(self,&wc_searchBar_blockTarget_set_key,_targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _targets;
}

@end
