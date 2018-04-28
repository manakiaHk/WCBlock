# WCBlock
a lightweight block library of UIKit extension , it will  make your code more  simple , and you will love it for ever

# use as follow 
##   you need import "WCBlock.h"

#import "WCBlock.h"
```objective-c
   
     ///view
    UIView *view = [[UIView alloc]initWithFrame:viewframe];
    [view wc_bindViewClickedBlockNext:^(UIView *view) {
        NSLog(@"view clicked");
    }];
    
     ///gestureRecognizer
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]init];
    [tapGes wc_bindGestureBlockNext:^(UIGestureRecognizer *sender) {
        NSLog(@"gestureRecognizer sender--%@",sender);
    }];
    
     ////button
    UIButton *button = [[UIButton alloc]initWithFrame:btnFrame];
    [button wc_bindForControlEvents:UIControlEventTouchUpInside blockNext:^(id sender) {
        NSLog(@"%@",sender);
    }];
    
     ///alear
    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"title" message:@"message" delegate:nil cancelButtonTitle:@"cancle" otherButtonTitles:@"ok", nil];
    
    [alerView wc_bindAlertButtonClickedBlockNext:^(NSInteger index) {
        NSLog(@"clicked index: %ld",index);
    }];
    [alerView show];
    
    ///textfiled
    UITextField *textfiled = [[UITextField alloc]initWithFrame:textFieldframe];
    [textfiled wc_bindTextFieldEditingChangedBlockNext:^(UITextField *textField, NSString *value) {
        NSLog(@"textfiled text:%@",value);
    }];
    [textfiled wc_bindTextFieldShouldChangeCharactersHandlerBlock:^BOOL(UITextField *textField, NSRange shouldChangeCharactersInRange, NSString *replacementString) {
        return YES;
    }];
    [textfiled wc_bindTextFieldEditingDidBeginBlockNext:^(UITextField *textField) {
        NSLog(@"textfiled did begin editing");
    }];
    [textfiled wc_bindTextFieldEditingDidEndBlockNext:^(UITextField *textField) {
         NSLog(@"textfiled did end editing");
    }];
   
    ///segmentedControl
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"title0",@"title1",@"title2"]];
    [segment wc_bindSegmentControlValueChangedBlockNext:^(NSInteger selectedIndex) {
        NSLog(@"segment selected index %ld",selectedIndex);
    }];
   
    /// tip: 和以往一样，当wcblock 捕获了外部变量，可能将导致循环引用 ，你需要用 __weak 避免这样事情发生  
    ///slider  
    UISlider *slider = [[UISlider alloc]initWithFrame:sliderFrame];
    __weak typeof(self) weakSelf = self;
    [slider wc_bindSliderValueChangedBlockNext:^(CGFloat value) {
        __strong typeof(weakSelf) self = weakSelf;
       [weakSelf dosomething]
    }];
 
    ///NSNotificationCenter
    ///WCBlock 将自动为你管理移除消息中心的observer对象
    [[NSNotificationCenter defaultCenter] wc_addObserverForName:@"wc_noti_demo" object:nil contextObj:self blockNext:^(NSNotification * _Nullable note) {
        NSLog(@"%@",note.userInfo[@"note_demo"]);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"wc_noti_demo" object:nil userInfo:@{@"note_demo":@"WCBlock将自动为你管理移除observer对象"}];
        
    });
    
    //KVO 
    [self.label wc_addObserverForKeyPath:@"text" valueBlockNext:^(NSString *keypath, id ofObj, id oldValue, id newValue) {
        NSLog(@"label.text = %@",newValue);
    }];
    [self.label wc_addObserverForKeyPaths:@[@"alpha",@"text"] valueBlockNext:^(NSString *keypath, id ofObj, id oldValue, id newValue) {
        if ([keypath isEqualToString:@"alpha"]) {
            NSLog(@"label.alpha= %@",newValue);
        }else if([keypath isEqualToString:@"text"]){
            NSLog(@"label.text= %@",newValue);
        }else;
    }];
     [self.label wc_addObserverForKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld changeBlockNext:^(NSString *keypath, id ofObj, NSDictionary<NSKeyValueChangeKey,id> *change) {
        ///..
    }];
    
    //And so on...
    
     ///你可以为每个对象绑定多个block ，每个block都会调用  但是记住 handerBlock 除外（只能绑定一个，因为你并不希望多个hander同时操作一个对象,所以 WCBlock 是不允许的）比如：
   
    ///下面view的每个block 都将调用
    [view wc_bindViewClickedBlockNext:^(UIView *view) {
        NSLog(@"view clicked block0");
    }];
    [view wc_bindViewClickedBlockNext:^(UIView *view) {
        NSLog(@"view clicked block1");
    }];
    [view wc_bindViewClickedBlockNext:^(UIView *view) {
        NSLog(@"view clicked block2");
    }];
    
    ///下面textfiled的handerBlock 只有最后一个有效
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
    
}
- (void)dealloc {
    [self.label wc_removeObserverForKeyPath:@"text"];
    [self.label wc_removeObserverForKeyPath:@"alpha"];
//    [self.label wc_removeObserverForKeyPaths:@[@"alpha",@"text"]];
}

```
