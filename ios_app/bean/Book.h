#import <Foundation/Foundation.h>
#import "Extra.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const book_notification;



@interface Book : NSObject

@property(nonatomic,assign)int price;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *desc;

@property(nonatomic,strong) Extra * extra;

-(void)notification_book;

@end



NS_ASSUME_NONNULL_END
