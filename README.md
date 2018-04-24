# WCBlock
a lightweight block library of UIKit extension

# use as follow 

```objective-c

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
        NSLog(@"clicked index: %ld",index);
    }];
    [alearView show];
    
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
    [view wc_bindViewClickedBlockNext:^(UIView *view) {
        NSLog(@"view clicked");
    }];
    
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
    
    
    //And so on...
    
}
- (void)dealloc {
    [self.label wc_removeObserverForKeyPath:@"text"];
    [self.label wc_removeObserverForKeyPath:@"alpha"];
//    [self.label wc_removeObserverForKeyPaths:@[@"alpha",@"text"]];
}

```
