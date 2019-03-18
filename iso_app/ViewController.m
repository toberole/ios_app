#import "ViewController.h"

#import "NextViewController.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define TOAST_WIDTH 150
#define TOAST_HEIGHT 50
#define TOAST_DURATION 2.5

/**
  使用xib文件画界面 需要在File woner中组view的关联
  如果不做的话 可以直接给ViewCOntroll的view属性赋值
 **/

// 匿名 category
@interface ViewController ()

// 编译器自动生成的成员变量为 "_name"
@property UITextField *name;
@property UITextField *email;
@property UIButton *btn;
@property UIButton *btn_next;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Mainpage viewDidLoad");
    
//    UIButton *btn = [[UIButton alloc]init];
//    [btn setTitle:@"new page" forState:UIControlStateNormal];
//    btn.frame = CGRectMake(0, 0, 100, 100);
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(btn_next_Clicked) forControlEvents:UIControlEventTouchUpInside];
    
    // 获取到name
    _name = (UITextField*)[self.view viewWithTag:1];
    _email = (UITextField*)[self.view viewWithTag:2];
    _btn = [self.view viewWithTag:3];
    _btn_next = [self.view viewWithTag:4];
    
    [_btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [_btn_next addTarget:self action:@selector(btn_next_Clicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void) btnClicked{
    NSString *str_name =_name.text;
    NSString *str_email = _email.text;
    NSLog(@"name = %@, email = %@",str_name,str_email);
    
    NSString *msg  = [@"" stringByAppendingFormat:@"%@,%@",str_name, str_email];
    
    [self showMsg:msg];
}

-(void) btn_next_Clicked{
    NSLog(@"btn_next_Clicked %@",self.navigationController);
    
    // NextViewController 创建的时候 同时创建了同名的 xib文件 系统自自动去找xib文件 绘制界面
    // 可以修改xib文件的file owner
//    NextViewController *nc = [[NextViewController alloc]init];
//    [self.navigationController pushViewController:nc animated:YES];//跳转到下一页面

    
//    NextViewController *next_page = [[NextViewController alloc]initWithNibName:@"Test_Next_Page" bundle:nil];
//
//    [self.navigationController pushViewController:next_page animated:YES];//跳转到下一页面
    
    
    // 获取xib 系统会把里面的实现xib描述的view
    /*
         name：nib文件的名称
     
         owner：指定name参数所指代的nib文件的File's Owner
     
         options：当nib文件开始时，需要的数据
     */
    NSArray *apparray= [[NSBundle mainBundle]loadNibNamed:@"Test_Next_Page" owner:nil options:nil];
    NSLog(@"views = %@",apparray);
    NextViewController *nc  = [[NextViewController alloc]init];
    nc.view = apparray[0];
    [self.navigationController pushViewController:nc animated:YES];//跳转到下一页面
    // 隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
}

-(void)showMsg:(NSString *)msg{
    UILabel *ul = [[UILabel alloc]init];
    ul.textAlignment  = NSTextAlignmentCenter;
    ul.text = msg;
    ul.backgroundColor = [UIColor lightGrayColor];
    ul.frame = CGRectMake((SCREEN_WIDTH-TOAST_WIDTH)/2, (SCREEN_HEIGHT-TOAST_HEIGHT)/2, TOAST_WIDTH, TOAST_HEIGHT);
    ul.alpha = 1.0;
    [self.view addSubview:ul];
    [UIView animateWithDuration:TOAST_DURATION animations:^(){
        ul.alpha = 0.0;
    }completion:^(BOOL finished){
        [ul removeFromSuperview];
    }];
}

@end
