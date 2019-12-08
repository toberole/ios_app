#import "NSURL+url.h"
#import <objc/runtime.h>
@implementation NSURL (url)

+(void)load{
    NSLog(@"NSURL (url)load");
    
    Method m1 = class_getClassMethod([NSURL class], @selector(URLWithString:));
    Method m2 = class_getClassMethod([NSURL class], @selector(CF_URLWithStr:));
    NSLog(@"NSURL-begin---%p-----%p",method_getImplementation(m1),method_getImplementation(m2));
    method_exchangeImplementations(m1, m2);
    NSLog(@"NSURL-after---%p-----%p",method_getImplementation(m1),method_getImplementation(m2));
    

}

+(instancetype)CF_URLWithStr:(NSString *)URLString{
    NSURL *url = [NSURL CF_URLWithStr:URLString];//注意这里不能再调用系统的方法
    if (!url) {
        NSLog(@"url为空");
    }
    
    NSLog(@"url不为空");
    return url;
}

@end
