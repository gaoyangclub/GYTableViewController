//
//  UIViewController+GYTableView.h
//  GYTableViewController
//
//  Created by 高扬 on 2018/9/13.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYTableBaseView.h"

@interface UIViewController (GYTableView)<GYTableBaseViewDelegate>

/** controller包含的tableView实例 **/
@property (nonatomic, strong) GYTableBaseView *tableView;
/** 设置进入该页面是否自动下拉刷新 默认true **/
@property (nonatomic, assign) BOOL autoRefreshHeader;
/** 设置每次进入该页面自动滚动到列表顶部 默认false **/
@property (nonatomic, assign) BOOL autoRestOffset;
/** 设置是否显示下拉刷新控件 默认true **/
@property (nonatomic, assign) BOOL isShowHeader;
/** 设置是否显示上拉加载控件 默认false **/
@property (nonatomic, assign) BOOL isShowFooter;
/** 设置选中某个indexPath位置 **/
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;


/** 设置是否使用该控件 默认false;请在引入头文件后重写该方法返回true **/
- (BOOL)gy_useTableView;

/** 同 @property isShowHeader */
- (BOOL)gy_useRefreshHeader;

/** 同 @property isShowFooter */
- (BOOL)gy_useLoadMoreFooter;

/** 同 @property autoRefreshHeader */
- (BOOL)gy_useAutoRefreshHeader;

/** 同 @property autoRestOffset */
- (BOOL)gy_useAutoRestOffset;

/** 设置TableView的布局位置，默认铺满Controller **/
- (CGRect)gy_getTableViewFrame;
/** 设置自定义下拉刷新控件实例 **/
- (MJRefreshHeader *)gy_getRefreshHeader;
/** 设置自定义上拉加载控件实例 useLoadMoreFooter启用有效 **/
- (MJRefreshFooter *)gy_getRefreshFooter;
/** 设置TableView的父容器，默认当前view **/
- (UIView *)gy_getTableViewParent;

@end
