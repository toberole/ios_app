#import "Book.h"

NSString * const book_notification = @"book_notification";

@implementation Book

- (NSString *)description
{
    return [NSString stringWithFormat:@"book info name: %@,price = %i,desc = %@", _name,_price,_desc];
}

// 发送通知
-(void)notification_book{
    // NSString * obj = @"data ......";
    Book * obj = [[Book alloc]init];
    obj.name = @"notification_book object";
    // postNotificationName 消息对象的唯一标识，接受通知消息时用来辨别
    // object 一个对象，可以理解为针对某个对象的消息
    // userInfo 一个字典，用来传值
    NSDictionary * userinfo = @{@"data":@"data userinfo"};
    [[NSNotificationCenter defaultCenter] postNotificationName:book_notification object:obj userInfo:nil];
}

@end
