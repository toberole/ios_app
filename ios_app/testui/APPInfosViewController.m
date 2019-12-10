//
//  APPInfosViewController.m
//  ios_app
//
//  Created by Apple on 2019/12/10.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import "APPInfosViewController.h"
#import "../bean/APPInfo.h"


NSString * data_url = @"https://raw.githubusercontent.com/toberole/jni_xxxx_demo/master/test_data/data/appsinfo.txt";

int col_count = 3;
int cell_w = 80;
int img_w = 40;

int s_w = 0;
int s_h = 0;

int BTN_V_ITEM_TAG_BASE = 1000;
int IMG_V_ITEM_TAG_BASE = 2000;

@interface APPInfosViewController ()<NSURLSessionDownloadDelegate>

@property(nonatomic,strong) NSMutableArray *appinfos;

@end

@implementation APPInfosViewController

// 懒加载方式
//-(NSArray *)apps{
//    if (nil==_apps) {
//
//    }
//
//    return _apps;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"APPInfosViewController#viewDidLoad");
    s_w = self.view.frame.size.width;
    s_h = self.view.frame.size.height;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSLog(@"w = %i,h= %i",s_w,s_h);
    [self initData];
}
/*
 JSon解析
 NSURLSession
 NSDictionary 2 bean
 */
-(void)initData{
    NSLog(@"initData");
    dispatch_queue_t queue = dispatch_queue_create("app_queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        // 加载数据
        NSURL *url = [NSURL URLWithString:data_url];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"data = %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            NSArray * apps = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"apps ------ %@",apps);
            _appinfos = [[NSMutableArray alloc]init];
            for (NSDictionary *dict in apps) {
                APPInfo *info = [[APPInfo alloc]init];
                [info setValuesForKeysWithDictionary:dict];
                NSLog(@"info: %@",info);
                [_appinfos addObject:info];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                int n = [_appinfos count];
                NSLog(@"appinfos count = %i",n);
                int gap = (s_w - col_count * cell_w)/(col_count+1);
                NSLog(@"gap = %i",gap);
                
                for (int i = 0;i < n;i++) {
                    UIView * v = [[UIView alloc]init];
                    [v setBackgroundColor:[UIColor grayColor]];
                    CGFloat x = (i % col_count+1) * gap+ i%col_count*cell_w;
                    CGFloat y = (i/col_count)*gap + (i/col_count)*cell_w + 80;
                    CGFloat w = cell_w;
                    CGFloat h = cell_w;
                    NSLog(@"x = %lf,y = %lf,w = %lf,h = %lf",x,y,w,h);
                    // UIView 一定要设置Fream属性 否则就不可见
                    [v setFrame:CGRectMake(x, y, w, h)];
                    [self.view addSubview:v];
                    
                    // 添加UIImg
                    UIImageView *img_v = [[UIImageView alloc]init];
                    img_v.tag = IMG_V_ITEM_TAG_BASE+i;
                    [img_v setBackgroundColor:[UIColor greenColor]];
                    CGFloat img_v_x = (cell_w-img_w)*0.5;
                    CGFloat img_v_y = 0;
                    CGFloat img_v_w = img_w;
                    CGFloat img_v_h = img_w;
                    [img_v setFrame:CGRectMake(img_v_x, img_v_y, img_v_w, img_v_h)];
                    [v addSubview:img_v];
                    
                    
                    //添加UILabel
                    UILabel *lab = [[UILabel alloc]init];
                    [lab setBackgroundColor:[UIColor blueColor]];
                    CGFloat lab_x = 0;
                    CGFloat lab_y = img_w;
                    CGFloat lab_w = cell_w;
                    CGFloat lab_h = 20;
                    [lab setFrame:CGRectMake(lab_x, lab_y, lab_w, lab_h)];
                    [lab setTextAlignment:NSTextAlignmentCenter];
                    [lab setText:((APPInfo*)_appinfos[i]).name];
                    [v addSubview:lab];
                    
                    //添加UIButton
                    UIButton *btn = [[UIButton alloc]init];
                    [btn setBackgroundColor:[UIColor redColor]];
                    CGFloat btn_x = 0;
                    CGFloat btn_y = img_w+lab_h;
                    CGFloat btn_w = cell_w;
                    CGFloat btn_h = 20;
                    [btn setTitle:@"点击下载" forState:UIControlStateNormal];
                    [btn setFrame:CGRectMake(btn_x, btn_y, btn_w, btn_h)];
                    btn.tag = i+BTN_V_ITEM_TAG_BASE;
                    [btn addTarget:self action:@selector(item_btn_clicked:) forControlEvents:UIControlEventTouchUpInside];
                    [v addSubview:btn];
                }
                
                // 异步加载图片
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    for (int i = 0;i<n; i++) {
//                        // 下载图片
//                        NSURL *url_img = [[NSURL alloc]initWithString:((APPInfo*)_appinfos[i]).img];
//                        NSURLSessionTask *task = [[NSURLSession sharedSession]dataTaskWithURL:url_img completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                            if (!error) {
//                                NSLog(@"加载图片成功");
//                                dispatch_async(dispatch_get_main_queue(), ^{
//                                    UIImageView *img_v = [self.view viewWithTag:(i+100)];
//                                    NSLog(@"tag = %d",img_v.tag);
//                                    [img_v setImage:[UIImage imageNamed:@"0.jpg"]];
//                                    [UIImage imageWithData:<#(nonnull NSData *)#>]
//                                    img_v.backgroundColor = [UIColor redColor];
//                                });
//                            }
//                        }];
//                        [task resume];
//                    }
//                });
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    for (int i = 0;i<n; i++) {
                        // 下载图片
                        NSURL * url = [NSURL URLWithString:((APPInfo*)_appinfos[i]).img];
                        NSData * data = [[NSData alloc]initWithContentsOfURL:url];
                        if (data) {
                            NSLog(@"加载图片成功");
                            dispatch_async(dispatch_get_main_queue(), ^{
                                UIImageView *img_v = [self.view viewWithTag:(i+IMG_V_ITEM_TAG_BASE)];
                                [img_v setImage:[UIImage imageWithData:data]];
                            });
                        }
                    }
                });
            });
        }];
        
        [task resume];
    });
}

-(void)item_btn_clicked:(UIButton *)btn{
    NSLog(@"btn %ld clicked",btn.tag);
    int tag = btn.tag;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 下载文件
         NSString *url_str = ((APPInfo*)_appinfos[tag - BTN_V_ITEM_TAG_BASE]).apk;
//        NSString *url_str = data_url;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url_str]];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        NSURLSessionDownloadTask *dataTask = [session downloadTaskWithRequest:request];
        [dataTask resume];
    });
}

/**
 * 写数据
 * @param bytesWritten 本次写入数据大小
 * @param totalBytesWritten 下载数据总大小
 * @param totalBytesExpectedToWrite 文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    //1.文件下载进度
    NSLog(@"bytesWritten: %lld",bytesWritten);
    NSLog(@"totalBytesWritten: %lld",totalBytesWritten);
    NSLog(@"totalBytesExpectedToWrite: %lld",totalBytesExpectedToWrite);
}
/**
 * 恢复下载
 * @param fileOffset 恢复从哪里位置下载
 * @param expectedTotalBytes 文件总大小
 */
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}
/**
 * 下载完成
 * @param location 文件临时存储路径
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
    NSLog(@"fullPath = %@",fullPath);
}

/**
 * 请求结束
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error) {
        NSLog(@"error = %@",error);
        return;
    }
    NSLog(@"didComplete");
}

@end
