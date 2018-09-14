//
//  DishesModel.h
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/25.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DishesModel : NSObject

@property (nonatomic,copy) NSString *title;//标题栏

@property (nonatomic,copy) NSString *iconName;//图标名称

@property (nonatomic,copy) NSString *des;//sku描述

@property (nonatomic,copy) NSString *price;//价值

@property (nonatomic,copy) NSString *linkUrl;//跳转界面

//https://item.jd.com/5089255.html

+ (instancetype)initWithParams:(NSString*)title iconName:(NSString*)iconName des:(NSString*)des price:(NSString*)price linkUrl:(NSString*)linkUrl;

@end
