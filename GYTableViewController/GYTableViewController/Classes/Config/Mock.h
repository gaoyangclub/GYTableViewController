//
//  Mock.h
//  GYTableViewController
//
//  Created by gaoyang on 2019/2/5.
//  Copyright © 2019年 高扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface Mock : NSObject

#pragma mark RefreshDemo数据
@property (class, nonatomic, strong, readonly) NSArray<NSString *> *bannerUrlGroup;
@property (class, nonatomic, strong, readonly) NSArray<HotModel *> *hotModels;
@property (class, nonatomic, strong, readonly) NSArray<FundModel *> *fundModels;
@property (class, nonatomic, strong, readonly) NSArray<FundModel *> *fundNewModels;

#pragma mark FrameDemo数据
@property (class, nonatomic, strong, readonly) NSArray<DishesModel *> *dishesModels;

#pragma mark GapDemo数据
@property (class, nonatomic, strong, readonly) PraiseModel *praiseModel;
@property (class, nonatomic, strong, readonly) NSArray<StoreModel *> *storeModels;

#pragma mark RelateDemo数据
@property (class, nonatomic, strong, readonly) NSArray<ExpressModel *> *expressModels;

#pragma mark AutoHeightDemo数据
@property (class, nonatomic, strong, readonly) NSArray<WeiboModel *> *weiboModels;

@end

NS_ASSUME_NONNULL_END
