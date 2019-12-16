#import "APPViewTouchViewController.h"

@interface APPViewTouchViewController ()

@end

@implementation APPViewTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// touch 代理的方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"APPViewTouchViewController#touchesBegan");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"APPViewTouchViewController#touchesMoved");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"APPViewTouchViewController#touchesEnded");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"APPViewTouchViewController#touchesCancelled");
}

@end
