#import "APPIMGViewController.h"

@interface APPIMGViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *iv;
@property(assign,nonatomic)int n;
- (IBAction)ch_img:(id)sender;

@end

@implementation APPIMGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _n = 0;
    [_iv setImage:[UIImage imageNamed:@"0.jpg"]];
}

- (IBAction)ch_img:(id)sender {
    _n++;
    _n = _n%6;
    NSString *name = [NSString stringWithFormat:@"%d.jpg",_n];
    NSLog(@"img name = %@",name);
    [_iv setImage:[UIImage imageNamed:name]];
}
@end
