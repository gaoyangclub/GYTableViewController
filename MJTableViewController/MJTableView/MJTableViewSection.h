//
//  MJTableViewHeader.h
//  MJRefreshTest
//
//  Created by admin on 16/10/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJTableViewSection : UIControl

/** tableView所有section总数  **/
@property(nonatomic,assign)NSInteger sectionCount;
/** 当前section索引位置  **/
@property(nonatomic,assign)NSInteger sectionIndex;
/** 外部传入的数据 用来布局或交互等（sectionVo.sectionData） **/
@property(nonatomic,retain)id data;
/** 是否在整个tableView的首位 **/
@property(nonatomic,assign)BOOL isFirst;
/** 是否在整个tableView的末位 **/
@property(nonatomic,assign)BOOL isLast;

@end
