//
//  ExpressModel.m
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/27.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "ExpressModel.h"

@implementation ExpressModel

+(instancetype)initWithParams:(NSString *)title year:(NSString *)year time:(NSString *)time{
    ExpressModel *instance;
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
            instance.title = title;
            instance.year = year;
            instance.time = time;
        }
    }
    return instance;
}

@end
