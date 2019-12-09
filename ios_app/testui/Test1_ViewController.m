#import "Test1_ViewController.h"
/*通过拖拽 关联界面控件和控件的事件 */

@interface Test1_ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *tf1;
@property (strong, nonatomic) IBOutlet UITextField *tf2;
@property (strong, nonatomic) IBOutlet UILabel *res_label;

- (IBAction)add:(UIButton *)sender;

@end

@implementation Test1_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Test1_ViewController";
}

- (IBAction)add:(UIButton *)sender{
    NSString * tf1_str = _tf1.text;
    // 取出头尾的空白字符 whitespaceAndNewlineCharacterSet
    [tf1_str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // 字符串判断空
    if([_tf1.text isEqualToString:@""]){
        NSLog(@"text is empty");
    }
    int a = [_tf1.text intValue];
    int b = [_tf2.text intValue];
    
    int res = a+b;
    _res_label.text = [NSString stringWithFormat:@"%d",res];
    
    // 关闭键盘 1 那个控件调起的键盘 其就是FirstResponder
//    [_tf1 resignFirstResponder];
//    [_tf2 resignFirstResponder];
    
    // 关闭键盘 2
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning{
    NSLog(@"didReceiveMemoryWarning");
}

@end
