#import "BeanOC.h"

// 匿名类别(匿名扩展)是可以添加实例变量的，非匿名类别是不能添加实例变量的，只能添加方法，或者属性（其实也是方法）
// 扩展
@interface BeanOC (){
    // 实例变量
    int _y;
}
@property(nonatomic,assign) int i;
@end


@implementation BeanOC

- (void)setX:(int)x{
    _x = x;
}

- (int)x{
    return _x;
}

@end
