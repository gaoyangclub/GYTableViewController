//
//  StoreModel.h
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/27.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property (nonatomic, copy) NSString *title;//标题栏

@property (nonatomic, copy) NSString *iconName;//图片地址

@property (nonatomic, copy) NSString *des;//sku描述

@property (nonatomic, copy) NSString *hot;//热度

@property (nonatomic, copy) NSString *discount;//折扣

+ (instancetype)initWithParams:(NSString *)title iconName:(NSString *)iconName hot:(NSString *)hot des:(NSString *)des discount:(NSString*)discount;

@end
