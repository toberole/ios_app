#import "Test_Selector.h"
#import <Foundation/Foundation.h>
@implementation Test_Selector



-(void)func1{
    NSLog(@"func1");
}


-(void)func2:(int)a :(int)b{
    NSLog(@"a = %i,b = %i",a,b);
}

-(void)func3:(NSString *)str1 :(NSString *)str2{
    NSLog(@"str1 = %@,str2 = %@",str1,str2);
}

@end


