
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

NS_ASSUME_NONNULL_BEGIN
@interface RecordTool : NSObject
@property (nonatomic, copy) void(^block)(NSData *);
@property (nonatomic,assign) BOOL isRecording;

+ (instancetype)shared;
- (instancetype) init;
- (void)startRecordingWithBlock:(void (^_Nullable)(NSData *_Nullable))block;

@end

NS_ASSUME_NONNULL_END
