//
//  PraiseModel.m
//  MJTableViewController
//
//  Created by admin on 2018/3/26.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "PraiseModel.h"

@implementation PraiseModel

+(instancetype)initWithParams:(NSString *)groupTitle hotModels:(NSArray<HotModel *> *)hotModels{
    PraiseModel *instance;
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
            instance.groupTitle = groupTitle;
            instance.hotModels = hotModels;
        }
    }
    return instance;
}

@end
