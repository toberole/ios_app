#import "CellDemoTableViewCell.h"

@interface CellDemoTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *lbl_cell;
@end

@implementation CellDemoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

//-(void)setLbl_cell:(NSString *)lbl_cell_text{
//    NSLog(@"setLbl_cell ******");
//}

- (void)setLblCellText:(NSString *)lbl_cell_text{
    self.lbl_cell.text = lbl_cell_text;
}

@end
