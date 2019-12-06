#import "StatusBarNavigationBarViewController.h"

@interface StatusBarNavigationBarViewController ()

@end

@implementation StatusBarNavigationBarViewController
/*
 分别处理statusbar 和 navigationbar
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航颜色  可用
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    // 创建一个高20的假状态栏
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 20)];
    
    // 设置成绿色
    statusBarView.backgroundColor=[UIColor greenColor];
    // 添加到 navigationBar 上
    [self.navigationController.navigationBar addSubview:statusBarView];
}

// 改变状态栏的显示样式（前景颜色）需要在ViewContoller里重载方法
// 这个方法不能直接调用，需要通过下面这个方法来刷新状态栏的样式
//- (UIStatusBarStyle)preferredStatusBarStyle{
//     return UIStatusBarStyleLightContent;
//}
//
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//
//    [self setNeedsStatusBarAppearanceUpdate];
//}

// 简单粗暴地概括下就是：如果想改变StatusBar的显示风格，把UIViewControllerBasedStatusBarAppearance设置为NO，然后通过UIApplication对象设置StatusBar 的 Style。


@end
