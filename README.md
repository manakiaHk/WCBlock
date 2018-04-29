## WCBlock

 * A lightweight block library of UIKit extension , t will  make your code simple .
  
## How To Get Started

## Manual import

  * Drag the folder "WCBlock"  to your project
  * Import the main file：`#import "WCBlock.h"`
  
## Installation with CocoaPods

```ruby
source 'https://github.com/manakiaHk/WCBlock.git'
platform :ios, '7.0'

target 'TargetName' do
pod 'WCBlock'
end
```

Then, run the following command:

```bash
$ pod install
```
## Usage

   
view

```objective-c
    
    [view wc_bindViewTapBlockNext:^(UIView *view, WCViewTap *tap) {
        //..
    }];
    ///你可以通过返回值设置属性以及代理 
    WCViewTap *tap = [view wc_bindViewTapBlockNext:^(UIView *view, WCViewTap *tap) {
       //..
    }];
    tap.numberOfTapsRequired = 2;
    tap.delegate = self;
    
    ///你还可以绑定其他的手势block回调。e.g:
    [view wc_bindViewPanBlockNext:^(UIView *view, WCViewPan *pan) {
        //NSLog(@"pan...");
    }];
    [view wc_bindViewLongPressBlockNext:^(UIView *view, WCViewLongPress *longPress) {
        //NSLog(@"longPressed");
    }];
    [view wc_bindViewRotationBlockNext:^(UIView *view, WCViewRotation *rotation) {
        //NSLog(@"%0.2f",rotation.rotation);//旋转角度
        //NSLog(@"%0.2f",rotation.velocity);//旋转速度
    }];
   
```
    
gestureRecognizer

```objective-c
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
    [tapGes wc_bindGestureBlockNext:^(UIGestureRecognizer *sender) {
        //...
    }];
    
    UISwipeGestureRecognizer *swipeGesture =  [[UISwipeGestureRecognizer alloc]init];
    [swipeGesture wc_bindGestureBlockNext:^(UIGestureRecognizer *sender) {
        //...
    }];
    
    UIRotationGestureRecognizer *rotationGesture =  [[UIRotationGestureRecognizer alloc]init];
    [rotationGesture wc_bindGestureBlockNext:^(UIGestureRecognizer *sender) {
        //...
    }];
    
    UIPanGestureRecognizer *panGesture =  [[UIPanGestureRecognizer alloc]init];
    [panGesture wc_bindGestureBlockNext:^(UIGestureRecognizer *sender) {
        //...
    }];
   // and so on ...
```
    
button、segmentedControl、 slider  and so on.  e.g:

```objective-c
    UIButton *button = [[UIButton alloc]initWithFrame:btnFrame];
    [button wc_bindForControlEvents:UIControlEventTouchUpInside blockNext:^(id sender) {
        //button clicked...
    }];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"title0",@"title1",@"title2"]];
    [segment wc_bindSegmentControlValueChangedBlockNext:^(NSInteger selectedIndex) {
        //NSLog(@"segment selected index %ld",selectedIndex);
    }];
    
    //tip: 和以往一样，当wcblock 捕获了外部变量，可能将导致循环引用 ，你需要用 __weak 避免这样事情发生  
    
    UISlider *slider = [[UISlider alloc]initWithFrame:sliderFrame];
    __weak typeof(self) weakSelf = self;
    [slider wc_bindSliderValueChangedBlockNext:^(CGFloat value) {
        __strong typeof(weakSelf) self = weakSelf;
       [self sendAMesseage];
    }];
    
    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"title" message:@"message" delegate:nil      cancelButtonTitle:@"cancle" otherButtonTitles:@"ok", nil];
    [alerView wc_bindAlertButtonClickedBlockNext:^(NSInteger index) {
       //NSLog(@"clicked index: %ld",index);
    }];
    [alerView show];
```
textfiled

```objective-c
    UITextField *textfiled = [[UITextField alloc]initWithFrame:textFieldframe];
    [textfiled wc_bindTextFieldEditingChangedBlockNext:^(UITextField *textField, NSString *value) {
        //NSLog(@"textfiled text:%@",value);
    }];
    [textfiled wc_bindTextFieldShouldChangeCharactersHandlerBlock:^BOOL(UITextField *textField, NSRange shouldChangeCharactersInRange, NSString *replacementString) {
        return YES;
    }];
    [textfiled wc_bindTextFieldEditingDidBeginBlockNext:^(UITextField *textField) {
       //textfiled did begin editing...
     }];
    [textfiled wc_bindTextFieldEditingDidEndBlockNext:^(UITextField *textField) {
        //textfiled did end editing... 
    }];
    
``` 

  notificationCenter ,WCBlock 将自动为你管理移除消息中心的observer对象 
  
  ```objective-c
  
    [WCNotificationCenter wc_addObserverForName:@"wc_noti_demo" object:nil contextObj:self blockNext:^(NSNotification * _Nullable note) {
       //NSLog(@"%@",note.userInfo[@"note_demo"]);
    }];
    
     ///异步通知用
    [WCNotificationCenter wc_addObserverForName:kNoteName object:nil contextObj:self queue:[NSOperationQueue mainQueue] blockNext:^(NSNotification * _Nullable note) {
        //..
    }];
    
    ///notification test demo
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WCNotificationCenter postNotificationName:@"wc_noti_demo" object:nil userInfo:@{@"note_demo":@"WCBlock将自动为你管理移除observer对象"}];
        //..
    });
    
```
 KVO 
 
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
  和Apple api 一样 对于KVO 你需要自己移除键值观察，  像这样
  
  ```objective-c
  
   - (void)dealloc {
    [_anObject wc_removeObserverForKeyPath:@"keypath0"];
    [_anObject wc_removeObserverForKeyPath:@"keypath1"];
    //also 
    [_anObject wc_removeObserverForKeyPaths:@[@"keypath2",@"keypath3"]];
}

 ```    
 tip:你可以为每个对象绑定多个同样类型的block ，每个block都会调用 ,因为不排除你会在多个地方同时使用，所以你要知道WCBlock是可以做到这点的。 但是记住 handerBlock 除外，它只能绑定一个，因为你并不希望多个hander同时操作一个对象,所以同一个对象 绑定多个同样类型的handerBlock ,这时候只有最后一个有效。e.g：
   
像下面的每个block都将调用

```objective-c

    [view wc_bindViewTapBlockNext:^(UIView *view, WCViewTap *tap) {
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
像下面的 handlerBlock 只有最后一个有效（请注意，它们是 handlerBlock)

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
 

