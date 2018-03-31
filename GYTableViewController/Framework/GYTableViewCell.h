//
//  GYTableViewCell.h
//  GYTableViewController
//
//  Created by 高扬 on 16/10/14.
//  Copyright © 2016年 高扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYTableBaseView.h"

@class GYTableBaseView;
@class CellVo;

#define GET_CELL_DATA(targetClass) [self checkCellDataClass:targetClass]
#define GET_CELL_ARRAY_DATA(arrayMemberClass) [self checkCellArrayDataClass:arrayMemberClass]

@interface GYTableViewCell : UITableViewCell

/** 是否在该节中的首位 **/
@property(nonatomic,assign) BOOL isFirst;
/** 是否在该节中的末位 **/
@property(nonatomic,assign) BOOL isLast;
/** 是否在该节只有此一个GYTableViewCell实例 **/
@property(nonatomic,assign) BOOL isSingle;
/** 是否需要刷新界面 **/
@property(nonatomic,assign) BOOL needRefresh;
/** 是否初次界面加载完毕 **/
@property(nonatomic,assign) BOOL isSubviewShow;
/** 对应的GYTableBaseView实例 **/
@property(nonatomic,weak) GYTableBaseView* tableView;
/** 当前所处位置 **/
@property(nonatomic,retain) NSIndexPath* indexPath;
/** 对应的CellVo实例 **/
@property(nonatomic,retain) CellVo *cellVo;

/** 页面元素创建并布局 请勿使用layoutSubviews来布局 **/
-(void)showSubviews;
/** 是否显示选中的效果样式 默认false **/
-(BOOL)showSelectionStyle;
/** 根据内容动态计算高度（适合内容多少高度不定的样式或文案展示） **/
-(CGFloat)getCellHeight:(CGFloat)cellWidth;
/** 检查cellData的类型是否是目标类型 并返回cellData **/
-(id)checkCellDataClass:(Class)targetClass;
/** 检查cellData类型为NSArray中的子元素类型是否是目标类型 并返回cellData **/
-(NSArray*)checkCellArrayDataClass:(Class)arrayMemberClass;

/** 外部传入的数据 用来布局或交互等（cellVo.cellData） **/
//@property(nonatomic,retain) id data;

-(void)layoutSubviews __attribute__((unavailable("Disabled")));

@end
