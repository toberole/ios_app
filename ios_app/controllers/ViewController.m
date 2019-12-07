#import "ViewController.h"

#import "NextViewController.h"

#import "../test/Test_Selector.h"
#import "NetViewController.h"
#import "StatusBarNavigationBarViewController.h"
#import "UITableView_ViewController.h"
#import "UITableViewViewController.h"
#import "OCBaseViewController.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define TOAST_WIDTH 150
#define TOAST_HEIGHT 50
#define TOAST_DURATION 2.5

/**
 使用xib文件画界面 需要在File woner中组view的关联
 如果不做的话 可以直接给ViewCOntroll的view属性赋值
 **/

// 匿名 category
@interface ViewController ()

// 编译器自动生成的成员变量为 "_name"
@property UITextField *name;
@property UITextField *email;
@property UIButton *btn;
@property UIButton *btn_next;

@property (nonatomic,strong)UIButton *json_btn;
@property(nonatomic ,strong)UIButton *selector_btn;
@property(nonatomic,strong)UIButton *net_btn;
@property(nonatomic,strong)UIButton *test_bar_btn;
@property(nonatomic,strong)UIButton *uiTabView_btn;
@property(nonatomic,strong)UIButton *uiTabView_btn1;

@property(nonatomic,strong)UIButton *ocbase_btn;
@end

@implementation ViewController

// loadview -> viewDidLoad -> viewWillAppear -> viewDidAppear

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"ViewController navigationItem = %@",self.navigationItem);
    
    // 设置导航栏
    [self setNav];
    
    
    NSLog(@"ViewController#viewDidLoad");
    //    UIButton *btn = [[UIButton alloc]init];
    //    [btn setTitle:@"new page" forState:UIControlStateNormal];
    //    btn.frame = CGRectMake(0, 0, 100, 100);
    //    [self.view addSubview:btn];
    //    [btn addTarget:self action:@selector(btn_next_Clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self initViews];
}

-(void)initViews{
    // 获取到name
    _name = (UITextField*)[self.view viewWithTag:1];
    _email = (UITextField*)[self.view viewWithTag:2];
    _btn = [self.view viewWithTag:3];
    _btn_next = [self.view viewWithTag:4];
    _json_btn = [self.view viewWithTag:5];
    _selector_btn =[self.view viewWithTag:7];
    _net_btn = [self.view viewWithTag:8];
    _test_bar_btn = [self.view viewWithTag:9];
    _uiTabView_btn = [self.view viewWithTag:10];
    _uiTabView_btn1 = [self.view viewWithTag:11];
    _ocbase_btn = [self.view viewWithTag:12];
    
    /*
     _btn.frame: 该view在父view坐标系统中的位置和大小，它的参考坐标系是父view的坐标系
     _btn.bounds: 该view在本地坐标系统中的位置和大小，它的参考坐标系是自身的坐标系，原点始终为（0，0）
     */
    
    [_btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_btn_next addTarget:self action:@selector(btn_next_Clicked) forControlEvents:UIControlEventTouchUpInside];
    [_json_btn addTarget:self action:@selector(btn_json) forControlEvents:UIControlEventTouchUpInside];
    [_selector_btn addTarget:self action:@selector(btn_selector_clicked) forControlEvents:UIControlEventTouchUpInside];
    [_net_btn addTarget:self action:@selector(btn_net_Clicked) forControlEvents:UIControlEventTouchUpInside];
    [_test_bar_btn addTarget:self action:@selector(test_bar_btn_clicked) forControlEvents:UIControlEventTouchUpInside];
    [_uiTabView_btn addTarget:self action:@selector(uiTabView_btn_clicked) forControlEvents:UIControlEventTouchUpInside];
    [_uiTabView_btn1 addTarget:self action:@selector(uiTabView_btn1_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [_ocbase_btn addTarget:self action:@selector(oc_base_btn_clicked) forControlEvents:  UIControlEventTouchUpInside];
}

-(void)oc_base_btn_clicked{
    OCBaseViewController *vc = [[OCBaseViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)uiTabView_btn_clicked{
    UITableView_ViewController *vc = [[UITableView_ViewController alloc]init];
    NSArray * views = [[NSBundle mainBundle]loadNibNamed:@"listview" owner:nil options:nil];
    UIView *v = views[0];
    vc.view = v;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)uiTabView_btn1_clicked{
    NSLog(@"uiTabView_btn1_clicked");
    UITableViewViewController *vc = [[UITableViewViewController alloc]init];
    NSLog(@"uiTabView_btn1_clicked UITableViewViewController after");
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)test_bar_btn_clicked{
    StatusBarNavigationBarViewController *vc = [[StatusBarNavigationBarViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 跳转网络页面
-(void)btn_net_Clicked{
    NSLog(@"btn_net_Clicked");
    
     // 可以修改xib文件的file owner
    
//    NSArray *apparray= [[NSBundle mainBundle]loadNibNamed:@"Test_Next_Page" owner:nil options:nil];
//    NSLog(@"views = %@",apparray);
//    NSLog(@"views = %@",apparray[0]);
//    NextViewController *nc  = [[NextViewController alloc]init];
//    nc.view = apparray[0];
//    [self.navigationController pushViewController:nc animated:YES];//跳转到下一页面
    
    
    NSArray * arr = [[NSBundle mainBundle]loadNibNamed:@"netpage" owner:nil options:nil];
    NSLog(@"views count = %ld",[arr count]);
    NetViewController *nc = [[NetViewController alloc]init];
    UIView *view = arr[0];
    NSLog(@"views subviews count = %ld",[[view subviews]count]);
    nc.view = view;
    [self.navigationController pushViewController:nc animated:YES];//跳转到下一页面

}
/*
 获取SEL值：
 1、
 SEL sel_name= @selector(方法名字);
 2、
 SEL sel_name =NSSelectorFromString(方法名字字符串)
 
 调用SEL
 performSelector传递参数不能超过2个
 1、把参数封装成集合或者class
 2、用NsInvocation代替performSelector可以实现传递多个参数
 3、使用runtime中的objc_msgSend进行消息的发送
 
 [对象 performSelector: SEL变量]
 [对象 performSelector: SEL变量 withObject:参数1 withObject:参数2]
 */
#pragma mark 使用selector
-(void)btn_selector_clicked{
    NSLog(@"btn_selector_clicked");
    Test_Selector * test_selector = [[Test_Selector alloc]init];
    // 获取SEL
    SEL sel1 = @selector(func1);
    SEL sel2 = NSSelectorFromString(@"func1");
    SEL sel3 = @selector(func2::);
    SEL sel4 = NSSelectorFromString(@"func2::");
    
    // 使用SEL
    [test_selector performSelector:sel1];
    [test_selector performSelector:sel2];
    NSNumber *a = [[NSNumber alloc]initWithInt:1];
    int a_v = [a intValue];
    NSLog(@"a = %i",a_v);
    NSNumber *b = [[NSNumber alloc]initWithInt:2];
    [test_selector performSelector:sel3 withObject:a withObject:b];
    
    NSNumber *c = [[NSNumber alloc]initWithInt:3];
    NSNumber *d = [[NSNumber alloc]initWithInt:4];
    [test_selector performSelector:sel4 withObject:c withObject:d];
    // 检查对象可否调用
    if ([test_selector respondsToSelector:sel1]) {
        NSLog(@"可以调用 func1");
    }
    
    NSLog(@"使用NsInvocation");
    // 使用NsInvocation
    // 方法签名描述
    NSMethodSignature *signature = [[Test_Selector class]instanceMethodSignatureForSelector:@selector(func2::)];
    // 方法包装
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    // 设置方法调用者
    [invocation setTarget:test_selector];
    // 设置需要调用的方法 必须与NSMethodSignaturel里面的一致
    [invocation setSelector:@selector(func2::)];
    // 设置参数
    NSNumber *aa = [[NSNumber alloc]initWithInt:1];
    NSNumber *bb = [[NSNumber alloc]initWithInt:2];
    // TODO
    [invocation setArgument:1 atIndex:2];
    // [invocation invoke];
    
    
    // 使用objc_msgSend
    /*
     每个类中都有一张方法列表去存储这个类中有的方法，当发出objc_msgSend方法时候，就会顺着列表去找这个方法是否存在，如果不存在，则向该类的父类继续查找，直到找到位置。如果始终没有找到方法，那么就会进入到消息转发机制；objc_msgSend被分为2个过程：1）在cache中寻找SEL。2）在MethodTable寻找SEL。
     */
    // ((void (*)(id, SEL))objc_msgSend)(cls, @selector(fun));
    // 定义原型
    //    void (*glt_msgsend)(id, SEL, NSString *, NSString *) = (void (*)(id, SEL, NSString *, NSString *))objc_msgSend;
    //    Test_Selector *testcls = [[Test_Selector alloc]init]
    //
    //    // 使用
    //    glt_msgsend(cls, @selector(eat:say:), @"123", @"456");
    
}

-(void)test_selecotr{
    NSLog(@"test_selecotr");
}
#pragma mark 设置标题栏
-(void)setNav{
    /* UINavigationBar遮挡view的问题  */
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // 状态栏
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;// (黑色)
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;// (白色)
    
    // 导航栏样式
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    // 导航栏背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:62/255.0 green:173/255.0 blue:176/255.0 alpha:1.0];
    // 导航栏标题字体颜色
    //    [[self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}]];
    // 导航栏左右按钮字体颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = NO;
    
    // 色彩背景样式之类的对Bar设置，文字左右按钮之类的对Item设置。
    // 每个UINavigationController的对象只包含了一个Bar，UINavigationController本身具备的item并没意义，
    // 它管理的vc具备的item才有意义（改变的是每一个对应的item）。
    // self.navigationItem;
    // self.navigationController.navigationBar;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
    item.title = @"";
    self.navigationItem.backBarButtonItem = item;
    self.title = @"第一页";
}

#pragma mark 通过拖拽关联点击事件
-(IBAction)btn_dataType:(UIButton*)sender{
    NSLog(@"btn dataType clicked");
    
    /*
     1、NSString
     NSString类对象在内存中数据是不可改变的[常量]，编译器会对该类型的变量做一定的优化
     */
    // 字符串转换数字
    NSString* i_str = @"123";
    int v =[i_str intValue];
    NSLog(@"str to int v = %i",v);
    
    // 字符串截取
    NSString *str1 = @"hello world github";
    NSString *subStr1 = [str1 substringFromIndex:0];
    NSLog(@"subStr1 = %@",subStr1);
    subStr1 = [str1 substringFromIndex:5];
    NSLog(@"subStr1 = %@",subStr1);
    // 字符串长度
    NSLog(@"len = %lu",(unsigned long)subStr1.length);
    
    /*
     NSMutableString 内容可变
     */
    NSMutableString *str2 = [[NSMutableString alloc]init];
    [str2 appendString:@"hello"];
    NSLog(@"str2 = %@",str2);
    
    /*
     NSArray
     只能存放一种类型的数据.(类型必须一致)不能很方便地动态添加数组元素、
     不能很方便地动态删除数组元素(长度固定)
     */
    NSArray *arr1 = [NSArray arrayWithObjects:@[@"hello",@"world"],nil];
    NSArray *arr2 = [NSArray arrayWithObjects:@"hello",@"world", nil];
    NSArray *arr3 = @[@"hello",@"world"];
    // 长度
    // NSUInteger 类型为无符号类型，可以简单理解为表示正整数的类型,在NSLog输出时用ld
    NSInteger count = [arr1 count] ;
    NSLog(@"count: %ld",count);
    // 遍历
    for (int i = 0; i<count; i++) {
        id obj = [arr1 objectAtIndex:i];
        NSLog(@"%@",obj);
    }
    NSLog(@"**************************");
    
    for (id obj in arr2) {
        NSLog(@"%@",obj);
    }
    NSLog(@"**************************");
    // 迭代器遍历
    NSEnumerator *it = [arr2 objectEnumerator];
    id id_v = nil;
    while (id_v = [it nextObject]) {
        NSLog(@"%@",id_v);
    }
    NSLog(@"**************************");
    // 迭代器反向遍历
    NSEnumerator *it1 = [arr2 reverseObjectEnumerator];
    id id_v1 = nil;
    while (id_v1  = [it1 nextObject]) {
        NSLog(@"%@",id_v1);
    }
    // block遍历
    [arr2 enumerateObjectsUsingBlock:^(id v,NSUInteger idx,BOOL *stop){
        // v 取出的对象
        // idx 下标
        NSLog(@"idx = %i,v = %@,stop = %d",idx,v,*stop);
        
        // 退出遍历
        if (idx == 0) {
            *stop = YES;
        }
    }];
    
    /*
     
     */
    NSMutableArray * mutableArray = [[NSMutableArray alloc]init];
    [mutableArray addObject:@"hello"];
    [mutableArray addObject:@"world"];
    [mutableArray addObject:@"test"];
    // 长度
    NSUInteger count1 = [mutableArray count];
    NSLog(@"count1 = %l",count1);
    
    /*
     NSSet
     */
    NSSet *set1 = [NSSet setWithObjects:@"hello",@"tom", nil];
    // 随机获取set值
    NSString *s = [set1 anyObject];
    NSLog(@"set anyObject %@",s);
    
    /*
     NSMutableSet
     */
    NSMutableSet *set2 = [NSMutableSet set];
    [set2 addObject:@"hello"];
    [set2 addObject:@"world"];
    
    /*
     NSDictionary 类似map
     */
    // 空字典
    NSDictionary *dic = [NSDictionary dictionary];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObject:@"hello" forKey:@"name"];
    NSLog(@"name = %@",[dic1 objectForKey:@"name"]);
    
    /*
     NSMutableDictionary
     */
    NSArray *keys = @[@"name",@"address",@"e-mail"];
    NSArray *values = @[@"Jack",@"北京",@"jack@163.com"];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithObjects:values forKeys:keys];
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"Jack",@"name",
                                 @"北京",@"address",
                                 @"jack@163.com",@"e-mail",
                                 nil];
    NSLog(@"dic2 address = %@",[dic2 objectForKey:@"address"]);
    NSLog(@"dic3 address = %@",[dic3 objectForKey:@"address"]);
    
}

/*
 NSJSONSerialization
 //判断当前数据是否可以转换成JSON
 + (BOOL)isValidJSONObject:(id)obj;
 //把数据转换成JSON，返回NSData，
 + (NSData *)dataWithJSONObject:(id)obj options:(NSJSONWritingOptions)opt error:(NSError **)error;
 //JSON解析
 + (id)JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error;
 
 */
-(void)btn_json{
    NSLog(@"btn_json clicked");
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"xcode" forKey:@"name"];
    [dic setValue:@"10.1" forKey:@"version"];
    NSArray * arr = @[@"file",@"edit",@"view"];
    [dic setValue:arr forKey:@"arr"];
    
    // 转换为json
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [NSString stringWithUTF8String:[jsonData bytes]];
    NSLog(@"jsonStr = %@",jsonStr);
    
    // 解析json
    /*
     
     NSJSONReadingMutableContainers：返回可变容器，NSMutableDictionary或NSMutableArray。
     NSJSONReadingMutableLeaves：返回的JSON对象中字符串的值为NSMutableString
     NSJSONReadingAllowFragments：允许JSON字符串最外层既不是NSArray也不是NSDictionary，但必须是有效的JSON Fragment。例如使用这个选项可以解析 @“123” 这样的字符串。
     
     */
    /*
         {
             "name": "hello",
             "age": 11
         }
     */
    id resString = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    // 取值
    NSArray *arr_res =  resString[@"arr"];
    NSLog(@"arr_res = %@",arr_res);
    
    NSString *name_res = resString[@"name"];
    NSLog(@"name_res = %@",name_res);
    
}

-(void) btnClicked{
    NSString *str_name =_name.text;
    NSString *str_email = _email.text;
    NSLog(@"name = %@, email = %@",str_name,str_email);
    
    NSString *msg  = [@"" stringByAppendingFormat:@"%@,%@",str_name, str_email];
    
    [self showMsg:msg];
    
    [self sendDataToServer];
}

#pragma mark sendDataToServer
-(void)sendDataToServer{
    NSString *httpUrl = @"https://www.baidu.com/";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:httpUrl]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError || data == nil) {
            NSLog(@"网络繁忙，请稍后尝试");
        }else{
            NSLog(@"data: %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        }
    }];
}

#pragma mark 跳转下一页
-(void) btn_next_Clicked{
    NSLog(@"btn_next_Clicked %@",self.navigationController);
    
    // NextViewController 创建的时候 同时创建了同名的 xib文件 系统自自动去找xib文件 绘制界面
    // 可以修改xib文件的file owner
    //    NextViewController *nc = [[NextViewController alloc]init];
    //    [self.navigationController pushViewController:nc animated:YES];//跳转到下一页面
    
    
    //    NextViewController *next_page = [[NextViewController alloc]initWithNibName:@"Test_Next_Page" bundle:nil];
    //
    //    [self.navigationController pushViewController:next_page animated:YES];//跳转到下一页面
    
    
    // 获取xib 系统实现xib描述的view
    /*
     name：nib文件的名称
     
     owner：指定name参数所指代的nib文件的File's Owner
     
     options：当nib文件开始时，需要的数据
     */
    NSArray *apparray1= [[NSBundle mainBundle]loadNibNamed:@"aaaaa" owner:nil options:nil];
    NSLog(@"--------views = %@",apparray1);
    
    
    NSArray *apparray= [[NSBundle mainBundle]loadNibNamed:@"Test_Next_Page" owner:nil options:nil];
    NSLog(@"views = %@",apparray);
    NSLog(@"views = %@",apparray[0]);
    NextViewController *nc  = [[NextViewController alloc]init];
    nc.view = apparray[0];
    [self.navigationController pushViewController:nc animated:YES];//跳转到下一页面
    // 隐藏导航栏
    // self.navigationController.navigationBar.hidden = YES;
    
    //self presentedViewController
}

-(void)showMsg:(NSString *)msg{
    UILabel *ul = [[UILabel alloc]init];
    ul.textAlignment  = NSTextAlignmentCenter;
    ul.text = msg;
    ul.backgroundColor = [UIColor lightGrayColor];
    ul.frame = CGRectMake((SCREEN_WIDTH-TOAST_WIDTH)/2, (SCREEN_HEIGHT-TOAST_HEIGHT)/2, TOAST_WIDTH, TOAST_HEIGHT);
    ul.alpha = 1.0;
    [self.view addSubview:ul];
    [UIView animateWithDuration:TOAST_DURATION animations:^(){
        ul.alpha = 0.0;
    }completion:^(BOOL finished){
        [ul removeFromSuperview];
    }];
}
-(void)loadView{
    [super loadView];
    NSLog(@"ViewController#loadView");
}

- (void)viewDidUnload{
    [super viewDidUnload];
    NSLog(@"ViewController#viewDidUnload");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 隐藏导航栏
    // self.navigationController.navigationBarHidden = YES;
    NSLog(@"ViewController#viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"ViewController#viewDidAppear");
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSLog(@"ViewController#viewWillDisappear");
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"ViewController#viewDidDisappear");
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // 内存不足
    // UIScreen.mainScreen.bounds
}
@end
