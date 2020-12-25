#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAudioSettings.h>

#import "AudioRecorderViewController.h"
#import "RecordTool.h"
@interface AudioRecorderViewController ()

@property (nonatomic,strong) RecordTool *recordTool;

- (IBAction)start:(UIButton *)sender;
- (IBAction)stop:(UIButton *)sender;

@end

@implementation AudioRecorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"录音";
}

- (IBAction)start:(UIButton *)sender {
    NSLog(@"start record ......");
}

- (IBAction)stop:(UIButton *)sender {
    NSLog(@"stop record ......");
}
@end
