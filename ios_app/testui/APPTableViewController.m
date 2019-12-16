#import "APPTableViewController.h"
/**
    UITableView 类似android的ListView
 */
@interface APPTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
// @property(nonatomic,strong)NSArray *data;
// @property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong) NSArray * data;
@property(nonatomic,strong) NSArray * sections;
@property(nonatomic,assign) int section_count;

@end

@implementation APPTableViewController

// 懒加载
// 重写属性的getter
-(NSArray*)data{
    if (!_data) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"tableview" ofType:@"plist"];
        _data = [[NSArray alloc]initWithContentsOfFile:path];
        _section_count = [_data count];
    }
    NSLog(@"section_count = %ld",_section_count);
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置行高 每一行高度一致 如果需要每行不一致 需要通过代理UITableViewDelegate设置
    // _tableView.rowHeight = 60;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 设置分割线颜色
    _tableView.separatorColor = [UIColor yellowColor];
    // 分割线样式
    // _tableView.separatorStyle
    
    // self.tableView.tableFooterView
    // self.tableView.tableHeaderView
    [self initData];
}

-(void)initData{
    // "."语法等同于调用get set
    self.data;
}

/************** UITableViewDelegate回调  **************/
/// 设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row%2 == 0){
        return 50.0;
    }else{
        return 70.0;
    }
}

/************** UITableViewDataSource方法  **************/

/// 分组数
/// 默认是一组
/// @param tableView tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _section_count;
}


/// 每一组的行数
/// @param section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary * section_item_dict = _data[section];
    NSString *section_name = [[section_item_dict allKeys]lastObject];
    return [section_item_dict[section_name] count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

/// 指定组的指定行显示的view
/// @param indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // return [self getCell:indexPath];
    // 缓存重用
    return [self getCell_1:tableView cellForRowAtIndexPath:indexPath];
}

/// 缓存重用
-(UITableViewCell*)getCell_1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier = @"xxx";
    // 查找缓存
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    // 没有找到缓存可重用的 重建
    if (!cell) {
         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }else{
        NSLog(@"找到缓存可重用");
    }
   
    cell.textLabel.text = @"hello";

    return cell;
}

-(UITableViewCell*)getCell:(NSIndexPath *)indexPath{
    // 系统默认的几种cell 可以自定义
    /**
     UITableViewCellStyleDefault
     UITableViewCellStyleValue1
     UITableViewCellStyleValue2
     UITableViewCellStyleSubtitle
     */
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    long section = indexPath.section;
    long row = indexPath.row;
    NSDictionary *section_dict = _data[section];
    NSArray *section_items = section_dict[[[section_dict allKeys]lastObject]];
    // 设置属性 不同样式的cell包含的组件不一样
    // 如果对应的样式不存在被设置的组件 那么设置了也是无效的
    cell.imageView.image =[UIImage imageNamed:@"1.jpg"];
    cell.detailTextLabel.text = section_items[row];
    cell.textLabel.text = section_items[row];
    // cell 最右边的小view
    // cell.accessoryType =
    // cell.accessoryView
    
    // 设置背景
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor redColor];
    }else{
        cell.backgroundColor = [UIColor greenColor];
    }
    
    // 设置选中的颜色
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor blueColor];
    cell.selectedBackgroundView = bgView;
    
    return cell;

}

/// 行被选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"被选中 row: %ld",indexPath.row);
}

/// 行被取消选中
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"被取消选中 row: %ld",indexPath.row);
}

/// 索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return @[@"A",@"B"];
}


/// 每一个分组的头名字
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary * dict = _data[section];
    NSString * header = [[dict allKeys]lastObject];
    header = [header stringByAppendingFormat:@"+header"];
    return header;
}

/// 每一个分组的脚名字
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSDictionary * dict = _data[section];
    NSString * footer = [[dict allKeys]lastObject];
    footer = [footer stringByAppendingFormat:@"+footer"];
    return footer;
}
/************** UITableViewDataSource方法  **************/


- (void)didReceiveMemoryWarning{
    NSLog(@"didReceiveMemoryWarning");
}

/// 状态栏是否隐藏
-(BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
//    UIStatusBarStyleDefault                                  = 0, // Automatically chooses light or dark content based on the user interface style
//    UIStatusBarStyleLightContent     API_AVAILABLE(ios(7.0)) = 1, // Light content, for use on dark backgrounds
//    UIStatusBarStyleDarkContent     API_AVAILABLE(ios(13.0)) = 3, // Dark content, for use on light backgrounds
//
//    UIStatusBarStyleBlackTranslucent NS_ENUM_DEPRECATED_IOS(2_0, 7_0, "Use UIStatusBarStyleLightContent") = 1,
//    UIStatusBarStyleBlackOpaque      NS_ENUM_DEPRECATED_IOS(2_0, 7_0, "Use UIStatusBarStyleLightContent") = 2,
    return UIStatusBarStyleDarkContent;
}
@end
