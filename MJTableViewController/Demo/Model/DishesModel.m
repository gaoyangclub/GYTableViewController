//
//  DishesModel.m
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/25.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "DishesModel.h"

@implementation DishesModel

+(instancetype)initWithParams:(NSString *)title iconName:(NSString *)iconName des:(NSString *)des price:(NSString *)price linkUrl:(NSString*)linkUrl{
    DishesModel *instance;
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
            instance.title = title;
            instance.iconName = iconName;
            instance.des = des;
            instance.price = price;
            instance.linkUrl = linkUrl;
        }
    }
    return instance;
}

@end
