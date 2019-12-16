#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderView : UIView
+(HeaderView*)headerView;

-(void)scroll:(NSInteger)page;
@end

NS_ASSUME_NONNULL_END
