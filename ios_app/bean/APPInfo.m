#import "APPInfo.h"

@implementation APPInfo

/*
 有时候我们重写父类的init方法时不注意将init后面的第一个字母写成了小写，在这个方法里面又调用父类的初始化方法（self = [super init];）时会报错，错误信息如下：error：Cannot assign to 'self' outside of a method in the init family
 原因：
    只能在init方法中给self赋值，Xcode判断是否为init方法规则：方法返回id，并且名字以init+大写字母开头+其他  为准则。例如：- (id) initWithXXX;
 */
 
- (instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

// 用于字典直接转换为bean
+ (instancetype)appInfoWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@,img = %@,apk = %@", _name,_img,_apk];
}

@end


