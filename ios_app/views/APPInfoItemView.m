#import "APPInfoItemView.h"
#include "../bean/APPInfo.h"

@implementation APPInfoItemView
- (instancetype)initWithNibName:(NSString *)nibName{
    if (self = [super init]) {
        return self;
    }
    
    return nil;
}

+ (instancetype)appInfoItemView:(NSString *)nibName{
    return [[APPInfoItemView alloc]initWithNibName:nibName];
}

- (instancetype)initWithAppInfo:(APPInfo *)appinfo{
    if (self = [super init]) {
        // 使用appinfo 初始化view
        return self;
    }
    
    return nil;
}

+ (instancetype)appInfoItemView_1:(APPInfo *)appinfo{
    return [[self alloc]initWithAppInfo:appinfo];
}

@end
