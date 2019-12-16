#import "APPTableViewController_1.h"
#import "CellDemoTableViewCell.h"
#import "FooterView.h"
#import "HeaderView.h"

@interface APPTableViewController_1 ()<UITableViewDataSource,FootViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSMutableArray * data;
@property (strong,nonatomic) HeaderView * header;
@property (strong,nonatomic) NSTimer * timer;
@property (nonatomic,assign) NSInteger page;

@end

@implementation APPTableViewController_1

-(NSMutableArray*)data{
    if (!_data) {
        _data = [[NSMutableArray alloc]init];
        for (int i = 0; i < 20; i++) {
            NSString * s = [NSString stringWithFormat:@"hello %d",i,nil];
            [_data addObject:s];
        }
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 注意设置footerview的fream只有x和height有效,y和width设置无效
    FooterView * footer = [FooterView footerView];
    footer.delegate = self;
    _tableView.tableFooterView = footer;
    
    // 设置headerview
    self.header = [HeaderView headerView];
    _tableView.tableHeaderView = self.header;
    
    // 创建计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scrollHeader) userInfo:nil repeats:YES];
    
    // 设置NSTimer和UI一个级别[由于NSTimer的默认优先级比较低 如果不设置的时候 触摸屏幕其就得不到执行]
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.page = 0;
    
    // 监听键盘弹出事件[弹出事件是个通知] 实现键盘弹出界面上下移动
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(keyBoard_action:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)keyBoard_action:(NSNotification *)notification{
    NSLog(@"接收到 notification_x 通知名称 = %@",notification.name);
    NSLog(@"接收到 notification_x 通知发布者 = %@",notification.object);
    NSLog(@"接收到 notification_x 通知携带的信息 = %@",notification.userInfo);
    // 计算平移值 获取键盘Y值
    CGRect rectEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = rectEnd.origin.y;
    CGFloat screen_height = [[UIScreen mainScreen]bounds].size.height;
    CGFloat dis_move = screen_height - keyboardY;
    NSLog(@"dis_move = %lf",dis_move);
    // 获取键盘弹出的时间 让view执行动画 以确保view和键盘的时间同步 防止出现不同步导致view移动之后 留下的黑色空洞
    CGFloat time = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:time animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -dis_move/* 移动到的位置 */);
    }];
    
    // tableview 最后一行滚动出来
    NSIndexPath *idx = [NSIndexPath indexPathForRow:self.data.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idx atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)dealloc
{
     NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)scrollHeader{
    [self.header scroll:(++self.page) % 3];
}

- (void)footerViewloadMore:(FooterView *)footerView{
    // 加载更多数据
    NSLog(@"加载更多数据 .... footerViewloadMore");
    [self.data addObject:@"load more data"];
    [self.tableView reloadData];
    
    // 滚动tableview到最上面
//    UITableViewScrollPositionNone
//    UITableViewScrollPositionTop
//    UITableViewScrollPositionMiddle
//    UITableViewScrollPositionBottom
    NSIndexPath *idx = [NSIndexPath indexPathForRow:self.data.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idx atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    // 刷行指定行
    // self.tableView reloadRowsAtIndexPaths:nil withRowAnimation:nil
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 缩回键盘
    NSLog(@"缩回键盘 ......");
    [self.view endEditing:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRowsInSection = %ld",self.data.count);
    return self.data.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // xib构建cell时 重用的id必须于xib文件里面设置的identifier一致
    NSString * cell_id = @"cell_demo";
    CellDemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"cell_demo" owner:nil options:nil]lastObject];
        
        // 设置cell选中背景颜色
        cell.selectedBackgroundView = [UIView new];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    [cell setLblCellText:self.data[indexPath.row]];
    return cell;
}

@end
