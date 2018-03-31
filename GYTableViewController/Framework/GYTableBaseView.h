//
//  GYTableBaseView.h
//  GYTableViewController
//
//  Created by 高扬 on 16/10/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "GYTableViewCell.h"
#import "GYTableViewSection.h"

#import "MJRefreshComponent+GY.h"


@class CellVo;
@class SectionVo;
@class GYTableBaseView;

/** 下拉刷新或上拉加载调用结束Block hasData标注界面是否刷新出了新的数据  **/
typedef void(^HeaderRefreshHandler)(BOOL hasData);
typedef void(^FooterLoadMoreHandler)(BOOL hasData);

@protocol GYTableBaseViewDelegate<UITableViewDelegate,UITableViewDataSource>

@optional
/** 当GYTableBaseView下拉刷新时代理调用 **/
-(void)headerRefresh:(GYTableBaseView*)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler;
@optional
/** 当GYTableBaseView上拉加载时代理调用 **/
-(void)footerLoadMore:(GYTableBaseView*)tableView endLoadMoreHandler:(FooterLoadMoreHandler)endLoadMoreHandler lastSectionVo:(SectionVo*)lastSectionVo;
@optional
/** 当GYTableBaseView下拉刷新完毕后代理调用 **/
-(void)didRefreshComplete:(GYTableBaseView*)tableView;
@optional
/** 当GYTableBaseView上拉加载完毕后代理调用 **/
-(void)didLoadMoreComplete:(GYTableBaseView*)tableView;
@optional
/** 当GYTableBaseView某一条GYTableViewCell实例被点击时代理调用 **/
-(void)tableView:(GYTableBaseView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
/** 当GYTableBaseView滚动到某个位置时代理调用 **/
-(void)didScrollToRow:(GYTableBaseView*)tableView indexPath:(NSIndexPath *)indexPath;
@optional
/** 当GYTableBaseView从滚动状态静止时代理调用 **/
-(void)didEndScrollingAnimation:(GYTableBaseView*)tableView;


/** 以下方法不可代理调用  **/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView __attribute__((unavailable("Disabled")));
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section __attribute__((unavailable("Disabled")));
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section __attribute__((unavailable("Disabled")));
@optional
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section __attribute__((unavailable("Disabled")));
@optional
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath __attribute__((unavailable("Disabled")));
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath __attribute__((unavailable("Disabled")));
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section __attribute__((unavailable("Disabled")));
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section __attribute__((unavailable("Disabled")));
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section __attribute__((unavailable("Disabled")));
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section __attribute__((unavailable("Disabled")));
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath __attribute__((unavailable("Disabled")));
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath __attribute__((unavailable("Disabled")));


@end


@interface GYTableBaseView : UITableView

-(instancetype)init __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));
+(instancetype)new __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));
-(instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));
-(instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));

-(instancetype)initWithFrameAndParams:(CGRect)frame showHeader:(BOOL)showHeader showFooter:(BOOL)showFooter useCellIdentifer:(BOOL)useCellIdentifer topEdgeDiverge:(BOOL)topEdgeDiverge;
-(instancetype)initWithFrameAndParams:(CGRect)frame style:(UITableViewStyle)style showHeader:(BOOL)showHeader showFooter:(BOOL)showFooter useCellIdentifer:(BOOL)useCellIdentifer topEdgeDiverge:(BOOL)topEdgeDiverge;

@property(nonatomic,retain,readonly)NSMutableArray<SectionVo*>* dataSourceArray;

@property (nonatomic, weak) id<GYTableBaseViewDelegate> refreshDelegate;
//@property (nonatomic,assign) BOOL refreshAll;
@property(nonatomic,retain) MJRefreshHeader* header;

/** 设置选中位置 **/
@property(nonatomic,retain) NSIndexPath* selectedIndexPath;
/** 点中cell高亮 **/
@property (nonatomic,assign) BOOL clickCellHighlight;
/** 点中cell自动居中 **/
@property (nonatomic,assign) BOOL clickCellMoveToCenter;
/** 每一节间距 **/
@property (nonatomic,assign) CGFloat sectionGap;
/** 每个cell间距 **/
@property (nonatomic,assign) CGFloat cellGap;
/** 首次下拉 **/
@property (nonatomic,assign,readonly) BOOL hasFirstRefreshed;

/** 下拉刷新 **/
-(void)headerBeginRefresh;
/** 检查数据间距 **/
-(void)checkGaps;
/** 清除所有数据 **/
-(void)clearAllSectionVo;
/** 添加一节内容 **/
-(void)addSectionVo:(SectionVo*)sectionVo;
/** 在某个索引插入一节内容 **/
-(void)insertSectionVo:(SectionVo*)sectionVo atIndex:(NSInteger)index;
/** 删除一节内容 **/
-(void)removeSectionVoAt:(NSInteger)index;
/** 重新刷新全部界面 类似源生的reloadData **/
-(void)reloadGYData;
/** 将选中的数据项平滑居中移动 **/
-(void)moveSelectedIndexPathToCenter;

/** 获取最后一个SectionVo **/
-(SectionVo*)getLastSectionVo;
/** 获取第一个SectionVo **/
-(SectionVo*)getFirstSectionVo;
/** 获取目标索引位置SectionVo **/
-(SectionVo*)getSectionVoByIndex:(NSInteger)index;
/** 获取目标indexPath位置CellVo **/
-(CellVo*)getCellVoByIndexPath:(NSIndexPath*)indexPath;
/** 获取SectionVo总数 **/
-(NSUInteger)getSectionVoCount;
/** 获取CellVo总数 所有SectionVo包含的CellVo总和 **/
-(NSUInteger)getTotalCellVoCount;

@end

//一节的标题头数据
@interface SectionVo : NSObject

/** 创建SectionVo实例并初始化设置下一步回调 **/
+ (instancetype)initWithParams:(void(^)(SectionVo* svo))nextBlock;
/** 创建SectionVo实例并初始化设置section页眉高度、section页眉类型、section页眉数据、下一步回调 **/
+ (instancetype)initWithParams:(CGFloat)sectionHeaderHeight sectionHeaderClass:(Class)sectionHeaderClass sectionHeaderData:(id)sectionHeaderData nextBlock:(void(^)(SectionVo* svo))nextBlock;
/** 创建SectionVo实例并初始化设置section页眉高度、section页眉类型、section页眉数据、section页脚高度、section页脚类型、section页脚数据、下一步回调 **/
+ (instancetype)initWithParams:(CGFloat)sectionHeaderHeight sectionHeaderClass:(Class)sectionHeaderClass sectionHeaderData:(id)sectionHeaderData sectionFooterHeight:(CGFloat)sectionFooterHeight sectionFooterClass:(Class)sectionFooterClass sectionFooterData:(id)sectionFooterData nextBlock:(void(^)(SectionVo* svo))nextBlock;

/** GYTableViewSection页眉实例高度 **/
@property (nonatomic,assign)CGFloat sectionHeaderHeight;
/** 用来实例化GYTableViewSection页眉的自定义类型 **/
@property (nonatomic,retain)Class sectionHeaderClass;
/** 传递给GYTableViewSection页眉实例的数据，用来展示界面判断逻辑等，实例内部通过self.data属性获得 **/
@property (nonatomic,retain)id sectionHeaderData;

/** GYTableViewSection页脚实例高度 **/
@property (nonatomic,assign)CGFloat sectionFooterHeight;
/** 用来实例化GYTableViewSection页脚的自定义类型 **/
@property (nonatomic,retain)Class sectionFooterClass;
/** 传递给GYTableViewSection页脚实例的数据，用来展示界面判断逻辑等，实例内部通过self.data属性获得 **/
@property (nonatomic,retain)id sectionFooterData;

/** 该节包含的CellVo个数 **/
-(NSInteger)getCellVoCount;
/**  添加单个CellVo **/
-(void)addCellVo:(CellVo*)cellVo;
/**  批量添加CellVo **/
-(void)addCellVoByList:(NSArray<CellVo*>*)otherVoList;

@end

#define CELL_AUTO_HEIGHT 0

@interface CellVo : NSObject

/** 创建CellVo实例并初始化设置cell高度、cell类型、cell数据 **/
+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData;
/** 创建CellVo实例并初始化设置cell高度、cell类型、cell数据、cell是否唯一 **/
+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData isUnique:(BOOL)isUnique;
/** 创建CellVo实例并初始化设置cell高度、cell类型、cell数据、cell是否唯一、是否强制刷新 **/
+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData isUnique:(BOOL)isUnique forceUpdate:(BOOL)forceUpdate;
/** 通过原始数据数组批量创建CellVo并将数据分别对应存入 **/
+(NSArray<CellVo*>*)dividingCellVoBySourceArray:(CGFloat)cellHeight cellClass:(Class)cellClass sourceArray:(NSArray*)sourceArray;

/** GYTableViewCell实例高度 **/
@property (nonatomic,assign)CGFloat cellHeight;
/** 用来实例化GYTableViewCell的自定义类型 **/
@property (nonatomic,retain)Class cellClass;
/** 传递给GYTableViewCell实例的数据，用来展示界面判断逻辑等，实例内部通过self.data属性获得 **/
@property (nonatomic,retain)id cellData;
/** 创建GYTableViewCell实例唯一，相当于单例，就算是相同类型的GYTableViewCell也是各自成为单例，且内容不会刷新(适合内容只初始化一次的界面) **/
@property (nonatomic,assign)BOOL isUnique;
/** isUnique设置为true的情况下 forceUpdate可以继续让单例GYTableViewCell中的内容强制刷新 **/
@property (nonatomic,assign)BOOL forceUpdate;
/** 自定义保留字段 **/
@property (nonatomic,copy)NSString* cellName;

@property (nonatomic,assign)BOOL isAutoHeight;

@end
