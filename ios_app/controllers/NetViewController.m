#import "NetViewController.h"
#import "Constant.h"

@interface NetViewController ()

@property(nonatomic,strong) UILabel *showRes;
@property(nonatomic,strong) UITextField *txt_name;
@property(nonatomic,strong) UITextField *txt_age;
@property(nonatomic,strong) UIButton *btn_request;

@end

@implementation NetViewController

/* 通过xib构建界面没有回调 */
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad ......");
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews ......");
}

- (void)viewWillAppear:(BOOL)animated{
     NSLog(@"viewWillAppear ......");
    // 解决navigationBar遮挡视图的问题
    // IOS7之后ViewController的View是全屏的
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.title = @"NETPAGE";
    [self initViews];
}

-(void)initViews{
    NSLog(@"initViews ......");
    
    NSInteger count = [[self.view subviews]count];
    NSLog(@"initViews count = %ld ......",count);
    
    _txt_name = [self.view viewWithTag:0];
    NSLog(@"_txt_name: %@",_txt_name);
    
    _txt_age = [self.view viewWithTag:1];
    _btn_request = [self.view viewWithTag:2];
    _showRes = [self.view viewWithTag:4];
    
    [_btn_request addTarget:self action:@selector(request_net) forControlEvents:UIControlEventTouchUpInside];
}

-(void)request_net{
    NSLog(@"request_net ......");
    
    // [self request1];
    // [self request2];
    [self request3];
}

#pragma mark GCD使用
/*
 GCD Queue 分为三种：
 
 1，The main queue ：主队列，主线程就是在个队列中。
 
 2，Global queues ： 全局并发队列。
 
 3，用户队列:是用函数 dispatch_queue_create 创建的自定义队列
 
 GCD 核心: 队列和任务
 队列: 串行队列和并行队列.
 任务: block块 和 函数
 程序本身有一个串行队列(主线程).
 有4个并行队列(优先级区别).
 自定义一个串行队列
 自定义并行队列.
 
 同步（sync） 和 异步（async） 的主要区别在于会不会阻塞当前线程，直到 Block 中的任务执行完毕！
 如果是同步（sync） 操作，它会阻塞当前线程并等待 Block 中的任务执行完毕，然后当前线程才会继续往下运行。
 如果是异步（async）操作，当前线程会直接往下执行，它不会阻塞当前线程。
 
 队列：用于存放任务。一共有两种队列， 串行队列 和 并行队列。
 
 串行队列: 放到串行队列的任务，GCD 会 FIFO（先进先出） 地取出来一个，执行一个，然后取下一个，这样一个一个的执行。
 
 并行队列: 放到并行队列的任务，GCD 也会 FIFO的取出来，但不同的是，它取出来一个就会放到别的线程，
 然后再取出来一个又放到另一个的线程。这样由于取的动作很快，忽略不计，看起来，所有的任务都是一起执行的。
 不过需要注意，GCD 会根据系统资源控制并行的数量，所以如果任务很多，它并不会让所有任务同时执行。
 
 */
// dispatch
-(void)request3{
    // dispatch_async 异步
    dispatch_async(dispatch_get_main_queue(), ^{
        // UI线程
        NSLog(@"dispatch_async NSThread.currentThread ... %@",NSThread.currentThread);
    });
    // 死锁
    // 死锁原因
    //1:dispatch_sync在等待block语句执行完成，而block语句需要在主线程里执行，所以dispatch_sync如果在主线程调用就会造成死锁
    //2:dispatch_sync是同步的，本身就会阻塞当前线程，也即主线程。而又往主线程里塞进去一个block，所以就会发生死锁。
    //});
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"dispatch_sync NSThread.currentThread ... %@",NSThread.currentThread);
//    });
    
    
    NSLog(@"dispatch_async after");
    
    // 创建用户队列
    dispatch_queue_attr_t attr = DISPATCH_QUEUE_SERIAL;
    dispatch_queue_t queue_SERIAL = dispatch_queue_create("queue_SERIAL",attr);
    dispatch_async(queue_SERIAL, ^{
        NSLog(@"queue_SERIAL");
    });
    
    attr = DISPATCH_QUEUE_CONCURRENT;
    dispatch_queue_t queue_CONCURRENT = dispatch_queue_create("queue_CONCURRENT",attr);
    dispatch_async(queue_CONCURRENT, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"queue_CONCURRENT %@",NSThread.currentThread);
    });
    dispatch_async(queue_CONCURRENT, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"queue_CONCURRENT %@",NSThread.currentThread);
    });
    dispatch_async(queue_CONCURRENT, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"queue_CONCURRENT %@",NSThread.currentThread);
    });
    
}

#pragma mark request2 NSOperation
/*
 一个NSOperation对象就是一个任务(一段功能代码),本身和线程没有关系(不能开子线程).
 NSOperation 只是一个抽象类，所以不能封装任务。但它有 2 个子类用于封装任务。
 分别是：NSInvocationOperation 和 NSBlockOperation 。
 创一个 Operation 后，需要调用 start 方法来启动任务，它会默认在当前队列同步执行。当然你也可以在中途取消一个任务，只需要调用其 cancel 方法可。
 */
// NSInvocationOperation
-(void)request2{
    NSLog(@"request2 NSThread.currentThread = %@",NSThread.currentThread);
    // NSInvocationOperation 创建任务
    NSInvocationOperation *invocation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(handleFunc) object:nil];
    
    // NSBlockOperation 创建任务
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation NSThread.currentThread = %@",NSThread.currentThread);
        
        NSLog(@"NSBlockOperation ......");
    }];
    
    // 创建NSOperationQueue
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    // 设置最大并发量 用来控制一个特定队列中可以有多少个操作同时参与并发执行。
    queue.maxConcurrentOperationCount = 10;
    [queue addOperation:invocation];
    [queue addOperation:blockOperation];
}

-(void)handleFunc{
    NSLog(@"handleFunc NSThread.currentThread = %@",NSThread.currentThread);
    
    NSLog(@"handleFunc ......");
}

#pragma mark request1 NSThread
-(void)request1{
    NSThread *thread = [[NSThread alloc]initWithBlock:^(){
        NSLog(@"request1 ......");
        NSURL *url = [NSURL URLWithString:url2];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        // NSURLConnection 不建议使用，用NSURLSession替代
        //        [NSURLConnection sendAsynchronousRequest:request
        //                                           queue:queue
        //                               completionHandler:^(NSURLResponse * response, NSData *data, NSError *connectionError) {
        //                                   NSLog(@"length:%lu",(unsigned long)data.length);
        //                               }];
        
        NSURLSessionDataTask *task =  [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSString *d = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"d = %@",d);
            
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSString *name = [jsonObject valueForKey:@"name"];
            NSLog(@"name = %@",name);
            NSNumber *age = [jsonObject valueForKey:@"age"];
            NSLog(@"age = %ld",[age integerValue]);
            
            // 上界面 self指 NetViewController
            // 方法一
            // [self performSelectorOnMainThread:@selector(updateUI:) withObject:name waitUntilDone:false];
            // 方法二
            dispatch_sync(dispatch_get_main_queue(),^{
                [self->_showRes setText:name];
            });
        }];
        
        [task resume];
    }];
    
    [thread start];
}

-(void)updateUI:(NSString *) name{
    NSLog(@"updateUI");
    [_showRes setText:name];
}




@end
