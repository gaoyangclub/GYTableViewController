//
//  MJTableViewCell.h
//  MJRefreshTest
//
//  Created by admin on 16/10/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJTableBaseView.h"

@class MJTableBaseView;
@class CellVo;

@interface MJTableViewCell : UITableViewCell

/** 是否在该节中的首位 **/
@property(nonatomic,assign) BOOL isFirst;
/** 是否在该节中的末位 **/
@property(nonatomic,assign) BOOL isLast;
/** 是否在该节只有此一个MJTableViewCell实例 **/
@property(nonatomic,assign) BOOL isSingle;
/** 是否需要刷新界面 **/
@property(nonatomic,assign) BOOL needRefresh;
/** 是否初次界面加载完毕 **/
@property(nonatomic,assign) BOOL isSubviewShow;
/** 对应的MJTableBaseView实例 **/
@property(nonatomic,weak) MJTableBaseView* tableView;
/** 当前所处位置 **/
@property(nonatomic,retain) NSIndexPath* indexPath;
/** 对应的CellVo实例 **/
@property(nonatomic,retain) CellVo *cellVo;
/** 外部传入的数据 用来布局或交互等（cellVo.cellData） **/
@property(nonatomic,retain) id data;
//@property(nonatomic,assign) BOOL isSelected;

/** 页面元素创建并布局 请勿使用layoutSubviews来布局 **/
-(void)showSubviews;
/** 是否显示选中的效果样式 默认false **/
-(BOOL)showSelectionStyle;
/** 根据内容动态计算高度（适合内容多少高度不定的样式或文案展示） **/
-(CGFloat)getCellHeight:(CGFloat)cellWidth;

@end
