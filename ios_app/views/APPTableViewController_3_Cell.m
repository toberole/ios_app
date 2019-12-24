#import "APPTableViewController_3_Cell.h"

@interface APPTableViewController_3_Cell()
@property (strong, nonatomic) IBOutlet UILabel *lbl_text;

@end

@implementation APPTableViewController_3_Cell

- (void)setTextForCell:(NSString *)text{
    _lbl_text.text = text;
}

@end
