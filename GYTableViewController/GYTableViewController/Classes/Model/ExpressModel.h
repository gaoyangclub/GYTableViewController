//
//  ExpressModel.h
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/27.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpressModel : NSObject

@property (nonatomic, copy) NSString *title;//快递信息

/** 偷懒分成两个时间字段 后台应该是一个时间戳字段自己解析成下面两个值 **/
@property (nonatomic, copy) NSString *year;//年月日
@property (nonatomic, copy) NSString *time;//时分

+ (instancetype)initWithParams:(NSString *)title year:(NSString *)year time:(NSString *)time;

@end
