//
//  MJTableViewController.h
//  MJRefreshTest
//
//  Created by 高扬 on 16/10/17.
//  Copyright © 2016年 高扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJTableBaseView.h"

@interface MJTableViewController : UIViewController<MJTableBaseViewDelegate>

/** controller包含的tableView实例 **/
@property(nonatomic,retain)MJTableBaseView* tableView;
/** 设置进入该页面是否自动下拉刷新 默认true **/
@property(nonatomic,assign)BOOL autoRefreshHeader;
/** 设置选中某个indexPath位置 **/
@property(nonatomic,retain)NSIndexPath* selectedIndexPath;
/** 设置是否标记重用cell实例 默认true **/
@property(nonatomic,assign)BOOL useCellIdentifer;
/** 设置每次进入该页面自动滚动到列表顶部 默认false **/
@property(nonatomic,assign)BOOL autoRestOffset;
/** 设置是否显示下拉刷新控件 默认true **/
@property(nonatomic,assign)BOOL isShowHeader;
/** 设置是否显示上拉加载控件 默认false **/
@property(nonatomic,assign)BOOL isShowFooter;

/** 设置TableView的布局位置，默认铺满Controller **/
-(CGRect)getTableViewFrame;
/** 设置自定义下拉刷新控件实例 **/
-(MJRefreshHeader*)getRefreshHeader;
/** 设置自定义上拉加载控件实例 **/
-(MJRefreshFooter*)getRefreshFooter;

/** 设置是否显示下拉刷新控件 默认true **/
//-(BOOL)getShowHeader;
/** 设置是否显示上拉加载控件 默认false **/
//-(BOOL)getShowFooter;
/** 设置是否标记重用cell实例 默认true **/
//-(BOOL)getUseCellIdentifer;
/** 设置每次进入该页面自动滚动到列表顶部 默认false **/
//-(BOOL)getNeedRestOffset;


@end
