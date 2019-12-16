#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FooterView;
/// 协议
@protocol FootViewDelegate <NSObject>
 
@required
-(void)footerViewloadMore:(FooterView *)footerView;

@end

@interface FooterView : UIView
+(FooterView*) footerView;
// 代理 注意写法
// UI控件的代理必须是weak的，防止循环引用
@property(weak,nonatomic) id<FootViewDelegate> delegate;

@end



NS_ASSUME_NONNULL_END
