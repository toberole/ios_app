

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Toast : UILabel

-(instancetype)initWithMsg:(NSString*)msg;
-(instancetype)initWithMsg:(NSString*)msg Duration:(int)duration;

+(Toast*)makeToast:(NSString*)msg;
+(Toast*)makeToast:(NSString*)msg Duration:(int)duration;

-(void)show;
@end

NS_ASSUME_NONNULL_END
