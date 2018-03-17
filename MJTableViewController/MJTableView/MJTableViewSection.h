//
//  MJTableViewHeader.h
//  MJRefreshTest
//
//  Created by admin on 16/10/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJTableViewSection : UIControl

@property(nonatomic,assign)NSInteger itemCount;//多少section数
@property(nonatomic,assign)NSInteger itemIndex;
@property(nonatomic,retain)id data;
@property(nonatomic,assign)BOOL isFirst;
@property(nonatomic,assign)BOOL isLast;

@end
