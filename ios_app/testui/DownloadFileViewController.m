#import "DownloadFileViewController.h"
@interface DownloadFileViewController ()
@property(nonatomic,strong)UIButton *btn_download;
@property(nonatomic,strong)UILabel * toast_v;

@end

@implementation DownloadFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btn_download = [self.view viewWithTag:1];
    [_btn_download addTarget:self action:@selector(btn_download_clicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btn_download_clicked{
    // 禁用btn 防止再次点击
    _btn_download.enabled = NO;
    
    // 构造toast
    if (_toast_v == nil) {
        _toast_v = [self toast:@"下载中......"];
    }
    
    // 弹出label 动画
    [UIView animateWithDuration:2 animations:^{
        _toast_v.alpha = 0.6;
    } completion:^(BOOL finished) {
        NSLog(@"in animate completion ");
        [UIView animateWithDuration:2.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            _toast_v.alpha = 0.0;
        } completion:^(BOOL finished) {
            NSLog(@"out animate completion ");
            [_toast_v removeFromSuperview];
            _toast_v = nil;
            _btn_download.enabled = YES;
        }];
    }];
    
    [self.view addSubview:_toast_v];
   
    [self download];
}

-(void)download{
    NSString * url = @"https://ai.baidu.com/download?sdkId=31";
    
}


/**
 弹出toast
 */
-(UILabel*)toast:(NSString*)msg{
    UILabel * toast_v = [[UILabel alloc]init];
    int toast_v_w = 150;
    int toast_v_h = 30;
    CGFloat x = (self.view.frame.size.width - toast_v_w)/2;
    CGFloat y = (self.view.frame.size.height - toast_v_h)/2;
    [toast_v setFrame:CGRectMake(x, y, toast_v_w, toast_v_h)];
    [toast_v setBackgroundColor:[UIColor blackColor]];
    [toast_v setText:msg];
    [toast_v setTextColor:[UIColor whiteColor]];
    [toast_v setTextAlignment:NSTextAlignmentCenter];
    // 透明度
    toast_v.alpha = 0.0;
    // 设置圆角半径
    toast_v.layer.cornerRadius = 5;
    // 圆角弧以外的部分截掉 就称为圆角形状
    toast_v.layer.masksToBounds = YES;
    return toast_v;
}



@end
