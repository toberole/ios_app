#import "FooterView.h"

@interface FooterView()
- (IBAction)loadMoreData:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_load_more;
@property (strong, nonatomic) IBOutlet UIView *load_tip;

@end

@implementation FooterView


- (IBAction)loadMoreData:(UIButton *)sender {
    // 隐藏
    self.btn_load_more.hidden = YES;
    // 显示正在加载
    self.load_tip.hidden = NO;
    
    // 延时执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 增加数据 刷行UITableView 交给代理处理
        if ([self.delegate respondsToSelector:@selector(footerViewloadMore:)]/* 注意判断代理是否实现了代理方法 */) {
            [self.delegate footerViewloadMore:self];
        }
        
        self.btn_load_more.hidden = NO;
        self.load_tip.hidden = YES;
    });
}

+ (FooterView *)footerView{
    FooterView * footer = [[[NSBundle mainBundle]loadNibNamed:@"footerview" owner:nil options:nil]lastObject];
    return footer;
}
@end
