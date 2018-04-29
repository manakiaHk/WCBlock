//
//  UISearchBar+WCBlock.h
//  WCBlock
//
//  Created by zhao weicheng on 2018/4/29.
//  Copyright © 2018年 weichengz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (WCBlock)
/// zh-CN: 对于以下所有回调的使用， 如果你使用了自己代理实现的方式又使用了以下handlerBlock回调的方式，将只有一种方案有效，取决于你为searchBar设置代理delegate的时机,最终都是后来者有效。这点你需要知晓并希望你选者其一。
- (void)wc_bindSearchBarTextDidBeginEditingBlockNext:(void (^)(UISearchBar *searchBar))block;
- (void)wc_bindSearchBarTextDidEndEditingBlockNext:(void (^)(UISearchBar *searchBar))block;
- (void)wc_bindSearchBarTextDidChangeBlockNext:(void (^)(UISearchBar *searchBar,NSString *searchText))block;
- (void)wc_bindSearchBarSearchButtonClickedBlockNext:(void (^)(UISearchBar *searchBar))block;
- (void)wc_bindSearchBarBookmarkButtonClickedBlockNext:(void (^)(UISearchBar *searchBar))block;
- (void)wc_bindSearchBarCancelButtonClickedBlockNext:(void (^)(UISearchBar *searchBar))block;
- (void)wc_bindSearchBarResultsListButtonClickedBlockNext:(void (^)(UISearchBar *searchBar))block;
- (void)wc_bindSearchBarSelectedScopeButtonIndexDidChangeBlockNext:(void (^)(UISearchBar *searchBar,NSInteger selectedScope))block;

- (void)wc_bindSearchBarShouldBeginEditingHandlerBlock:(BOOL (^)(UISearchBar*searchBar))block;
- (void)wc_bindSearchBarShouldChangeCharactersHandlerBlock:(BOOL (^)(UISearchBar*searchBar,NSRange inRange ,NSString*replacementString))block;
- (void)wc_bindSearchBarShouldEndEditingHandlerBlock:(BOOL (^)(UISearchBar*searchBar))block;
@end
