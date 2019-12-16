#import "APPTableViewController_1.h"
#import "CellDemoTableViewCell.h"
#import "FooterView.h"
@interface APPTableViewController_1 ()<UITableViewDataSource,FootViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray * data;

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
    _tableView.dataSource = self;
    // 注意设置footerview的fream只有x和height有效 y和width设置无效
    FooterView * footer = [FooterView footerView];
    footer.delegate = self;
    _tableView.tableFooterView = footer;
    
    // 设置headerview
}

- (void)footerViewloadMore:(FooterView *)footerView{
    // 加载更多数据
    NSLog(@"加载更多数据 .... footerViewloadMore");
    [self.data addObject:@"load more data"];
    [self.tableView reloadData];
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
    }
    [cell setLblCellText:self.data[indexPath.row]];
    return cell;
}




@end
