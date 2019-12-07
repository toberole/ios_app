#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject

@property(nonatomic,assign)int price;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *desc;

@end



NS_ASSUME_NONNULL_END
