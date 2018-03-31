//
//  PraiseModel.h
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/26.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotModel.h"

@interface PraiseModel : NSObject

@property(nonatomic,copy)NSString* groupTitle;
@property(nonatomic,retain)NSArray<HotModel*>* hotModels;

+(instancetype)initWithParams:(NSString*)groupTitle hotModels:(NSArray<HotModel*>*)hotModels;

@end
