#import "APPUIScrollViewController.h"

@interface APPUIScrollViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *sv;
@property (strong, nonatomic) IBOutlet UIImageView *iv;

@end

/**
    UIScrollView
    滚动、缩放[一次只能缩放一个控件]
 */
@implementation APPUIScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    NSLog(@"APPUIScrollViewController#viewDidLoad");
    [self initViews];
}

-(void)initViews{
    NSLog(@"UIScreen width = %f",[[UIScreen mainScreen]bounds].size.width);
    NSLog(@"UIScreen height = %f",[[UIScreen mainScreen]bounds].size.height);
    // 设置UIscrollView内容的实际大小[UIScrollView 会根据内容的大小 控制实际的滚动效果]
    _sv.contentSize = CGSizeMake(1920, 1200);
    
    // 设置代理
    _sv.delegate = self;
    // 设置缩放比例额
    [_sv setMaximumZoomScale:3];
    [_sv setMinimumZoomScale:0.5];
    NSLog(@"_sv = %@",_sv);
}


/**
 缩放的回调
 @param scrollView scrollview
 @return 被操作的view
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    NSLog(@"viewForZoomingInScrollView ......");
    NSLog(@"scrollView = %@",scrollView);
    return _iv;
}


@end
