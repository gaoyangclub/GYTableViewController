//
//  UIViewController+GYTableView.h
//  GYTableViewController
//
//  Created by gaoyang on 2018/9/13.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYTableBaseView.h"

@interface UIViewController (GYTableView)<GYTableBaseViewDelegate>

/** controller包含的tableView实例 **/
@property (nonatomic, strong) GYTableBaseView *tableView;
/** 设置进入该页面是否自动下拉刷新 默认true **/
@property (nonatomic, assign) BOOL autoRefreshHeader;
/** 设置选中某个indexPath位置 **/
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
/** 设置是否标记重用cell实例 默认true **/
@property (nonatomic, assign) BOOL useCellIdentifer;
/** 设置每次进入该页面自动滚动到列表顶部 默认false **/
@property (nonatomic, assign) BOOL autoRestOffset;
/** 设置是否显示下拉刷新控件 默认true **/
@property (nonatomic, assign) BOOL isShowHeader;
/** 设置是否显示上拉加载控件 默认false **/
@property (nonatomic, assign) BOOL isShowFooter;

/** 设置是否使用该控件 默认false;请在引入头文件后重写该方法返回true **/
- (BOOL)useGYTableView;

/** 设置TableView的布局位置，默认铺满Controller **/
- (CGRect)getTableViewFrame;
/** 设置自定义下拉刷新控件实例 **/
- (MJRefreshHeader *)getRefreshHeader;
/** 设置自定义上拉加载控件实例 **/
- (MJRefreshFooter *)getRefreshFooter;
/** 设置TableView的父容器，默认当前view **/
- (UIView *)getTableViewParent;

@end
