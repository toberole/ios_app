#import "APPInfo.h"

@implementation APPInfo

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@,img = %@,apk = %@", _name,_img,_apk];
}

@end


