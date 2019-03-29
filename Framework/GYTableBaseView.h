//
//  GYTableBaseView.h
//  GYTableViewController
//
//  Created by 高扬 on 2016/10/13.
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
#import "MJRefresh.h"
#import "GYTableViewCell.h"
#import "GYTableViewSection.h"

#import "MJRefreshComponent+GY.h"

@class CellNode;
@class SectionNode;
@class GYTableViewCell;
@class GYTableBaseView;

/** 下拉刷新或上拉加载调用结束Block hasData标注界面是否刷新出了新的数据  **/
//typedef void(^HeaderRefreshHandler)(BOOL hasData);
//typedef void(^FooterLoadMoreHandler)(BOOL hasData);

/**
 自动设置高度
 **/
static CGFloat const CELL_AUTO_HEIGHT = -1;

@protocol GYTableBaseViewDelegate<UITableViewDelegate>

@optional
/** 当GYTableBaseView下拉刷新时代理调用 **/
- (void)headerRefresh:(GYTableBaseView *)tableView;

/** 当GYTableBaseView上拉加载时代理调用 **/
- (void)footerLoadMore:(GYTableBaseView *)tableView lastSectionNode:(SectionNode *)lastSectionNode;

/** 当GYTableBaseView下拉刷新完毕后代理调用 **/
- (void)didRefreshComplete:(GYTableBaseView *)tableView;

/** 当GYTableBaseView上拉加载完毕后代理调用 **/
- (void)didLoadMoreComplete:(GYTableBaseView *)tableView;

/** 当GYTableBaseView某一条GYTableViewCell实例被点击时代理调用 **/
- (void)tableView:(GYTableBaseView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, "请使用didSelectRow:indexPath:代替");

/** 当GYTableBaseView某一条GYTableViewCell实例被点击时代理调用 **/
- (void)didSelectRow:(GYTableBaseView *)tableView indexPath:(NSIndexPath *)indexPath;

/** 当GYTableBaseView滚动到某个位置时代理调用 **/
- (void)didScrollToRow:(GYTableBaseView *)tableView indexPath:(NSIndexPath *)indexPath;

/**
 当cell将被使用的时候做预定义(cellForRowAtIndexPath后被调用), 当用户需要对cell控件实例初始化一些自定义变量，或添加block并在控制器中回调的场景下使用
 @param tableView tabel实例
 @param targetCell 目标cell控件实例
 @param indexPath 位置
 */
- (void)preparCell:(GYTableBaseView *)tableView targetCell:(GYTableViewCell *)targetCell indexPath:(NSIndexPath *)indexPath;

/** 以下方法不可代理调用  **/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView __attribute__((unavailable("Disabled")));
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section __attribute__((unavailable("Disabled")));
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section __attribute__((unavailable("Disabled")));
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section __attribute__((unavailable("Disabled")));
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath __attribute__((unavailable("Disabled")));
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath __attribute__((unavailable("Disabled")));
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section __attribute__((unavailable("Disabled")));
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section __attribute__((unavailable("Disabled")));
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section __attribute__((unavailable("Disabled")));
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section __attribute__((unavailable("Disabled")));
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath __attribute__((unavailable("Disabled")));
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath __attribute__((unavailable("Disabled")));


@end


@interface GYTableBaseView : UITableView

- (instancetype)init __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));
+ (instancetype)new __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));
- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));
- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));

+ (instancetype)table:(id<GYTableBaseViewDelegate>)delegate;

- (instancetype)initWithFrameAndParams:(CGRect)frame showHeader:(BOOL)showHeader showFooter:(BOOL)showFooter useCellIdentifer:(BOOL)useCellIdentifer delegate:(id<GYTableBaseViewDelegate>)delegate;
- (instancetype)initWithFrameAndParams:(CGRect)frame style:(UITableViewStyle)style showHeader:(BOOL)showHeader showFooter:(BOOL)showFooter useCellIdentifer:(BOOL)useCellIdentifer delegate:(id<GYTableBaseViewDelegate>)delegate;

@property (nonatomic, strong, readonly) NSMutableArray<SectionNode *> *dataSourceArray;

@property (nonatomic, weak) id<GYTableBaseViewDelegate> gy_delegate;
//@property (nonatomic,assign) BOOL refreshAll;
@property (nonatomic, strong) MJRefreshHeader *header;
@property (nonatomic, strong) MJRefreshFooter *footer;

/** 设置选中位置 **/
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
/** 点中cell高亮 **/
@property (nonatomic, assign) BOOL clickCellHighlight;
/** 点中cell自动居中 **/
@property (nonatomic, assign) BOOL clickCellMoveToCenter;
/** 每一节间距 **/
@property (nonatomic, assign) CGFloat sectionGap;
/** 每个cell间距 **/
@property (nonatomic, assign) CGFloat cellGap;
/** 首次下拉 **/
@property (nonatomic, assign, readonly) BOOL hasFirstRefreshed;


/** 开始下拉刷新 **/
- (void)headerBeginRefresh;
/**
 结束下拉刷新
 @param hasData 是否下拉到数据(根据是否返回数据表现不同状态)
 */
- (void)headerEndRefresh:(BOOL)hasData;
/**
 结束上拉加载更多
 @param hasData 是否加载到数据(根据是否返回数据表现不同状态)
 */
- (void)footerEndLoadMore:(BOOL)hasData;
/** 检查数据间距 **/
- (void)checkGaps;
/** 清除所有数据 **/
- (void)clearAllSectionNode;
/** 添加一节内容 **/
- (void)addSectionNode:(SectionNode *)sectionNode;
/** 在某个索引插入一节内容 **/
- (void)insertSectionNode:(SectionNode *)sectionNode atIndex:(NSInteger)index;
/** 删除一节内容 **/
- (void)removeSectionNodeAt:(NSInteger)index;
/** 重新刷新全部界面 类似源生的reloadData **/
- (void)gy_reloadData;
/** 将选中的数据项平滑居中移动 **/
- (void)moveSelectedIndexPathToCenter;

/** 获取最后一个SectionNode **/
- (SectionNode *)getLastSectionNode;
/** 获取第一个SectionNode **/
- (SectionNode *)getFirstSectionNode;
/** 获取目标索引位置SectionNode **/
- (SectionNode *)getSectionNodeByIndex:(NSInteger)index;
/** 获取目标indexPath位置CellNode **/
- (CellNode *)getCellNodeByIndexPath:(NSIndexPath *)indexPath;
/** 获取SectionNode总数 **/
- (NSUInteger)getSectionNodeCount;
/** 获取CellNode总数 所有SectionNode包含的CellNode总和 **/
- (NSUInteger)getTotalCellNodeCount;

@end

//一节的标题头数据
@interface SectionNode : NSObject

/** 创建SectionNode实例并初始化设置下一步回调 **/
+ (instancetype)initWithParams:(void(^)(SectionNode *sNode))nextBlock;
/** 创建SectionNode实例并初始化设置section页眉高度、section页眉类型、section页眉数据、下一步回调 **/
+ (instancetype)initWithParams:(CGFloat)sectionHeaderHeight sectionHeaderClass:(Class)sectionHeaderClass sectionHeaderData:(id)sectionHeaderData nextBlock:(void(^)(SectionNode *sNode))nextBlock;
/** 创建SectionNode实例并初始化设置section页眉高度、section页眉类型、section页眉数据、section页脚高度、section页脚类型、section页脚数据、下一步回调 **/
+ (instancetype)initWithParams:(CGFloat)sectionHeaderHeight sectionHeaderClass:(Class)sectionHeaderClass sectionHeaderData:(id)sectionHeaderData sectionFooterHeight:(CGFloat)sectionFooterHeight sectionFooterClass:(Class)sectionFooterClass sectionFooterData:(id)sectionFooterData nextBlock:(void(^)(SectionNode *sNode))nextBlock;

/** GYTableViewSection页眉实例高度 **/
@property (nonatomic, assign) CGFloat sectionHeaderHeight;
/** 用来实例化GYTableViewSection页眉的自定义类型 **/
@property (nonatomic, strong) Class sectionHeaderClass;
/** 传递给GYTableViewSection页眉实例的数据，用来展示界面判断逻辑等，实例内部通过self.data属性获得 **/
@property (nonatomic, strong) id sectionHeaderData;

/** GYTableViewSection页脚实例高度 **/
@property (nonatomic, assign) CGFloat sectionFooterHeight;
/** 用来实例化GYTableViewSection页脚的自定义类型 **/
@property (nonatomic, strong) Class sectionFooterClass;
/** 传递给GYTableViewSection页脚实例的数据，用来展示界面判断逻辑等，实例内部通过self.data属性获得 **/
@property (nonatomic, strong) id sectionFooterData;

/** 该节包含的CellNode个数 **/
- (NSInteger)getCellNodeCount;
/**  添加单个CellNode **/
- (void)addCellNode:(CellNode*)cellNode;
/**  批量添加CellNode **/
- (void)addCellNodeByList:(NSArray<CellNode *> *)otherNodeList;

@end

@interface CellNode : NSObject

/** 创建CellNode实例并初始化设置cell高度、cell类型、cell数据 **/
+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData;
/** 创建CellNode实例并初始化设置cell高度、cell类型、cell数据、cell是否唯一 **/
+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData isUnique:(BOOL)isUnique;
/** 创建CellNode实例并初始化设置cell高度、cell类型、cell数据、cell是否唯一、是否强制刷新 **/
+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData isUnique:(BOOL)isUnique forceUpdate:(BOOL)forceUpdate;
/** 通过原始数据数组批量创建CellNode并将数据分别对应存入 **/
+ (NSArray<CellNode *> *)dividingCellNodeBySourceArray:(CGFloat)cellHeight cellClass:(Class)cellClass sourceArray:(NSArray*)sourceArray;

/** GYTableViewCell重用标示符，不填默认为CellClassName **/
@property (nonatomic, copy) NSString *cellIdentifer;
/** GYTableViewCell实例高度 **/
@property (nonatomic, assign) CGFloat cellHeight;
/** 用来实例化GYTableViewCell的自定义类型 **/
@property (nonatomic, strong) Class cellClass;
/** 传递给GYTableViewCell实例的数据，用来展示界面判断逻辑等，实例内部通过self.data属性获得 **/
@property (nonatomic, strong) id cellData;
/** 创建GYTableViewCell实例唯一，相当于单例，就算是相同类型的GYTableViewCell也是各自成为单例，且内容不会刷新(适合内容只初始化一次的界面) **/
@property (nonatomic, assign) BOOL isUnique;
/** isUnique设置为true的情况下 forceUpdate可以继续让单例GYTableViewCell中的内容强制刷新 **/
@property (nonatomic, assign) BOOL forceUpdate;
/** 自定义保留字段 **/
@property (nonatomic, copy) NSString *cellName;

@property (nonatomic, assign) BOOL isAutoHeight;

@end
