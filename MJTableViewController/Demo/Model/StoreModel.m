//
//  StoreModel.m
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/27.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel

+(instancetype)initWithParams:(NSString *)title iconName:(NSString *)iconName hot:(NSString *)hot des:(NSString *)des discount:(NSString *)discount{
    StoreModel *instance;
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
            instance.title = title;
            instance.iconName = iconName;
            instance.hot = hot;
            instance.des = des;
            instance.discount = discount;
        }
    }
    return instance;
}

@end
