#import <UIKit/UIKit.h>

/*
    1.从xib定义controller的时候类和xib文件名称必须一致。
 
    2.无论是否设定xib的file's ower值，只要与某个controller类名称一致，则就会让那个controller的view指向当前的xib定义的内容。
 
    3.file's owner属性只是便于xcode操作而已。
 */
NS_ASSUME_NONNULL_BEGIN

@interface NextViewController : UIViewController


@end

NS_ASSUME_NONNULL_END
