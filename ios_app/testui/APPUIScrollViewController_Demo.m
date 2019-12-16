#import "APPUIScrollViewController_Demo.h"


/*
 contentSize：内容(content)的尺寸
 
 contentInset：内容的padding，给内容四周加边距
 
 contentOffset：当前scrollView的左上角相对于内容左上角的偏移offset
 
 
 
 */


@interface APPUIScrollViewController_Demo ()
@property (strong, nonatomic) IBOutlet UIButton *btn_footer;
@property (strong, nonatomic) IBOutlet UIScrollView *sv;
@property (strong, nonatomic) IBOutlet UIButton *btn_header;

@end

@implementation APPUIScrollViewController_Demo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self initViews];
}


-(void)initViews{
    // 设置scrollview的contentsize 小技巧[最后一个view的MaxX 或者 MaxY]
    // 0 表示水平不滑动
    // MaxX = x + width, MaxY = y + height
    [_sv setContentSize:CGSizeMake(0, CGRectGetMaxY(_btn_footer.frame))];
    
    // 默认在滚动到btn_header下面
    CGFloat y = CGRectGetMaxY(_btn_header.frame);
    CGFloat y1 = y + 50;
    NSLog(@"y1 = %f",y1);
    [_sv setContentOffset:CGPointMake(0, -y1)];
    
    // 设置上边的内边距
    _sv.contentInset = UIEdgeInsetsMake(y1, 0, 100, 0);
    
    // 允许分页
    /**
     分页时候 scrollview的宽度和高度是里面内容的宽度之后[横向分页]或者高度只和[纵向分页]
     */
    // _sv.pagingEnabled = YES;
}


@end
