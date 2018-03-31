//
//  FundModel.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/24.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "FundModel.h"

@implementation FundModel

+(instancetype)initWithParams:(NSString *)title iconName:(NSString *)iconName des:(NSString *)des rate:(NSString *)rate{
    FundModel *instance;
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
            instance.title = title;
            instance.iconName = iconName;
            instance.des = des;
            instance.rate = rate;
        }
    }
    return instance;
}

@end
