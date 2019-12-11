//
//  APPInfo.h
//  ios_app
//
//  Created by Apple on 2019/12/10.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APPInfo : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * img;
@property(nonatomic,copy)NSString * apk;

/**
 静态构造函数 instancetype 指当前类的指针

 @param dict 传入参数字典
 @return 初始化的实例
 */
+(instancetype)appInfoWithDict:(NSDictionary*)dict;


/**
 构造函数
 
 @param dict 传入字典
 @return 返回实例
 */
-(instancetype)initWithDict:(NSDictionary*)dict;

@end


NS_ASSUME_NONNULL_END
