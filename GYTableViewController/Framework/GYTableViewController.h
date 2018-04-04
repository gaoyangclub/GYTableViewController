//
//  GYTableViewController.h
//  GYTableViewController
//
//  Created by 高扬 on 16/10/17.
//  Copyright © 2016年 高扬. All rights reserved.
//

/*
 *********************************************************************************
 *
 * GYTableViewController交流QQ群：296406818 🎉🎉🎉
 *
 * 使用GY列表框架出现bug，内存问题，或是想新增功能，请您前往github仓库提供issues，我们会尽快修复
 * GitHub: https://github.com/gaoyangclub/GYTableViewController
 * 用法示例：https://github.com/gaoyangclub/GYTableViewController/blob/master/README.md
 *
 *********************************************************************************
 */

#import <UIKit/UIKit.h>
#import "GYTableBaseView.h"

@interface GYTableViewController : UIViewController<GYTableBaseViewDelegate>

/** controller包含的tableView实例 **/
@property(nonatomic,retain)GYTableBaseView* tableView;
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

@end
