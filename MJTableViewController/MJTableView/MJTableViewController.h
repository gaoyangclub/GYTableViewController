//
//  MJTableViewController.h
//  MJRefreshTest
//
//  Created by admin on 16/10/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJTableBaseView.h"

@interface MJTableViewController : UIViewController<MJTableBaseViewDelegate>

/** controller包含的tableView实例 **/
@property(nonatomic,retain)MJTableBaseView* tableView;
//@property(nonatomic,assign)BOOL contentOffsetRest;
/** 设置进入该页面是否自动下拉刷新 默认true **/
@property(nonatomic,assign)BOOL autoRefreshHeader;
/** 设置选中某个indexPath位置 **/
@property(nonatomic,retain)NSIndexPath* selectedIndexPath;

/**
 以下方法以及MJTableBaseViewDelegate中的所有方法均为子类重写，外部无法更改
 ***/
/** 设置TableView的布局位置，默认铺满Controller **/
-(CGRect)getTableViewFrame;
/** 设置是否显示下拉刷新控件 默认显示 **/
-(BOOL)getShowHeader;
/** 设置是否显示上拉加载控件 默认显示 **/
-(BOOL)getShowFooter;
/** 设置是否标记重用cell实例 默认true **/
-(BOOL)getUseCellIdentifer;
/** 设置每次进入该页面自动滚动到列表顶部 默认false **/
-(BOOL)getNeedRestOffset;
/** 设置自定义下拉刷新控件实例 **/
-(MJRefreshHeader*)getHeader;

@end
