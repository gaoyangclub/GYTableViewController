//
//  HotViewModel.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/24.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel

+ (instancetype)initWithParams:(NSString *)title iconName:(NSString *)iconName {
    HotModel *instance;
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
            instance.title = title;
            instance.iconName = iconName;
        }
    }
    return instance;
}

@end
