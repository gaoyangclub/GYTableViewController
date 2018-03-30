//
//  WeiboModel.h
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/28.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboModel : NSObject

@property(nonatomic,copy) NSString* iconName;//头像
@property(nonatomic,copy) NSString* name;//用户名
@property(nonatomic,copy) NSString* title;//标题
@property(nonatomic,copy) NSString* content;//内容
@property(nonatomic,copy) NSString* imageUrl;//图片内容

+(instancetype)initWithParams:(NSString*)iconName name:(NSString*)name title:(NSString*)title content:(NSString*)content imageUrl:(NSString*)imageUrl;

@end
