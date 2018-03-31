//
//  FundModel.h
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/24.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FundModel : NSObject

@property(nonatomic,copy) NSString* title;//标题栏

@property(nonatomic,copy) NSString* iconName;//图标名称

@property(nonatomic,copy) NSString* des;//描述

@property(nonatomic,copy) NSString* rate;//利率

+(instancetype)initWithParams:(NSString*)title iconName:(NSString*)iconName des:(NSString*)des rate:(NSString*)rate;

@end
