#import "APPAutoResizingDemoViewController.h"

@interface APPAutoResizingDemoViewController ()

@end

@implementation APPAutoResizingDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    // 代码autoresizing
    UIView * v1 = [[UIView alloc]init];
    v1.backgroundColor = [UIColor grayColor];
    v1.frame = CGRectMake(0,0,100,100);
    [self.view addSubview:v1];
    
    UIView * v2 = [[UIView alloc]init];
    v2.backgroundColor = [UIColor blueColor];
    v2.frame = CGRectMake(0,0,50,50);
    [v1 addSubview:v2];
    
    v2.autoresizingMask = UIViewAutoresizingNone;
    /**
     UIViewAutoresizingNone                 = 0,
     
     // 距离右边不变
     UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
     
     // 宽度随着父View变化而变化
     UIViewAutoresizingFlexibleWidth        = 1 << 1,
     
     // 距离左边不变
     UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
     
     // 距离下边不变
     UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
     
     // 高度随着父View变化而变化
     UIViewAutoresizingFlexibleHeight       = 1 << 4,
     
     // 距离上边不变 
     UIViewAutoresizingFlexibleBottomMargin = 1 << 5
     */
    
    
    
}



@end
