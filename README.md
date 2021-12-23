## WCBlock

 * A lightweight event listener library of UIKit  , It is non-invasive and make your code simple and easy . It provides friendly event listener callback support for event response  to NotificationCenter、KVO、Target-action、GestureRecognizer、UIView、UIButton、UITextField and so on . As a result, it  improve the cohesion degree of  code, make coding easier and improve development efficiency for you.
## How To Get Started

## Manual import

  * Drag the folder "WCBlock"  to your project
  * Import the main file：`#import "WCBlock.h"`
  
## Installation with CocoaPods

```ruby
source 'https://github.com/manakiaHk/WCBlock.git'
platform :ios, '7.0'

target 'TargetName' do
pod 'WCBlock-ObjC'
end
```

Then, run the following command:

```bash
$ pod install
```
Import the main file：

```objective-c
#import "WCBlock.h"

```

## Usage

   
Bind block callback for view 

```objective-c
    
    [view wc_bindViewTapBlockNext:^(UIView *view, WCViewTap *tap) {
        // your code...
    }];
     
    [imageView wc_bindViewTapBlockNext:^(UIView *view, WCViewTap *tap) {
        // your code...
    }];
    imageView.userInteractionEnabled = YES;//for imageView, the proprty userInteractionEnabled defualt value is NO,this is same as Apple API.
    
    ///You can set it's properties and delegate through the return value.
    WCViewTap *tap = [view wc_bindViewTapBlockNext:^(UIView *view, WCViewTap *tap) {
       // your code...
    }];
    tap.numberOfTapsRequired = 2;
    tap.delegate = self;
    
    ///You can also bind other gestures block callback,e.g:
    [view wc_bindViewPanBlockNext:^(UIView *view, WCViewPan *pan) {
        // your code...
    }];
    [view wc_bindViewLongPressBlockNext:^(UIView *view, WCViewLongPress *longPress) {
        // your code...
    }];
    [view wc_bindViewRotationBlockNext:^(UIView *view, WCViewRotation *rotation) {
        // your code...
        //NSLog(@"%0.2f",rotation.rotation);//旋转角度
        //NSLog(@"%0.2f",rotation.velocity);//旋转速度
    }];
   
```
    
Bind block callback for gestureRecognizer

```objective-c
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
    [tapGes wc_bindGestureBlockNext:^(UIGestureRecognizer *sender) {
        // your code...
    }];
    UISwipeGestureRecognizer *swipeGesture =  [[UISwipeGestureRecognizer alloc]init];
    [swipeGesture wc_bindGestureBlockNext:^(UIGestureRecognizer *sender) {
        // your code...
    }];
    UIRotationGestureRecognizer *rotationGesture =  [[UIRotationGestureRecognizer alloc]init];
    [rotationGesture wc_bindGestureBlockNext:^(UIGestureRecognizer *sender) {
        // your code...
    }];
    UIPanGestureRecognizer *panGesture =  [[UIPanGestureRecognizer alloc]init];
    [panGesture wc_bindGestureBlockNext:^(UIGestureRecognizer *sender) {
        // your code...
    }];
   /// And so on ...
```
    
You can bind block callback for button、segmentedControl、 slider  and so on.  e.g:

```objective-c
    UIButton *button = [[UIButton alloc]initWithFrame:btnFrame];
    [button wc_bindForControlEvents:UIControlEventTouchUpInside blockNext:^(id sender) {
        // your code...
    }];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"title0",@"title1",@"title2"]];
    [segment wc_bindSegmentControlValueChangedBlockNext:^(NSInteger selectedIndex) {
        // your code...
    }];
    
    //Tip: As in the past, wcblock will capture external variables, which may lead to circular references. You need to use __weak to avoid such a situation.  
    
    UISlider *slider = [[UISlider alloc]initWithFrame:sliderFrame];
    __weak typeof(self) weakSelf = self;
    [slider wc_bindSliderValueChangedBlockNext:^(CGFloat value) {
        __strong typeof(weakSelf) self = weakSelf;
       [self sendAMesseage];
    }];
    
    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"title" message:@"message" delegate:nil      cancelButtonTitle:@"cancle" otherButtonTitles:@"ok", nil];
    [alerView wc_bindAlertButtonClickedBlockNext:^(NSInteger index) {
       // your code...
    }];
    [alerView show];
```
You can bind block callback for textfiled 、searchBar、textView

```objective-c
    UITextField *textfiled = [[UITextField alloc]initWithFrame:textFieldframe];
    [textfiled wc_bindTextFieldEditingChangedBlockNext:^(UITextField *textField, NSString *value) {
         // your code... 
        //NSLog(@"textfiled text:%@",value);
    }];
    [textfiled wc_bindTextFieldShouldChangeCharactersHandlerBlock:^BOOL(UITextField *textField, NSRange shouldChangeCharactersInRange, NSString *replacementString) {
       // your code...
        return YES;
    }];
    [textfiled wc_bindTextFieldEditingDidBeginBlockNext:^(UITextField *textField) {
       // your code...
       //textfiled did begin editing...
     }];
    [textfiled wc_bindTextFieldEditingDidEndBlockNext:^(UITextField *textField) {
        // your code...
        //textfiled did end editing... 
    }];
    
     UISearchBar *searchBar = [[UISearchBar alloc]init];
    [searchBar wc_bindSearchBarTextDidBeginEditingBlockNext:^(UISearchBar *searchBar) {
        // your code...
    }];
    [searchBar wc_bindSearchBarTextDidChangeBlockNext:^(UISearchBar *searchBar, NSString *searchText) {
        // your code...
    }];
    [searchBar wc_bindSearchBarTextDidEndEditingBlockNext:^(UISearchBar *searchBar) {
        // your code...
    }];
    [searchBar wc_bindSearchBarCancelButtonClickedBlockNext:^(UISearchBar *searchBar) {
        // your code...
    }];
    [searchBar wc_bindSearchBarShouldChangeCharactersHandlerBlock:^BOOL(UISearchBar *searchBar, NSRange inRange, NSString *replacementString) {
        //your code...
        return YES;
    }];
    /// and so on ...
    
    UITextView *textView = [[UITextView alloc]init];
    [textView wc_bindTextViewEditingChangedBlockNext:^(UITextView *textView, NSString *value) {
        //your code...
    }];
    [textView wc_bindTextViewShouldChangeTextWithHandlerBlock:^BOOL(UITextView *textView, NSRange inRange, NSString *replacementText) {
        //your code...
        return YES;
    }];
    if (@available(iOS 10.0, *)) {
        [textView wc_bindTextViewShouldInteractWithUrlHandlerBlock:^BOOL(UITextView *textView, NSURL *url, NSRange inRange, UITextItemInteraction interaction) {
            //your code...
            return YES;
        }];
    };
    /// And so on ...
    
``` 

Bind block callback for notificationCenter ,and observer objects will be automatically managed for you to 
  be removed
  
 ```objective-c
  
    [WCNotificationCenter wc_addObserverForName:@"wc_note_demo" object:nil contextObj:self blockNext:^(NSNotification * _Nullable note) {
       // your code...
       //NSLog(@"%@",note.userInfo[@"note_demo"]);
    }];
    
     ///Bind block callback for asynchronous notificationCenter
    [WCNotificationCenter wc_addObserverForName:@"wc_note_demo" object:nil contextObj:self queue:[NSOperationQueue mainQueue] blockNext:^(NSNotification * _Nullable note) {
        // your code...
    }];
    
    ///notification test demo
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WCNotificationCenter postNotificationName:@"wc_note_demo" object:nil userInfo:@{@"note_demo":@"observer objects will be automatically managed for you to be removed"}];
        // your code...
    });
    
```
 Bind block callback for KVO.
 
 ```objective-c 
    [_anObject wc_addObserverForKeyPath:@"keypath0" valueBlockNext:^(NSString *keypath, id ofObj, id oldValue, id newValue) {
        //your code...
    }];
    [_anObject wc_addObserverForKeyPaths:@[@"keypath1",@"keypath2"] valueBlockNext:^(NSString *keypath, id ofObj, id oldValue, id newValue) {
        if ([keypath isEqualToString:@"keypath1"]) {
            //your code...
        }else if([keypath isEqualToString:@"keypath2"]){
            //your code...
        }else;
    }];
    [_anObject wc_addObserverForKeyPath:@"keypath3" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld changeBlockNext:^(NSString *keypath, id ofObj, NSDictionary<NSKeyValueChangeKey,id> *change) {
        //your code...
    }];
   ```
  Same as to Apple API, you need to remove key value observers for your objects , like this.
  
  ```objective-c
  
   - (void)dealloc {
     [_anObject wc_removeObserverForKeyPath:@"keypath0"];
     [_anObject wc_removeObserverForKeyPath:@"keypath1"];
     //also 
     [_anObject wc_removeObserverForKeyPaths:@[@"keypath2",@"keypath3"]];
}

 ```    
 Tip: you can bind more than one same type of blocks for an object of yours, and each blocks will be called, because you may use them  in different places at the same time. so, you know that WCBlock can do this ,but except the block of handler. For handler block, it can be bound only one same type handler block, because you dont hope to operate  an object in many places simultaneously. so when an object is bound  more than one same type handler block , it only the last one is valid. E.g:

 Blocks as the follow will be called every one.

```objective-c

    [view wc_bindViewTapBlockNext:^(UIView *view, WCViewTap *tap) {
       // your code...
       // NSLog(@"0--view taped");
    }];
    [view wc_bindViewTapBlockNext:^(UIView *view, WCViewTap *tap) {
       //  NSLog(@"1--view taped");
    }];
    [view wc_bindViewTapBlockNext:^(UIView *view, WCViewTap *tap) {
       // NSLog(@"2--view taped");
    }];
    [textfiled wc_bindTextFieldEditingChangedBlockNext:^(UITextField *textField, NSString *value) {
        //  NSLog(@"0--textfiled text:%@",value);
    }];
    [textfiled wc_bindTextFieldEditingChangedBlockNext:^(UITextField *textField, NSString *value) {
        // NSLog(@"1--textfiled text:%@",value);
    }];
    [textfiled wc_bindTextFieldEditingChangedBlockNext:^(UITextField *textField, NSString *value) {
        // NSLog(@"2--textfiled text:%@",value);
    }];
    
```
These handler blocks  as follow ,only last one will be effective（becuse they are handler block , you need be knowed for this)

```objective-c

    [textfiled wc_bindTextFieldShouldChangeCharactersHandlerBlock:^BOOL(UITextField *textField, NSRange shouldChangeCharactersInRange, NSString *replacementString) {
        if ([replacementString containsString:@"a"]) {
            return NO;
        }
        return YES;
    }];
    [textfiled wc_bindTextFieldShouldChangeCharactersHandlerBlock:^BOOL(UITextField *textField, NSRange shouldChangeCharactersInRange, NSString *replacementString) {
        if ([replacementString containsString:@"b"]) {
            return NO;
        }
        return YES;
    }];
    [textfiled wc_bindTextFieldShouldChangeCharactersHandlerBlock:^BOOL(UITextField *textField, NSRange shouldChangeCharactersInRange, NSString *replacementString) {
        if ([replacementString containsString:@"c"]) {
            return NO;
        }
        return YES;
    }];
    
```
   
 ### thanks for your reading,and welcome your advice.
 ### Regards.
 
 ## end 
 

