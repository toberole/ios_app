#import "Toast.h"

@interface Toast ()
@property(nonatomic,copy)NSString*msg;
@property(nonatomic,assign)int duration;
@end

@implementation Toast

-(instancetype)initWithMsg:(NSString *)msg{
    if (self = [super init]) {
        _msg = msg;
        _duration = 2;
    }
    
    return self;
}

- (instancetype)initWithMsg:(NSString *)msg Duration:(int)duration{
    if (self = [super init]) {
        _msg = msg;
        _duration = duration;
    }
    
    return self;
}

+ (Toast *)makeToast:(NSString *)msg{
    return [[self alloc]initWithMsg:msg];
}


+ (Toast *)makeToast:(NSString *)msg Duration:(int)duration{
    return [[self alloc]initWithMsg:msg Duration:duration];
}

- (void)show{
    int toast_v_w = 150;
    int toast_v_h = 30;
    CGFloat x = ([[UIScreen mainScreen]bounds].size.width - toast_v_w)/2;
    CGFloat y = ([[UIScreen mainScreen]bounds].size.height - toast_v_h)/2;
    [self setFrame:CGRectMake(x, y, toast_v_w, toast_v_h)];
    [self setBackgroundColor:[UIColor blackColor]];
    [self setText:_msg];
    [self setTextColor:[UIColor whiteColor]];
    [self setTextAlignment:NSTextAlignmentCenter];
    // 透明度
    self.alpha = 0.0;
    // 设置圆角半径
    self.layer.cornerRadius = 5;
    // 圆角弧以外的部分截掉 就称为圆角形状
    self.layer.masksToBounds = YES;
    
}

@end
