#import "UITableView_ViewController.h"
#import "Constant.h"


/*
 
 UITableViewCell
 UITableView每行都是一个UITableViewCell，通过dataSource的tableView:cellForRowAtIndexPath:方法来初始化每行
 UITableViewCell内部有个默认的子视图:contentView，contentView是UITableViewCell所显示内容的父视图，可以通过设置
 UITableViewCell的accessoryType来显示一些辅助指示视图，辅助指示视图用于表示动作的图标。
 
 系统提供的UITableView也包含了四种风格的布局
 typedef enum {
 UITableViewCellStyleDefault,
 UITableViewCellStyleValue1,
 UITableViewCellStyleValue2,
 UITableViewCellStyleSubtitle
 } UITableViewCellStyle;
 
 对cell进行定制,有以下两种定制方式可选：
    1、直接向cell的contentView上面添加subView
 这是比较简单的一种的，根据布局需要我们可以在不同的位置添加subView。但是此处需要注意：所有添加的subView都最好设置为不透明的，因为如果subView是半透明的话，view图层的叠加将会花费一定的时间，这会严重影响到效率。同时如果每个cell上面添加的subView个数过多的话(通常超过3，4个)，效率也会受到比较大的影响。
 2、从UITableViewCell派生一个类
 
 　　通过从UITableViewCell中派生一个类，可以更深度的定制一个cell，可以指定cell在进入edit模式的时候如何相应等等。最简单的实现方式就是将所有要绘制的内容放到一个定制的subView中，并且重载该subView的drawRect方法直接把要显示的内容绘制出来(这样可以避免subView过多导致的性能瓶颈)，最后再将该subView添加到cell派生类中的contentView中即可。但是这样定制的cell需要注意在数据改变的时候，通过手动调用该subView的setNeedDisplay方法来刷新界面.
 
 */



@interface UITableView_ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *uiTabView;

@property(nonatomic,strong)NSArray *data_test;
@end

@implementation UITableView_ViewController

-(UITableView *)tableView
{
    if (!_uiTabView) {
        //UITableViewStyleGrouped样式
        _uiTabView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        //UITableViewStylePlain 样式
        //_tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    }
    return _uiTabView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"UITableView_ViewController#viewDidLoad");
    // 系统UITableViewController
    UITableViewController *ui;
    
}

- (void)viewWillLayoutSubview{
    [super viewWillLayoutSubviews];
    NSLog(@"UITableView_ViewController#viewWillLayoutSubview");
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"UITableView_ViewController#viewDidLayoutSubviews");
    
    // _uiTabView = (UITableView *)[self.view viewWithTag:0];
    _uiTabView = [self tableView];
    NSLog(@"UITableView_ViewController#viewDidLayoutSubviews _uiTabView = %@",_uiTabView);
    // 设置数据源
    _uiTabView.dataSource = self;
    // 设置fream
    _uiTabView.frame = self.view.frame;
    // 设置代理
    _uiTabView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    [self initData];
    
    // 刷新view
    // [self.uiTabView reloadData];
}

-(void)initData{
    dispatch_queue_t queue = dispatch_queue_create("initData", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSString * url = [NSURL URLWithString:url3];
        NSURLSessionDataTask * task = [[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"url3 error = %@",error);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateUI:data];
            });
        }];
        [task resume];
    });
    
    dispatch_async(queue, ^{
        NSString * url = [NSURL URLWithString:url4];
        NSURLSessionDataTask * task = [[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"url4 error = %@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateUI1:data];
            });
        }];
        [task resume];
    });
}

/*
 json 解析
 
 [
     {
         "name": "hello1",
         "age": 11
     },
     {
         "name": "hello2",
         "age": 22
     }
 ]
 
 */
-(void)updateUI:(NSData *)data{
    NSLog(@"updateUI ......");
    
    _data_test = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary *dict in _data_test) {
        NSLog(@"name = %@",dict[@"name"]);
        NSLog(@"age = %@",dict[@"age"]);
    }
    
    [self.uiTabView reloadData];
}

/*
 
 json 解析
 
 {
     "code":110,
     "msg":"ok",
     "data":
         [
             {
                 "name": "hello1",
                 "age": 11
             },
             {
                 "name": "hello2",
                 "age": 22
             }
         ],
     "extra":{
         "weight":100,
         "height":"20"
        }
 }
 
 
 */
-(void)updateUI1:(NSData *)data{
    NSLog(@"updateUI 1 ......");
    
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSNumber *code = dict[@"code"];
    NSLog(@"code = %@",code);
    NSString *msg = dict[@"msg"];
    NSLog(@"msg = %@",msg);
    
    NSLog(@"data ......");
    NSArray *arr = dict[@"data"];
    for (NSDictionary *dict1 in arr) {
        NSLog(@"name = %@",dict1[@"name"]);
        NSLog(@"age = %@",dict1[@"age"]);
    }
    
    NSMutableDictionary *extra = dict[@"extra"];
    NSNumber *weight = extra[@"weight"];
    NSString *height = extra[@"height"];
    NSLog(@"weight = %@, height = %@",weight,height);
}

/* 多少个分组 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/* 每个分组有多少行数据 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_data_test) {
       return [_data_test count];
    }
    
    return 0;
}

/* 每一行显示的内容 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index{
    NSLog(@"NSIndexPath = %@",index);
    // 创建cell
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    // 设置accessoryType
    //    UITableViewCellAccessoryNone,                   // don't show any accessory view
    //    UITableViewCellAccessoryDisclosureIndicator,    // regular chevron. doesn't track
    //    UITableViewCellAccessoryDetailDisclosureButton, // info button w/ chevron. tracks
    //    UITableViewCellAccessoryCheckmark,              // checkmark. doesn't track
    //    UITableViewCellAccessoryDetailButton NS_ENUM_AVAILABLE_IOS(7_0) // info button. tracks
    
    
    NSDictionary *dict = self.data_test[index.section];
    NSLog(@"name = %@",dict[@"name"]);
    NSLog(@"age = %@",dict[@"age"]);
    cell.textLabel.text = dict[@"name"];
    
    return cell;
}

/**
 *  section组显示标题
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = self.data_test[section];
    NSLog(@"name = %@",dict[@"name"]);
    NSLog(@"age = %@",dict[@"age"]);
    return dict[@"name"];
}


/**
 *  section组显示描述
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSDictionary *dict = self.data_test[section];
    NSLog(@"name = %@",dict[@"name"]);
    NSLog(@"age = %@",dict[@"age"]);
    return dict[@"name"];
}

/**
 *  table 每一行的高度
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}


/**
 *  section组Header的高度
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSLog(@"height");
    return 30.0;
}

/**
 *  section组Footer的高度
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30.0;
}

/**
    cell 被点击
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}




@end


