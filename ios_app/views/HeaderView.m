#import "HeaderView.h"

@interface HeaderView ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *lastView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UILabel *lbl_info;

@property(strong,nonatomic) NSArray * tips;

@end

@implementation HeaderView

+ (HeaderView *)headerView{
    HeaderView * header = [[[NSBundle mainBundle]loadNibNamed:@"header" owner:nil options:nil]lastObject];
    // 小技巧 设置宽度
    [header.scrollView setContentSize:CGSizeMake(CGRectGetMaxX(header.lastView.frame), 0)];
    // 分页
    header.scrollView.pagingEnabled = YES;
    // 隐藏滚动条
    header.scrollView.showsHorizontalScrollIndicator = NO;
    
    header.scrollView.delegate = header;
    
    header.pageControl.numberOfPages = 3;
    header.pageControl.currentPage = 0;
    
    header.tips = @[@"今天天气怎么样",@"宇宙第一IDE",@"前端开发工程师"];
    return header;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"HeaderView scrollViewDidScroll ......");
    CGFloat width = self.lastView.frame.size.width;
    // 计算当前的滚动页
    int n = self.scrollView.contentOffset.x/width;
    self.pageControl.currentPage = n;
    self.lbl_info.text = self.tips[n];
}

- (void)scroll:(NSInteger)page{
    NSLog(@"HeaderView scroll ...");
    CGFloat width = self.lastView.frame.size.width;
    self.scrollView.contentOffset = CGPointMake(page * width, 0);
}

@end
