#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderView : UIView
-(void)scroll:(NSInteger)page;
+(HeaderView*)headerView;
@end

NS_ASSUME_NONNULL_END
