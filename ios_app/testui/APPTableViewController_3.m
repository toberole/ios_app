#import "APPTableViewController_3.h"
#import "APPTableViewController_3_Cell.h"
#import "MySectionView.h"
@interface APPTableViewController_3 ()<MySectionViewDelegate>

@property(nonatomic,strong) NSMutableArray * data1;
@property(nonatomic,strong) NSMutableArray * data2;
@property(nonatomic,strong) NSMutableArray * data3;
@property(nonatomic,strong) NSMutableArray * sections;

@property(nonatomic,weak) MySectionView * cur_MySectionView;

@property(nonatomic,strong) UITableView *  tableView;

@end

@implementation APPTableViewController_3

///////////////////////////////////////////////
-(NSMutableArray *)sections{
    if (!_sections) {
        _sections = [[NSMutableArray alloc]init];
        for (int i = 0; i < 3; i++) {
            NSString *s = [NSString stringWithFormat:@"section-%d",i,nil];
            [_sections addObject:s];
        }
    }
    
    return _sections;
}
///////////////////////////////////////////////
-(NSMutableArray *)data1{
    if (!_data1) {
        _data1 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 10; i++) {
            NSString *s = [NSString stringWithFormat:@"hello1-%d",i,nil];
            [_data1 addObject:s];
        }
    }
    
    return _data1;
}

-(NSMutableArray *)data2{
    if (!_data2) {
        _data2 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 15; i++) {
            NSString *s = [NSString stringWithFormat:@"hello2-%d",i,nil];
            [_data2 addObject:s];
        }
    }
    
    return _data2;
}

-(NSMutableArray *)data3{
    if (!_data3) {
        _data3 = [[NSMutableArray alloc]init];
        for (int i = 0; i < 20; i++) {
            NSString *s = [NSString stringWithFormat:@"hello3-%d",i,nil];
            [_data3 addObject:s];
        }
    }
    
    return _data3;
}
///////////////////////////////////////////////


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"APPTableViewController_3";
    
    self.tableView = [self.view viewWithTag:100];
    NSLog(@"tableView: %@",self.tableView);
    // 设置Section高度
    self.tableView.sectionHeaderHeight = 45;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 通过返回值控制每个分段的收缩
    if (section==0) {
        if([self.cur_MySectionView getSectionIndex] == section && [self.cur_MySectionView getstate] == CLOSED){
            return 0;
        }else{
            return self.data1.count;
        }
        return self.data1.count;
    }else if (section==1) {
        if([self.cur_MySectionView getSectionIndex] == section && [self.cur_MySectionView getstate] == CLOSED){
            return 0;
        }else{
            return self.data2.count;
        }
        return self.data2.count;
    }else if (section==2) {
        if([self.cur_MySectionView getSectionIndex] == section && [self.cur_MySectionView getstate] == CLOSED){
            return 0;
        }else{
            return self.data3.count;
        }
        return self.data3.count;
    }
    return 0;
}

/// 设置组标题字符串
//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return self.sections[section];
//}

/// 自定义 section view
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    // 继承自UITableViewHeaderFooterView 的Section才具有重用功能
    // 自己写的UIView不能重用
    static NSString * ID = @"section_reuseIdentifier";
    MySectionView * sv = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!sv) {
        sv = [MySectionView sectionView];
    }
    
    [sv setMyDelegate:self];
    [sv setstate:OPENED];
    [sv setSectionIndex:section];
    [sv setBtnTxt:self.sections[section]];
    [sv setLlbTxt:self.sections[section]];
    return sv;
}

-(void)mySectionViewOnclicked:(MySectionView *)v{
    NSLog(@"mySectionViewOnclicked: %@",v);
    self.cur_MySectionView = v;
    NSIndexSet *nsIndexSet = [NSIndexSet indexSetWithIndex:[v getSectionIndex]];
    [self.tableView reloadSections:nsIndexSet withRowAnimation:UITableViewRowAnimationNone];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell_reuseIdentifier";
    APPTableViewController_3_Cell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"APPTableViewController_3_Cell" owner:nil options:nil]lastObject];
    }
    
    // 设置cell选中背景颜色
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    NSString * txt = nil;
    if (indexPath.section == 0) {
        txt = self.data1[indexPath.row];
    }else if (indexPath.section == 1) {
        txt = self.data2[indexPath.row];
    }else if (indexPath.section == 2) {
        txt = self.data3[indexPath.row];
    }
    [cell setTextForCell:txt];
    
    return cell;
}

@end
