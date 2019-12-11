#import "Test1_ViewController.h"
/*
    通过拖拽 关联界面控件和控件的事件
 
    动态添加View
 */

@interface Test1_ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *tf1;
@property (strong, nonatomic) IBOutlet UITextField *tf2;

@property (strong, nonatomic) IBOutlet UILabel *res_label;

@property (strong, nonatomic) IBOutlet UIButton *btn_add;
@property (strong, nonatomic) IBOutlet UIButton *btn_op;

@property (strong, nonatomic) IBOutlet UIButton *btn_bg;

- (IBAction)add:(UIButton *)sender;
- (IBAction)btn_op:(UIButton *)sender;



@end

@implementation Test1_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Test1_ViewController";
    // [self addView_code];
    [self addView_code1];
    
    // 正常状态
    [_btn_bg setBackgroundImage:[UIImage imageNamed:@"0.jpg"] forState:UIControlStateNormal];
    // UIControlStateHighlighted 手触摸上去之后
    [_btn_bg setBackgroundImage:[UIImage imageNamed:@"1.jpg"]  forState:UIControlStateHighlighted];
}

-(void)addView_code1{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 300, 200, 50)];
    [btn setTitle:@"xxxxxx" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"x.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

-(void)addView_code{
    NSLog(@"--- addView_code ---");
    UIButton *btn = [[UIButton alloc]init];
    CGRect fream = CGRectMake(50, 100, 100, 200);
    btn.frame = fream;
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn setTitle:@"动态添加按钮" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    
    [self.view addSubview:btn];
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

- (IBAction)btn_op:(UIButton *)sender {
    /*
         fream 可以修改位置和大小 修改大小中心位置变化
         center 只能修改位置
         bounds 只能修改大小 修改中心位置不变
         transform 修改大小 位置 ...
     
        CGRect fream: x y 参考坐标是其父节点
        CGRect bounds: x y 参考坐标是其本身 所以x和y总是0
        CGPoint center: 参考坐标是其父节点
     */
    
    // [self op1];
    // [self op2];
    // [self op3];
     [self op4];
    
    
    
}

#pragma maek 修改大小 transform动画
-(void)op4{
    // 启动动画
    [UIView beginAnimations:nil context:nil];
    // 设置动画时间
    [UIView setAnimationDuration:2];
    
    //////////头尾式动画代码///////////
//    CGRect bounds = _btn_add.bounds;
//    bounds.size.height = bounds.size.height+10;
//    bounds.size.width = bounds.size.width+10;
//    _btn_add.bounds = bounds;
    //////////动画代码///////////
    // 提交动画
    // [UIView commitAnimations];
    
    //////////Block 式动画代码///////////
    [UIView animateWithDuration:2 animations:^{
        CGRect bounds = _btn_add.bounds;
        bounds.size.height = bounds.size.height+10;
        bounds.size.width = bounds.size.width+10;
        _btn_add.bounds = bounds;
    }];
    //////////动画代码///////////
}

#pragma maek 修改大小bounds
-(void)op3{
    CGRect bounds = _btn_add.bounds;
    bounds.size.height = bounds.size.height+10;
    bounds.size.width = bounds.size.width+10;
    _btn_add.bounds = bounds;
}

#pragma maek 修改大小frame
-(void)op2{
    // 通过修改frame 修改大小
    CGRect fream = _btn_add.frame;
    fream.size.height = fream.size.height+10;
    fream.size.width = fream.size.width+10;
    _btn_add.frame = fream;
}

#pragma mark 移动frame
-(void)op1{
    // 通过修改frame 的x,y值来移动view
    // 获取btn的原始的fram
    CGRect fream =  _btn_add.frame;
    // 上移动
    fream.origin.y = fream.origin.y-10;
    // 右移动
    fream.origin.x = fream.origin.x+10;
    _btn_add.frame = fream;
}

- (void)didReceiveMemoryWarning{
    NSLog(@"didReceiveMemoryWarning");
}

@end
