//
//  MJRefreshComponent+GY.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MJRefreshComponent+GY.h"

@implementation MJRefreshComponent (GY)

-(BOOL)isIdle{
    return self.state == MJRefreshStateNoMoreData || self.state == MJRefreshStateIdle;
}

@end
