//
//  HotViewModel.h
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/24.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotModel : NSObject

@property(nonatomic,copy) NSString* title;//标题栏

@property(nonatomic,copy) NSString* iconName;//图标名称

@property(nonatomic,copy) NSString* linkUrl;

+(instancetype)initWithParams:(NSString*)title iconName:(NSString*)iconName;

@end
