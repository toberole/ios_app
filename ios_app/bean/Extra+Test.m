#import "Extra+Test.h"
#import <objc/runtime.h>

// 使用runtime交换方法
@implementation Extra (Test)

- (void)test_Extra{
    NSLog(@"...... Extra (Test) test_Extra ......");
}

- (void)test_xxx{
    NSLog(@"...... Extra (Test) test_xxx ......");
}

+ (void)load{
    NSLog(@"Extra (Test) load");
    
    // 方法交换只用执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method m1 = class_getInstanceMethod([Extra class], @selector(test));
        Method m2 = class_getInstanceMethod([Extra class],@selector(test_xxx));
        NSLog(@"Extra-begin---%p-----%p",method_getImplementation(m1),method_getImplementation(m2));
        
        method_exchangeImplementations(m1, m2);
        
        NSLog(@"Extra-after---%p-----%p",method_getImplementation(m1),method_getImplementation(m2));
        
    });
}

/*
 当写的类没有继承的关系的时候，两种方法都没什么问题。
 当有继承关系又不确定方法实现没实现，最好用class_replaceMethod方法。
 */
// 该方案更好
+ (void)oneSwizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    
    IMP previousIMP = class_replaceMethod(cls,
                                          origSelector,
                                          method_getImplementation(swizzledMethod),
                                          method_getTypeEncoding(swizzledMethod));
    
    class_replaceMethod(cls,
                        newSelector,
                        previousIMP,
                        method_getTypeEncoding(originalMethod));
}
+ (void)twoSwizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@end
