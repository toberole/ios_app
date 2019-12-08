#import "Extra.h"

NS_ASSUME_NONNULL_BEGIN
// 使用runtime交换方法
@interface Extra (Test)
- (void)test_Extra;
- (void)test_xxx;

+ (void)oneSwizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector;
+ (void)twoSwizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector;

@end

NS_ASSUME_NONNULL_END
