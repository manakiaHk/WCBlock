//
//  ViewController.m
//  WCBlock
//
//  Created by zhao weicheng on 2018/4/24.
//  Copyright © 2018年 weichengz. All rights reserved.
//github  https://github.com/manakiaHk/WCBlock

#import "ViewController.h"
#import "WCBlock.h"
@interface ViewController ()
@property (nonatomic,weak) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///alear
    UIAlertView *alearView = [[UIAlertView alloc]initWithTitle:@"hello" message:@"keep your dream" delegate:nil cancelButtonTitle:@"cancle" otherButtonTitles:@"ok", nil];
    
    [alearView wc_bindAlertButtonClickedBlockNext:^(NSInteger index) {
        NSLog(@"0--clicked index: %ld",index);
    }];
    [alearView wc_bindAlertButtonClickedBlockNext:^(NSInteger index) {
        NSLog(@"1--clicked index: %ld",index);
    }];

    [alearView show];
    
    ////button
    UIButton *button = [[UIButton alloc]init];
    [button wc_bindForControlEvents:UIControlEventTouchUpInside blockNext:^(id sender) {
        NSLog(@"%@",sender);
    }];
    
    ///textfiled
    UITextField *textfiled = [[UITextField alloc]initWithFrame:CGRectMake(40, 40, 180, 35)];
    textfiled.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    textfiled.placeholder = @"please input your tel number...";
    [self.view addSubview:textfiled];
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
    
    ///view
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(textfiled.frame)+15, 80, 40)];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
   
    

    ///segmentedControl
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"title0",@"title1",@"title2"]];
    segment.frame = CGRectMake(40, CGRectGetMaxY(view.frame)+15, 180, 40);
    [self.view addSubview:segment];
    [segment wc_bindSegmentControlValueChangedBlockNext:^(NSInteger selectedIndex) {
        NSLog(@"segment selected index %ld",selectedIndex);
    }];
    
    ///gestureRecognizer
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]init];
    [self.view addGestureRecognizer:tapGes];
    [tapGes wc_bindGestureBlockNext:^(UIGestureRecognizer *sender) {
        NSLog(@"gestureRecognizer sender--%@",sender);
    }];
    
    
    ///slider
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(segment.frame)+15, 60, 30)];
    label.textColor = [UIColor redColor];
    label.textAlignment  =NSTextAlignmentCenter;
    [self.view addSubview:label];
    self.label = label;
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+15, label.frame.origin.y, 200, 40)];
    [self.view addSubview:slider];
    
    __weak typeof(self) weakSelf = self;
    [slider wc_bindSliderValueChangedBlockNext:^(CGFloat value) {
        __strong typeof(weakSelf) self = weakSelf;
        NSLog(@"slider value :%0.2f",value);
        self.label.text = [NSString stringWithFormat:@"%0.02f",value];
        self.label.backgroundColor = [UIColor greenColor];
        self.label.alpha = 1-value;
    }];
 
    
    ///NSNotificationCenter
    ///WCBlock 将自动为你管理移除消息中心的observer对象
    [[NSNotificationCenter defaultCenter] wc_addObserverForName:@"wc_noti_demo" object:nil contextObj:self blockNext:^(NSNotification * _Nullable note) {
        NSLog(@"%@",note.userInfo[@"note_demo"]);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"wc_noti_demo" object:nil userInfo:@{@"note_demo":@"WCBlock将自动为你管理移除observer对象"}];
        
    });

    //KVO   drag slider changed
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
    // and so on ...
    
    
    ///你可以为每个对象绑定多个block ，每个block都会调用  但是记住 handerBlock 除外（只能绑定一个，因为你并不希望多个hander同时操作一个对象,所以 WCBlock 是不允许的）比如：
   
    ///下面view的每个block 都将调用 且返回值是同一个WCViewTap对象
   WCViewTap *tap0 = [view wc_bindViewTapBlockNext:^(UIView *view, WCViewTap *tap) {
        NSLog(@"0--view taped");
    }];
    ///你可以通过返回值设置手势属性和代理, 比如：
    tap0.numberOfTapsRequired = 2;
//    tap0.delegate = self;
    
   WCViewTap *tap1 =  [view wc_bindViewTapBlockNext:^(UIView *view, WCViewTap *tap) {
        NSLog(@"1--view taped");
    }];
   WCViewTap *tap2 = [view wc_bindViewTapBlockNext:^(UIView *view, WCViewTap *tap) {
        NSLog(@"2--view taped");
    }];
   WCViewTap *tap3 = [view wc_bindViewTapBlockNext:^(UIView *view, WCViewTap *tap) {
        NSLog(@"3--view taped");
    }];
   WCViewPan *pan0 =  [view wc_bindViewPanBlockNext:^(UIView *view, WCViewPan *pan) {
        NSLog(@"pan...");
    }];
   WCViewLongPress *longPress0 = [view wc_bindViewLongPressBlockNext:^(UIView *view, WCViewLongPress *longPress) {
        NSLog(@"0--longPressed");
    }];
    WCViewLongPress *longPress1 = [view wc_bindViewLongPressBlockNext:^(UIView *view, WCViewLongPress *longPress) {
        NSLog(@"1--longPressed");
    }];
    
    [view wc_bindViewRotationBlockNext:^(UIView *view, WCViewRotation *rotation) {
        NSLog(@"%0.2f",rotation.rotation);//旋转角度
        NSLog(@"%0.2f",rotation.velocity);//旋转速度
    }];
    
    NSLog(@">>>>>%p-%p-%p-%p-%p-%p-%p",tap0,tap1,tap2,tap3,pan0,longPress0,longPress1);
    

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
