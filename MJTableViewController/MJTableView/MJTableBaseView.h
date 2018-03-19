//
//  MJTableBaseView.h
//  MJRefreshTest
//
//  Created by admin on 16/10/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "MJTableViewCell.h"
#import "MJTableViewSection.h"

#import "MJRefreshComponent+GY.h"


@class CellVo;
@class SectionVo;
@class MJTableBaseView;

/** 下拉刷新或上拉加载调用结束Block hasData标注界面是否刷新出了新的数据  **/
typedef void(^HeaderRefreshHandler)(BOOL hasData);
typedef void(^FooterLoadMoreHandler)(BOOL hasData);

@protocol MJTableBaseViewDelegate<NSObject>

@optional
/** 当MJTableBaseView下拉刷新时代理调用 **/
-(void)headerRefresh:(MJTableBaseView*)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler;
@optional
/** 当MJTableBaseView上拉加载时代理调用 **/
-(void)footerLoadMore:(MJTableBaseView*)tableView endLoadMoreHandler:(FooterLoadMoreHandler)endLoadMoreHandler lastSectionVo:(SectionVo*)lastSectionVo;
@optional
/** 当MJTableBaseView某一条MJTableViewCell实例被点击时代理调用 **/
-(void)didSelectRow:(MJTableBaseView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
/** 当MJTableBaseView滚动到某个位置时代理调用 **/
-(void)didScrollToRow:(MJTableBaseView*)tableView indexPath:(NSIndexPath *)indexPath;
@optional
/** 当MJTableBaseView从滚动状态静止时代理调用 **/
-(void)didEndScrollingAnimation:(MJTableBaseView*)tableView;
@optional
/** 当MJTableBaseView下拉刷新完毕后代理调用 **/
-(void)didRefreshComplete:(MJTableBaseView*)tableView;
@optional
/** 当MJTableBaseView上拉加载完毕后代理调用 **/
-(void)didLoadMoreComplete:(MJTableBaseView*)tableView;

@end


@interface MJTableBaseView : UITableView

-(instancetype)init __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));
+(instancetype)new __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));
-(instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));
-(instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style __attribute__((unavailable("Disabled. Use -initWithFrameAndParams instead")));

-(instancetype)initWithFrameAndParams:(CGRect)frame showHeader:(BOOL)showHeader showFooter:(BOOL)showFooter useCellIdentifer:(BOOL)useCellIdentifer topEdgeDiverge:(BOOL)topEdgeDiverge;
-(instancetype)initWithFrameAndParams:(CGRect)frame style:(UITableViewStyle)style showHeader:(BOOL)showHeader showFooter:(BOOL)showFooter useCellIdentifer:(BOOL)useCellIdentifer topEdgeDiverge:(BOOL)topEdgeDiverge;

@property(nonatomic,retain,readonly)NSMutableArray<SectionVo*>* dataSourceArray;

@property (nonatomic, weak) id<MJTableBaseViewDelegate> refreshDelegate;
//@property (nonatomic,assign) BOOL refreshAll;

@property(nonatomic,retain) MJRefreshHeader* header;

@property(nonatomic,retain) NSIndexPath* selectedIndexPath;

//@property (nonatomic,assign) BOOL pureTable;

/**
 *  点中cell高亮
 */
@property (nonatomic,assign) BOOL clickCellHighlight;
/**
 *  点中cell自动居中
 */
@property (nonatomic,assign) BOOL clickCellMoveToCenter;
/**
 *  每一节间隔
 */
@property (nonatomic,assign) CGFloat sectionGap;
/**
 *  每个条目间隔
 */
@property (nonatomic,assign) CGFloat cellGap;
/**
 *  首次下拉
 */
@property (nonatomic,assign,readonly) BOOL hasFirstRefreshed;
/**
 *  代码下拉刷新
 */
-(void)headerBeginRefresh;
/**
 *  检查数据间隔
 */
-(void)checkGaps;
/**
 *  清除所有数据
 */
-(void)clearAllSectionVo;
/**
 *  添加一节内容
 */
-(void)addSectionVo:(SectionVo*)sectionVo;
/**
 *  在某个索引插入一节内容
 */
-(void)insertSectionVo:(SectionVo*)sectionVo atIndex:(NSInteger)index;
/**
 *  删除一节内容
 */
-(void)removeSectionVoAt:(NSInteger)index;
/**
 *  重新刷新全部界面 类似源生的reloadData
 */
-(void)reloadMJData;
/**
 *  将选中的数据项平滑居中移动
 */
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

@interface SectionVo : NSObject

+ (instancetype)initWithParams:(void(^)(SectionVo* svo))nextBlock;

+ (instancetype)initWithParams:(CGFloat)sectionHeight sectionClass:(Class)sectionClass sectionData:(id)sectionData nextBlock:(void(^)(SectionVo* svo))nextBlock;

//+ (instancetype)initWithParams:(CGFloat)sectionHeight sectionClass:(Class)sectionClass sectionData:(id)sectionData isUnique:(BOOL)isUnique nextBlock:(void(^)(SectionVo* svo))nextBlock;

/** MJTableViewSection实例高度 **/
@property (nonatomic,assign)CGFloat sectionHeight;
/** 用来实例化MJTableViewSection的自定义类型 **/
@property (nonatomic,retain)Class sectionClass;
/** 传递给MJTableViewSection实例的数据，用来展示界面判断逻辑等，实例内部通过self.data属性获得 **/
@property (nonatomic,retain)id sectionData;
//@property (nonatomic,assign)BOOL isUnique;//预留该功能

/** 该节包含的CellVo个数 **/
-(NSInteger)getCellVoCount;

/**  添加单个CellVo **/
-(void)addCellVo:(CellVo*)cellVo;
/**  批量添加CellVo **/
-(void)addCellVoByList:(NSArray<CellVo*>*)otherVoList;

@end

@interface CellVo : NSObject

+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData;
+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData isUnique:(BOOL)isUnique;
+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData isUnique:(BOOL)isUnique forceUpdate:(BOOL)forceUpdate;

/** 通过原始数据数组批量创建CellVo并将数据分别对应存入 **/
+(NSArray<CellVo*>*)dividingCellVoBySourceArray:(CGFloat)cellHeight cellClass:(Class)cellClass sourceArray:(NSArray*)sourceArray;

/** MJTableViewCell实例高度 **/
@property (nonatomic,assign)CGFloat cellHeight;
/** 用来实例化MJTableViewCell的自定义类型 **/
@property (nonatomic,retain)Class cellClass;
/** 传递给MJTableViewCell实例的数据，用来展示界面判断逻辑等，实例内部通过self.data属性获得 **/
@property (nonatomic,retain)id cellData;
/** 创建MJTableViewCell实例唯一，相当于单例，就算是相同类型的MJTableViewCell也是各自成为单例，且内容不会刷新(适合内容只初始化一次的界面) **/
@property (nonatomic,assign)BOOL isUnique;
/** isUnique设置为true的情况下 forceUpdate可以继续让单例MJTableViewCell中的内容强制刷新 **/
@property (nonatomic,assign)BOOL forceUpdate;
/** 自定义保留字段 **/
@property (nonatomic,copy)NSString* cellName;

@end
