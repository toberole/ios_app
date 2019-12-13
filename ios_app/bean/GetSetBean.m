//
//  GetSetBean.m
//  ios_app
//
//  Created by Apple on 2019/12/12.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import "GetSetBean.h"

@implementation GetSetBean

/**
 不能同时重写get和set[同时重写get和set property就不会自动生成成员变量]
 需要用 synthesize处理
 */

// 错误
//// 自己写get
//-(int)count{
//    NSLog(@"自己写get");
//    return _count;
//}
//
//// 自己写set
//-(void)setCount:(int)count{
//    // count = count_;
//    NSLog(@"自己写get");
//}

// 处理之后就可以同时重写get和set
@synthesize count = _count;
// 自己写get
-(int)count{
    NSLog(@"自己写get");
    return _count;
}

// 自己写set
-(void)setCount:(int)count{
    _count = count;
    NSLog(@"自己写get");
}


@end
