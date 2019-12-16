#import "APPTableViewController_1.h"
#import "CellDemoTableViewCell.h"

@interface APPTableViewController_1 ()<UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray * data;
@end

@implementation APPTableViewController_1

-(NSMutableArray*)data{
    if (!_data) {
        _data = [[NSMutableArray alloc]init];
        for (int i = 0; i < 10; i++) {
            NSString * s = [NSString stringWithFormat:@"hello %d",i];
            [_data addObject:s];
        }
    }
    NSLog(@"count = %ld",_data.count);
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.dataSource = self;
    
    // 设置footerview
    // 注意footerview的fream只有x和height有效 y和width设置无效
    UIButton *footerview = [[UIButton alloc]init];
    footerview.backgroundColor = [UIColor grayColor];
    footerview.frame = CGRectMake(0, 10, 0, 50);
    _tableView.tableFooterView = footerview;
    
    // 设置headerview
    UIButton *headerview = [[UIButton alloc]init];
    headerview.backgroundColor = [UIColor redColor];
    headerview.frame = CGRectMake(0, 10, 0, 50);
    _tableView.tableHeaderView = headerview;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // xib构建cell
    // 注意使用xib构建cell时候 重用的id必须于xib文件里面设置的identifier一致
    NSString * cell_id = @"cell_demo";
    CellDemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"cell_demo" owner:nil options:nil]lastObject];
    }else{
        NSLog(@"重用cell");
    }
    
    [cell setLbl_cell:self.data[indexPath.row]];
    
    return cell;
}




@end
