#import "UITableViewViewController.h"

@interface UITableViewViewController ()
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *data;
@end

@implementation UITableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"UITableViewViewController#viewDidLoad");
    
    // 解决navigationBar遮挡视图的问题
    // IOS7之后ViewController的View是全屏的
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat width = [[UIScreen mainScreen]bounds].size.width;
    CGFloat height = [[UIScreen mainScreen]bounds].size.height;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,width,height) style:UITableViewStylePlain];
    
    NSLog(@"UITableViewViewController#viewDidLoad self.view = %@",self.view);
    [self.view addSubview:_tableView];
    
    self.title = @"TableView Test";
    
    [self initData];
    [self.tableView reloadData];
}

-(void)initData{
    
}


@end
