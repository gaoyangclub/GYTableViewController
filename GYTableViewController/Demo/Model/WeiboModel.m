//
//  WeiboModel.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/28.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "WeiboModel.h"

@implementation WeiboModel

+(instancetype)initWithParams:(NSString *)iconName name:(NSString *)name title:(NSString *)title content:(NSString *)content imageUrl:(NSString *)imageUrl{
    WeiboModel *instance;
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
            instance.title = title;
            instance.iconName = iconName;
            instance.name = name;
            instance.content = content;
            instance.imageUrl = imageUrl;
        }
    }
    return instance;
}

@end
