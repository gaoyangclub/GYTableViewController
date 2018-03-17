//
//  MJRefreshComponent+GY.m
//  MJRefreshTest
//
//  Created by admin on 2018/3/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MJRefreshComponent+GY.h"

@implementation MJRefreshComponent (GY)

-(BOOL)isIdle{
    return self.state == MJRefreshStateNoMoreData || self.state == MJRefreshStateIdle;
}

@end
