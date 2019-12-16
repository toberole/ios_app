#import "APPUIViewController.h"

#import "APPUIScrollViewController.h"


@interface APPUIViewController ()
@property(nonatomic,strong) UIButton *btn_scrollview;
@end

@implementation APPUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UI Base";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
    item.title = @"";
    self.navigationItem.backBarButtonItem = item;
    
    [self initViews];
}

-(void)initViews{
    _btn_scrollview = [self.view viewWithTag:1];
    [_btn_scrollview addTarget:self action:@selector(btn_scrollview_clicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btn_scrollview_clicked{
    APPUIScrollViewController *vc = [[APPUIScrollViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
