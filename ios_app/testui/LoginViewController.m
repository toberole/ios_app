#import "LoginViewController.h"

/**
 文本框属性设置
    提示符：placeholder
    clear button：显示文本框右边的小叉
    content type：设置类型
 */

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *name_label;
@property (strong, nonatomic) IBOutlet UITextField *pwd_label;
@property(assign,nonatomic)int n;
@property (strong, nonatomic) IBOutlet UIView *cv;
@property(nonatomic,strong)UIView *v;
- (IBAction)login:(UIButton *)sender;
- (IBAction)OP_clicked:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _n = 0;
}

- (IBAction)login:(UIButton *)sender {
    NSString * name = _name_label.text;
    NSString * pwd = _pwd_label.text;
    NSLog(@"name = %@,pwd = %@",name,pwd);
    
    // 关闭键盘
    [self.view endEditing:YES];
}

- (IBAction)OP_clicked:(UIButton *)sender {
    NSLog(@"OP_clicked ------ i: %d",(_n % 3));
    if (_n % 3 == 0) {
        if (_v) {
            [_v removeFromSuperview];
        }
        // 与父view左上角对齐
        _v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _v.bounds = CGRectMake(0, 0, 100, 100);
        [_v setBackgroundColor:[UIColor whiteColor]];
        [_cv addSubview: _v];
    }else if (_n % 3 == 1) {
        if (_v) {
            [_v removeFromSuperview];
        }
        // 位于父view右下角
        _v = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
        _v.bounds = CGRectMake(0, 0, 100, 100);
        [_v setBackgroundColor:[UIColor whiteColor]];
        [_cv addSubview: _v];
    }else if (_n % 3 == 2) {
        if (_v) {
            [_v removeFromSuperview];
        }
        // 位于父view左上角
        _v = [[UIView alloc]initWithFrame:CGRectMake(-10, -10, 100, 100)];
        _v.bounds = CGRectMake(0, 0, 100, 100);
        [_v setBackgroundColor:[UIColor whiteColor]];
        [_cv addSubview: _v];
    }
    
    _n++;
}
@end
