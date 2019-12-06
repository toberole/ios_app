#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"NextViewController #viewDidLoad");
//    UIButton *btn = [[UIButton alloc]init];
//    [btn setTitle:@"new page" forState:UIControlStateNormal];
//    btn.frame = CGRectMake(0, 0, 100, 100);
//    [self.view addSubview:btn];
    
//    self.navigationController;
//
//    self.view.window.rootViewController;
    
    NSLog(@"NextViewController navigationItem = %@",self.navigationItem);
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"NextViewController navigationItem = %@",self.navigationItem);
    
    self.title = @"第二页";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
}



@end
