#import "APPTaskViewController.h"

/*
 GCD 的使用步骤其实很简单 只有两步：
 
 1、创建一个队列（串行队列或并发队列）；
 2、将任务追加到任务的等待队列中，然后系统就会根据任务类型执行任务（同步执行或异步执行）。
 
 */

@interface APPTaskViewController ()
- (IBAction)btn_gcd1:(UIButton *)sender;
- (IBAction)btn_gcd2:(id)sender;
- (IBAction)btn_gcd3:(UIButton *)sender;

@end

@implementation APPTaskViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)btn_gcd1:(UIButton *)sender {
//    [self showAlert];
    
    /*
         第一个参数表示队列的唯一标识符，用于 DEBUG，可为空。队列的名称推荐使用应用程序 ID 这种逆序全程域名。
         第二个参数用来识别是串行队列还是并发队列。DISPATCH_QUEUE_SERIAL 表示串行队列，DISPATCH_QUEUE_CONCURRENT 表示并发队列。
     */
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i<150;i++) {
        dispatch_async(queue, ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"i = %d",i);
        });
    }
    
    
}

-(void)showAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"设置别名不得超过三个字" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:confirmAction];
    //创建用于显示alertController的UIViewController
    UIViewController *alertVC = [[UIViewController alloc]init];
    [self.view addSubview:alertVC.view];
    [alertVC presentViewController:alertController animated:YES completion:^{
        //移除用于显示alertController的UIViewController
        [alertVC.view removeFromSuperview];
    }];
}

- (IBAction)btn_gcd2:(id)sender {
}

- (IBAction)btn_gcd3:(UIButton *)sender {
}
@end
