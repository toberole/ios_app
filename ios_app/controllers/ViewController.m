#import "ViewController.h"

#import "NextViewController.h"
#import "GetSetBean.h"
#import "Test_Selector.h"
#import "NetViewController.h"
#import "StatusBarNavigationBarViewController.h"
#import "UITableView_ViewController.h"
#import "UITableViewViewController.h"
#import "OCBaseViewController.h"
#import "APPUIViewController.h"
#import "Test1_ViewController.h"
#import "TestAnimationViewController.h"
#import "APPInfosViewController.h"
#import "DownloadFileViewController.h"
#import "LoginViewController.h"
#import "APPIMGViewController.h"
#import "APPLauoutViewController.h"
#import "APPTaskViewController.h"
#import "APPUIScrollViewController.h"
#import "APPViewTouchViewController.h"
#import "APPUIScrollViewController_Demo.h"
#import "APPTableViewController.h"
#import "APPTableViewController_1.h"
#import "APPTableViewController_2.h"
#import "APPTableViewController_3.h"
#import "APPAutoResizingDemoViewController.h"
#import "AudioRecorderViewController.h"
#import "BeanOC.h"
#import "FileViewController.h"

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
@property (nonatomic,strong)UIButton *uitest_btn;
@property(nonatomic,strong)UIButton*btn_file;

// 测试懒加载
// Xcode自动生成 "."语法会触发set和get
// 对应的set方法：- (void)setHeight:(NSString *)data;
// get方法：- (int)data;
@property(nonatomic,copy)NSString *data;

@end

@implementation ViewController

// 懒加载 自己提供了get方法 xcode就不会自动生成
-(NSString*)data{
    NSLog(@"懒加载");
    if (_data == nil) {
        _data = @"懒加载 ......";
    }
    
    return _data;
}

// loadview -> viewDidLoad -> viewWillAppear -> viewDidAppear
/*
 loadView什么时候被调用？
 每次访问UIViewController的view(比如controller.view、self.view)而且view为nil，loadView方法就会被调用。
 有什么作用？
 loadView方法是用来负责创建UIViewController的view
 默认实现是怎样的？
 a、它会先去查找与UIViewController相关联的xib文件，通过加载xib文件来创建UIViewController的view
 如果在初始化UIViewController指定了xib文件名，就会根据传入的xib文件名加载对应的xib文件
 [[MJViewController alloc] initWithNibName:@"MJViewController" bundle:nil];
 b、如果没有明显地传xib文件名，就会加载跟UIViewController同名的xib文件
 [[MJViewController alloc] init]; // 加载MJViewController.xib
 c、如果没有找到相关联的xib文件，就会创建一个空白的UIView，然后赋值给UIViewController的view属性，大致如下
 self.view = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
 
 注意：
 在某些情况下，xib不是那么地灵活，所以有时候我们想通过代码来创建UIView，比如：
 self.view = [[[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
 如果想通过代码来创建UIViewController的view，就要重写loadView方法，并且不需要调用[super loadView]，因为若没有xib文件，[super loadView]默认会创建一个空白的UIView。我们既然要通过代码来自定义UIView，那么就没必要事先创建一个空白的UIView，以节省不必要的开销。正确的做法应该是这样：
 - (void)loadView {
 self.view = [[[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
 }
 
 
 viewDidLoad 什么时候被调用？
 无论是通过xib文件还是重写loadView方法创建UIViewController的view，在view创建完毕后，最终都会调用viewDidLoad方法
 有什么作用？
 一般我们会在这里做界面上的初始化操作
 
 */
+ (void)load{
    [super load];
    NSLog(@"ViewController#load");
}

-(void)loadView{
    [super loadView];
    NSLog(@"ViewController#loadView");
}
/**不允许旋转*/
- (BOOL)shouldAutorotat{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"ViewController navigationItem = %@",self.navigationItem);
    // 定时器
    // [self useTimer];
    
    // 设置导航栏
    [self setNav];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSLog(@"bundle = %@",bundle);
    NSLog(@"bundle.bundlePath = %@",bundle.bundlePath);
    
    // 懒加载 self.data触发get方法 data
    NSLog(@"懒加载 data = %@",self.data);
    
    GetSetBean * bean = [[GetSetBean alloc]init];
    bean.count = 100;
    NSLog(@"bean.count = %d",bean.count);
    
    
    // plist
    // 写法1
    // [[NSBundle mainBundle]pathForResource:@"extras" ofType:@"plist"];
    // 写法2
    NSString * path = [[NSBundle mainBundle]pathForResource:@"p1" ofType:@"plist"];
    // 解析plist
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"plist count = %d",arr.count);
    NSLog(@"plist firstObject data = %@",[arr firstObject]);
    NSLog(@"plist lastObject data = %@",[arr lastObject]);
    
    
    // [self file_op];
    // [self file_op1];
    [self file_op2];
    
    NSLog(@"ViewController#viewDidLoad");
    //    UIButton *btn = [[UIButton alloc]init];
    //    [btn setTitle:@"new page" forState:UIControlStateNormal];
    //    btn.frame = CGRectMake(0, 0, 100, 100);
    //    [self.view addSubview:btn];
    //    [btn addTarget:self action:@selector(btn_next_Clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self initViews];
    
    
    [self test];
}

-(void)test{
    BeanOC *bean = [[BeanOC alloc]init];
    [bean setX:1];
    BeanOC *bean1 = [[BeanOC alloc]init];
    NSLog(@"x = %d",[bean1 x]);
}

-(void)useTimer{
    // 定时器使用
    // (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(task_time) userInfo:nil repeats:YES];
    // 暂停销毁timer 不能再继续使用 需要重新创建新的才能使用
    // [timer invalidate];
    // 设置 timer优先级
    NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
    // NSRunLoopCommonModes UI级别
    // NSDefaultRunLoopMode 低级别
    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
}

-(void)task_time{
    NSLog(@"timer ......");
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
    _uitest_btn = [self.view viewWithTag:13];
    self.btn_file =[self.view viewWithTag:14];
    
    [self.btn_file addTarget:self  action:@selector(btn_file_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    [_uitest_btn addTarget:self action:@selector(uitest_btn_clicked) forControlEvents:  UIControlEventTouchUpInside];
    
}

-(void)uitest_btn_clicked{
    NSLog(@"uitest_btn_clicked");
    //        APPUIViewController *vc = [[APPUIViewController alloc]init];
    //        [self.navigationController pushViewController:vc animated:YES];
    
    //    Test1_ViewController *vc = [[Test1_ViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    //    TestAnimationViewController *vc = [[TestAnimationViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    //    APPInfosViewController *vc = [[APPInfosViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    //    DownloadFileViewController *vc = [[DownloadFileViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    
    //    LoginViewController *vc = [[LoginViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    //    APPIMGViewController *vc = [[APPIMGViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    //    APPLauoutViewController *vc = [[APPLauoutViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    //    APPTaskViewController *vc = [[APPTaskViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    
    //    APPUIScrollViewController *vc = [[APPUIScrollViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    //    APPViewTouchViewController *vc = [[APPViewTouchViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    
    //    APPUIScrollViewController_Demo *vc = [[APPUIScrollViewController_Demo alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    //    APPTableViewController *vc = [[APPTableViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    //    APPTableViewController_1 *vc = [[APPTableViewController_1 alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    //    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"APPTableViewController_2" bundle:nil];
    //    APPTableViewController_2 *vc = [storyboard instantiateViewControllerWithIdentifier:@"APPTableViewController_2"];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    //    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"APPTableViewController_3" bundle:nil];
    //    APPTableViewController_3 *vc = [storyboard instantiateViewControllerWithIdentifier:@"APPTableViewController_3"];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    //    APPAutoResizingDemoViewController *vc = [[APPAutoResizingDemoViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    AudioRecorderViewController *vc = [[AudioRecorderViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//NSInputStream;
//NSOutputStream;
#pragma mark NSFileHandle
-(void)file_op2{
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *f = [doc stringByAppendingPathComponent:@"t.txt"];
    if (![[NSFileManager defaultManager]fileExistsAtPath:f]) {
        // 不存在就创建文件
        [[NSFileManager defaultManager]createFileAtPath:f contents:nil attributes:nil];
    }
    NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:f];
    NSString * d = @"测试数据";
    [fh writeData:[d dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void)saveFile:(NSData *)data {
    //保存文件的路径
    NSString *filePath = @"//";
    //如果文件不存在，返回的是nil
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    //判断文件存不存在
    if (fileHandle == nil) {
        //如果文件不存在，会自动创建
        [data writeToFile:filePath atomically:YES];
    }else {
        //让offset指向文件的末尾
        [fileHandle seekToEndOfFile];
        //在文件的末尾再继续写入文件
        [fileHandle writeData:data];
        //关闭文件
        [fileHandle closeFile];
    }
}


#pragma mark 文件操作 1
-(void)file_op1{
    // 程序里面的资源都在mainBundle
    NSString * aaaa_path = [[NSBundle mainBundle]pathForResource:@"test_file/aaaa" ofType:@"txt"];
    NSLog(@"aaaa_path = %@",aaaa_path);
    NSString * data = [[NSString alloc]initWithContentsOfFile:aaaa_path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"data = %@",data);
    
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString * aaaa_file = [doc stringByAppendingPathComponent:@"test_file/aaaa.txt"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:aaaa_path]) {
        NSLog(@"aaaa_file Exists");
    }else{
        NSLog(@"aaaa_file not Exists");
    }
}

/*
 文件管理器（NSFileManager/FileManager）：此类主要是对文件进行的操作（创建/删除/改名等）以及文件信息的获取。
 文件连接器（NSFileHandle/FileHandle）：此类主要是对文件内容进行读取和写入操作。
 一、沙盒以及组成部分
 iOS应用程序只能对自己创建的文件系统读取文件，这个"独立","封闭","安全"的空间，称之为沙盒。
 
 1.1、Home目录(应用程序包)
 整个应用程序各文档所在的目录,包含了所有的资源文件和可执行文件
 1.2、Documents
 保存应用运行时生成的需要持久化的数据，iTunes同步设备时会备份该目录
 需要保存由"应用程序本身"产生的文件或者数据，例如: 游戏进度，涂鸦软件的绘图
 目录中的文件会被自动保存在 iCloud
 此目录下不要保存从网络上下载的文件，否则会无法上架!
 1.3、tmp
 保存应用运行时所需要的临时数据或文件，"后续不需要使用"，使用完毕后再将相应的文件从该目录删除。
 应用没有运行，系统也可能会清除该目录下的文件
 iTunes不会同步备份该目录
 重新启动手机, tmp 目录会被清空
 系统磁盘空间不足时，系统也会自动清理
 1.4、Library/Cache
 保存应用运行时生成的需要持久化的数据，iTunes同步设备时不备份该目录。一般存放体积大、不需要备份的非重要数据
 保存临时文件,"后续需要使用"，例如: 缓存的图片，离线数据（地图数据）
 系统不会清理 cache 目录中的文件
 就要求程序开发时, "必须提供 cache 目录的清理解决方案"
 1.5、Library/Preference
 保存应用的所有偏好设置，IOS的Settings应用会在该目录中查找应用的设置信息。iTunes
 用户偏好，使用 NSUserDefault 直接读写！
 如果想要数据及时写入硬盘，还需要调用一个同步方法 synchronize()
 1.6.程序.app，与另三个路径的父路径不同
 这是应用程序的程序包目录，包含应用程序的本身。由于应用程序必须经过签名，所以您在运行时不能对这个目录中的内容进行修改，否则可能会使应用程序无法启动
 */

#pragma mark 文件操作
-(void)file_op{
    // NSHomeDirectory()是应用程序目录的路径
    // 在该文件目录下有三个文件夹:Documents、Library、temp以及一个.app包[存放应用程序的源文件，包括资源文件和可执行文件]
    NSString * homeDir = NSHomeDirectory();
    NSLog(@"homeDir = %@",homeDir);
    
    // // 获取Documents目录路径
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"docDir = %@",docDir);
    
    // 获取Library的目录路径
    NSString *libDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"libDir = %@",libDir);
    
    // 获取Caches目录路径
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"cachesDir = %@",cachesDir);
    
    // 获取tmp目录路径
    NSString *tmpDir =  NSTemporaryDirectory();
    NSLog(@"tmpDir = %@",tmpDir);
    
    // 获取resource路径
    NSString *resourcePath =  [[NSBundle mainBundle] pathForResource:@"abc" ofType:@"jpg"];
    NSLog(@"resourcePath = %@",resourcePath);
    
    /*
     Documents和Caches文件夹区别
     如果做个记事本的app，那么用户写了东西，总要把东西存起来。那么这个文件则是用户自行生成的，就放在documents文件夹里面。
     如果需要和服务器配合，经常从服务器下载东西，展示给用户看。那么这些下载下来的东西就放在library/caches。
     */
    
    // 创建文件夹
    // 在NSDocumentDirectory下面
    NSString * documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // test-xxx 文件夹
    NSString * test_xxx = [documentsDir stringByAppendingPathComponent:@"test_xxx"];
    // 判断是否存在
    BOOL isExit;
    // 是否是文件夹
    BOOL isDir;
    isExit = [[NSFileManager defaultManager] fileExistsAtPath:test_xxx isDirectory:&isDir];
    NSLog(@"isExit = %i,isDir = %i",isExit,isDir);
    if (!isExit || !isDir) {
        [[NSFileManager defaultManager]createDirectoryAtPath:test_xxx withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 删除cache下面的文件夹
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    NSString * deleted_dir = [cacheDir stringByAppendingPathComponent:@"test_xxx"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:deleted_dir]) {
        NSError *error;
        BOOL isSuc = [fileManager removeItemAtPath:deleted_dir error:&error];
        if (!isSuc) {
            NSLog(@"removeItemAtPath error = %@",error);
        }else{
            NSLog(@"删除成功!!!");
        }
    }
    
    // 移动文件夹 重命名文件夹是通过移动文件夹实现的
    // 1 创建一个文件夹
    NSString * documentsDir_Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * create_dir = [documentsDir_Path stringByAppendingPathComponent:@"create_dir"];
    [fileManager createDirectoryAtPath:create_dir withIntermediateDirectories:YES attributes:nil error:nil];
    NSString * move_dir = [documentsDir_Path stringByAppendingPathComponent:@"move_dir"];
    // 2 移动
    [fileManager moveItemAtPath:create_dir toPath:move_dir error:nil];
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

# pragma mark FileViewController 文件操作
-(void)btn_file_clicked{
    FileViewController*nc = [[FileViewController alloc]init];
    [self.navigationController pushViewController:nc animated:YES];//跳转到下一页面
    
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
