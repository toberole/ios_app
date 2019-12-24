#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MySectionView;

//定义枚举类型
typedef enum _SectionState {
    OPENED = 0,
    CLOSED = 1
} SectionState;

@protocol MySectionViewDelegate <NSObject>
-(void)mySectionViewOnclicked:(MySectionView*)v;
@end

@interface MySectionView : UITableViewHeaderFooterView


+(MySectionView*)sectionView;

-(void)setBtnTxt:(NSString*)txt;
-(void)setLlbTxt:(NSString*)txt;
-(void)setSectionIndex:(NSInteger)index;
-(void)setstate:(SectionState)state;
-(NSInteger)getSectionIndex;
-(SectionState)getstate;

-(void)setMyDelegate:(id<MySectionViewDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
