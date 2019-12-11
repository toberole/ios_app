#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class APPInfo;
@interface APPInfoItemView : UIView

-(instancetype)initWithNibName:(NSString*)nibName;
+(instancetype)appInfoItemView:(NSString*)nibName;

-(instancetype)initWithAppInfo:(APPInfo*)appinfo;
+(instancetype)appInfoItemView_1:(APPInfo*)appinfo;

@end

NS_ASSUME_NONNULL_END
