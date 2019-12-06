#import "UITableView_ViewController.h"
#import "../constant/Constant.h"


@interface UITableView_ViewController ()<UITableViewDataSource>
@property(nonatomic,strong)UITableView *uiTabView;

@property(nonatomic,strong)NSArray *data_test;
@end

@implementation UITableView_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"UITableView_ViewController#viewDidLoad");
}

- (void)viewWillLayoutSubview{
    [super viewWillLayoutSubviews];
    NSLog(@"UITableView_ViewController#viewWillLayoutSubview");
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"UITableView_ViewController#viewDidLayoutSubviews");
    
    _uiTabView = (UITableView *)[self.view viewWithTag:0];
    NSLog(@"UITableView_ViewController#viewDidLayoutSubviews _uiTabView = %@",_uiTabView);
    
    [self initData];
}

-(void)initData{
    dispatch_queue_t queue = dispatch_queue_create("initData", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSString * url = [NSURL URLWithString:url3];
        NSURLSessionDataTask * task = [[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // [self updateUI:data];
            });
        }];
        [task resume];
    });
    
    dispatch_async(queue, ^{
        NSString * url = [NSURL URLWithString:url4];
        NSURLSessionDataTask * task = [[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
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
    
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary *dict in arr) {
        NSLog(@"name = %@",dict[@"name"]);
        NSLog(@"age = %@",dict[@"age"]);
    }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_data_test) {
       return [_data_test count];
    }
    
    return 0;
}

@end
