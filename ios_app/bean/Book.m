#import "Book.h"

@implementation Book

- (NSString *)description
{
    return [NSString stringWithFormat:@"book info name: %@,price = %i,desc = %@", _name,_price,_desc];
}

@end
