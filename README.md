# 自定义封装UITableView和MJRefresh相结合

特点:<br/>
1.将tableView常用的delegate和dataSource方法封装在内部处理，通过外部包装数据的方式展示相关内容，控制cell状态<br/>
2.cell内部根据传递的数据展示内容<br/>
3.内部自带MJRefresh框架，提供下拉刷新和上拉加载功能，外部暴露接口调用<br/>

用法:<br/>
此框架基于MJRefresh，所以务必先添加该framework，手动或者pod都可以，[使用方法](https://github.com/CoderMJLee/MJRefresh/)<br/>
请使用该框架中的元素来代替原生列表控件，对应关系如下:<br/>
```
MJTableBaseView -> UITableView
MJTableViewController -> UITableViewController
MJTableViewCell -> UITableViewCell
MJTableViewSection 原生使用UIView展示section内容，这里使用MJTableViewSection
```

使用时有列表控件的界面直接继承MJTableViewController，.h示例如下
```objc
#import "MJTableViewController.h"
@interface NormalTableViewController : MJTableViewController
@end
```
.m文件中重写headerRefresh添加元素，当自带的下拉刷新控件下拉时调用；从而开始列表内容层次搭建，以及各种类型的Cell位置如何摆放等
```objc
-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    //下拉刷新后开始请求后台提供数据，请求到数据后根据解析的内容展开cell实例和位置等操作，代码结构如下(伪代码)
    request{
        tableView{
            sectionVo{
                cellVo,
                cellVo,
                ...
            }
            sectionVo{
                cellVo,
                ...
            }
            ...
        }
        endRefreshHandler();//界面搭建完毕后停止刷新
    }
}
```

# MJTableBaseView.h
```objc
@interface MJTableBaseView : UITableView

/** 点中cell高亮 **/
@property (nonatomic,assign) BOOL clickCellHighlight;
/** 点中cell自动居中 **/
@property (nonatomic,assign) BOOL clickCellMoveToCenter;
/** 每一节间隔 **/
@property (nonatomic,assign) CGFloat sectionGap;
/** 每个条目间隔 **/
@property (nonatomic,assign) CGFloat cellGap;
/** 首次下拉 **/
@property (nonatomic,assign,readonly) BOOL hasFirstRefreshed;

/** 下拉刷新 **/
-(void)headerBeginRefresh;
/** 检查数据间隔 **/
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
-(void)reloadMJData;
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
```
# SectionVo
```objc
@interface SectionVo : NSObject

/** 创建SectionVo实例并初始化设置下一步回调 **/
+ (instancetype)initWithParams:(void(^)(SectionVo* svo))nextBlock;
/** 创建SectionVo实例并初始化设置section高度、section类型、section数据、下一步回调 **/
+ (instancetype)initWithParams:(CGFloat)sectionHeight sectionClass:(Class)sectionClass sectionData:(id)sectionData nextBlock:(void(^)(SectionVo* svo))nextBlock;
/** MJTableViewSection实例高度 **/
@property (nonatomic,assign)CGFloat sectionHeight;
/** 用来实例化MJTableViewSection的自定义类型 **/
@property (nonatomic,retain)Class sectionClass;
/** 传递给MJTableViewSection实例的数据，用来展示界面判断逻辑等，实例内部通过self.data属性获得 **/
@property (nonatomic,retain)id sectionData;

/** 该节包含的CellVo个数 **/
-(NSInteger)getCellVoCount;
/**  添加单个CellVo **/
-(void)addCellVo:(CellVo*)cellVo;
/**  批量添加CellVo **/
-(void)addCellVoByList:(NSArray<CellVo*>*)otherVoList;

@end
```
# CellVo
```objc
@interface CellVo : NSObject

/** 创建CellVo实例并初始化设置cell高度、cell类型、cell数据 **/
+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData;
/** 创建CellVo实例并初始化设置cell高度、cell类型、cell数据、cell是否唯一 **/
+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData isUnique:(BOOL)isUnique;
/** 创建CellVo实例并初始化设置cell高度、cell类型、cell数据、cell是否唯一、是否强制刷新 **/
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
```
# MJTableViewController.h
```objc
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
```
# MJTableBaseViewDelegate
```objc
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
```
# MJTableViewCell.h
```objc
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
```
# MJTableViewSection.h
```objc
@interface MJTableViewSection : UIControl

/** tableView所有section总数  **/
@property(nonatomic,assign)NSInteger sectionCount;
/** 当前section索引位置  **/
@property(nonatomic,assign)NSInteger sectionIndex;
/** 外部传入的数据 用来布局或交互等（sectionVo.sectionData） **/
@property(nonatomic,retain)id data;
/** 是否在整个tableView的首位 **/
@property(nonatomic,assign)BOOL isFirst;
/** 是否在整个tableView的末位 **/
@property(nonatomic,assign)BOOL isLast;

@end
```

# 调用示例1
### 列表控制器内部实现
```objc
-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
        //添加一个高度为230，类型为BannerViewCell，展示"banner.jpg"图片的Cell
        [svo addCellVo:[CellVo initWithParams:230 cellClass:BannerViewCell.class cellData:@"banner.jpg"]];
    }];
    endRefreshHandler(YES);//不要忘了结束刷新，否则刷新动画会停留原地
}
```
### BannerViewCell.h 继承MJTableViewCell
```objc
#import "MJTableViewCell.h"
@interface BannerViewCell : MJTableViewCell
@end
```
### BannerViewCell.m
```objc
//页面元素创建并布局 这里bannerImageView通过懒加载方式创建，具体实现不赘述
-(void)showSubviews{
    NSString* imageName = self.data;//获取CellVo中传的cellData（@"banner.jpg"）
    self.bannerImageView.image = [UIImage imageNamed:imageName];
    self.bannerImageView.frame = self.contentView.bounds;//占满整个Cell空间
}
```
![示例效果1](https://github.com/gaoyangclub/MJTableViewController/blob/master/MJTableViewController/assetes/example/demo1.gif)

# 调用示例2
### 列表控制器内部实现
```objc
-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
        //添加一个高度为230，类型为BannerViewCell，展示"banner.jpg"图片的Cell
        [svo addCellVo:[CellVo initWithParams:230 cellClass:BannerViewCell.class cellData:@"banner.jpg"]];
        //添加三个高度为50，类型为ProductViewCell，展示用户信息的Cell
        [svo addCellVo:[CellVo initWithParams:50 cellClass:ProductViewCell.class cellData:@"老李同志"]];
        [svo addCellVo:[CellVo initWithParams:50 cellClass:ProductViewCell.class cellData:@"老刘同志"]];
        [svo addCellVo:[CellVo initWithParams:50 cellClass:ProductViewCell.class cellData:@"老郑同志"]];
    }]];
    endRefreshHandler(YES);//不要忘了结束刷新，否则刷新动画会停留原地
}
```
### ProductViewCell.h 继承MJTableViewCell;ProductViewCell.m如下
```objc
-(void)showSubviews{
    CGFloat const iconWidth = 40;
    self.imageView.image = [UIImage imageNamed:@"fundHot12"];//显示图标 也可以通过data传入
    self.imageView.frame = CGRectMake(30, (CGRectGetHeight(self.contentView.bounds) - iconWidth) / 2., iconWidth, iconWidth);
    self.textLabel.text = self.data;//这里data只传入用户姓名
}
```
### 相同类型的Cell添加可以修改成通过原数组批量添加
```objc
-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
        //添加一个高度为230，类型为BannerViewCell，展示"banner.jpg"图片的Cell
        [svo addCellVo:[CellVo initWithParams:230 cellClass:BannerViewCell.class cellData:@"banner.jpg"]];
        
        NSArray* sourceArray = @[@"老李同志",@"老刘同志",@"老郑同志"];
        //按照数组结构的数据遍历后批量创建cell实例，数据分别传递给创建的cell实例
        [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:50 cellClass:ProductViewCell.class sourceArray:sourceArray]];
    }]];
    endRefreshHandler(YES);//不要忘了结束刷新，否则刷新动画会停留原地
}
```
