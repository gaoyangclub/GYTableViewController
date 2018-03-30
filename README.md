* 如何开始
    *  [项目技术特点](#技术特点)<br/>
    *  [框架用法](#框架用法)<br/>
* 代码结构
    *  [MJTableBaseView.h](#mjtable-base-view)
    *  [MJTableViewController.h](#mjtable-view-controller)
    *  [MJTableViewCell.h](#mjtable-view-cell)
    *  [MJTableViewSection.h](#mjtable-view-section)
    *  [SectionVo](#section-vo)
    *  [CellVo](#cell-vo)
    *  [MJTableBaseViewDelegate](#mjtable-base-view-delegate)
* 使用示例
    *  [如何添加Cell](#添加cell)
    *  [批量添加Cell](#批量添加cell)
    *  [如何添加Section](#添加section)
    *  [如何让Cell实例唯一](#isunique唯一性)
    *  [如何上拉加载更多](#调用上拉加载)
    *  [如何修改UITableView位置](#更改ui-tableView的frame)
    *  [如何修改下拉刷新控件](#自定义下拉刷新控件)
    *  [如何侦听选中的Cell](#侦听选中的cell)
    *  [如何设置Cell间距](#设置cell或section元素间距)
    *  [如何代码设置选中位置并高亮](#设置选中某个位置的cell)
    *  [如何交互点击选中位置并高亮](#设置交互点击某个位置cell并高亮)
    *  [如何交互点击选中位置并自动居中](#设置点击cell自动居中)
    *  [如何根据动态内容调整Cell高度](#cell自动调整高度)


# 技术特点
1.Section和Cell层次更加清晰，根据传入的Section数据结构内部已经全部实现Section和Cell相关delegate方法<br/>
2.Cell实例可获得外部动态数据，索引位置，上下关系，选中状态等，随时更换样式<br/>
3.Controller自带MJRefresh框架，提供下拉刷新和上拉加载功能，外部暴露接口调用<br/>
4.提供Cell，Section间距设置，提供选中行高亮、选中行自动居中，提供设置Cell动态高度设置等API<br/>
5.框架中的元素全部继承于原生的tableView相关元素，除部分代理方法外，其他原生方法扔然可以使用<br/>

# 框架用法
此框架基于MJRefresh，所以务必先添加该framework，手动或者pod都可以，<a href="https://github.com/CoderMJLee/MJRefresh/" target="_blank">使用方法</a><br/>
请使用该框架中的元素来代替原生列表控件，对应关系如下:<br/>
```
MJTableBaseView -> UITableView
MJTableViewController -> UITableViewController
MJTableViewCell -> UITableViewCell
MJTableViewSection 原生使用UIView展示section内容，这里使用MJTableViewSection
SectionVo 用来设置Section样式与MJTableViewSection实例绑定
CellVo 用来设置Cell样式与MJTableViewCell实例绑定
```

使用时有列表控件的界面直接继承MJTableViewController，.h示例如下
```objc
#import "MJTableViewController.h"
@interface NormalTableViewController : MJTableViewController
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
Cell控件直接继承MJTableViewCell，.h示例如下
```objc
#import "MJTableViewCell.h"
@interface NormalViewCell : MJTableViewCell
```
.m文件中重写showSubviews方法进行布局，利用GET_CELL_DATA或GET_CELL_ARRAY_DATA宏来获取列表控件中传入的数据，如传入非数组型的数据使用GET_CELL_DATA，反之使用GET_CELL_ARRAY_DATA
```objc
-(void)showSubviews{
    GET_CELL_DATA([xxx class]);//先获取外部传入的数据
    GET_CELL_ARRAY_DATA([xxx class]);//或者获取数组类型的数据

    //开始界面布局...
}
```
<a name="mjtable-base-view"></a>
# MJTableBaseView.h
```objc
@interface MJTableBaseView : UITableView

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
<a name="section-vo"></a>
# SectionVo
```objc
@interface SectionVo : NSObject

/** 创建SectionVo实例并初始化设置下一步回调 **/
+ (instancetype)initWithParams:(void(^)(SectionVo* svo))nextBlock;
/** 创建SectionVo实例并初始化设置section页眉高度、section页眉类型、section页眉数据、下一步回调 **/
+ (instancetype)initWithParams:(CGFloat)sectionHeaderHeight sectionHeaderClass:(Class)sectionHeaderClass sectionHeaderData:(id)sectionHeaderData nextBlock:(void(^)(SectionVo* svo))nextBlock;
/** 创建SectionVo实例并初始化设置section页眉高度、section页眉类型、section页眉数据、section页脚高度、section页脚类型、section页脚数据、下一步回调 **/
+ (instancetype)initWithParams:(CGFloat)sectionHeaderHeight sectionHeaderClass:(Class)sectionHeaderClass sectionHeaderData:(id)sectionHeaderData sectionFooterHeight:(CGFloat)sectionFooterHeight sectionFooterClass:(Class)sectionFooterClass sectionFooterData:(id)sectionFooterData nextBlock:(void(^)(SectionVo* svo))nextBlock;

/** MJTableViewSection页眉实例高度 **/
@property (nonatomic,assign)CGFloat sectionHeaderHeight;
/** 用来实例化MJTableViewSection页眉的自定义类型 **/
@property (nonatomic,retain)Class sectionHeaderClass;
/** 传递给MJTableViewSection页眉实例的数据，用来展示界面判断逻辑等，实例内部通过self.data属性获得 **/
@property (nonatomic,retain)id sectionHeaderData;

/** MJTableViewSection页脚实例高度 **/
@property (nonatomic,assign)CGFloat sectionFooterHeight;
/** 用来实例化MJTableViewSection页脚的自定义类型 **/
@property (nonatomic,retain)Class sectionFooterClass;
/** 传递给MJTableViewSection页脚实例的数据，用来展示界面判断逻辑等，实例内部通过self.data属性获得 **/
@property (nonatomic,retain)id sectionFooterData;

/** 该节包含的CellVo个数 **/
-(NSInteger)getCellVoCount;
/**  添加单个CellVo **/
-(void)addCellVo:(CellVo*)cellVo;
/**  批量添加CellVo **/
-(void)addCellVoByList:(NSArray<CellVo*>*)otherVoList;

@end
```
<a name="cell-vo"></a>
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
<a name="mjtable-view-controller"></a>
# MJTableViewController.h
```objc
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

@end
```
<a name="mjtable-base-view-delegate"></a>
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
/** 当MJTableBaseView下拉刷新完毕后代理调用 **/
-(void)didRefreshComplete:(MJTableBaseView*)tableView;
@optional
/** 当MJTableBaseView上拉加载完毕后代理调用 **/
-(void)didLoadMoreComplete:(MJTableBaseView*)tableView;
@optional
/** 当MJTableBaseView某一条MJTableViewCell实例被点击时代理调用 **/
-(void)tableView:(MJTableBaseView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
/** 当MJTableBaseView滚动到某个位置时代理调用 **/
-(void)didScrollToRow:(MJTableBaseView*)tableView indexPath:(NSIndexPath *)indexPath;
@optional
/** 当MJTableBaseView从滚动状态静止时代理调用 **/
-(void)didEndScrollingAnimation:(MJTableBaseView*)tableView;

@end
```
<a name="mjtable-view-cell"></a>
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

@end
```
<a name="mjtable-view-section"></a>
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
<a name="添加cell"></a>
# 添加Cell
### 列表控制器内部实现
```objc
-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
        //添加一个高度为230，类型为BannerViewCell，展示banner图片列表的Cell
        [svo addCellVo:[CellVo initWithParams:230 cellClass:RefreshBannerViewCell.class cellData:self.bannerUrlGroup]];
    }]];
    endRefreshHandler(YES);//不要忘了结束刷新，否则刷新动画会停留原地
}
```
![案例1-1](https://images2018.cnblogs.com/blog/1356734/201803/1356734-20180329193706057-540438886.gif)

<a name="批量添加cell"></a>
# 批量添加Cell
### 列表控制器内部实现
```objc
-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
        //添加一个高度为230，类型为BannerViewCell，展示banner图片列表的Cell
        [svo addCellVo:[CellVo initWithParams:230 cellClass:RefreshBannerViewCell.class cellData:self.bannerUrlGroup]];
    }]];
    //注意banner和基金产品列表属于不同区域，应存放到各自section中添加，管理section视图会比较方便
    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
        //添加多个高度为80，类型为RefreshFundViewCell，展示基金信息的Cell
        [svo addCellVo:[CellVo initWithParams:80 cellClass:RefreshFundViewCell.class cellData:self.fundModels[0]]];
        [svo addCellVo:[CellVo initWithParams:80 cellClass:RefreshFundViewCell.class cellData:self.fundModels[1]]];
        [svo addCellVo:[CellVo initWithParams:80 cellClass:RefreshFundViewCell.class cellData:self.fundModels[2]]];
        //...
    }]];
    endRefreshHandler(YES);//不要忘了结束刷新，否则刷新动画会停留原地
}
```
### 相同类型的Cell添加可以修改成通过原数组批量添加
```objc
[tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
    //添加多个高度为80，类型为RefreshFundViewCell，展示基金信息的Cell
    [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:80 cellClass:RefreshFundViewCell.class sourceArray:self.fundModels]];
}]];
```
![案例1-2](https://images2018.cnblogs.com/blog/1356734/201803/1356734-20180329193736678-1640767410.gif)

<a name="添加section"></a>
# 添加Section
### 如果一节内容需要添加section页眉视图，只要在sectionVo实例设置sectionHeaderClass即可，同理section页脚设置sectionFooterClass
```objc
-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    [tableView addSectionVo:[SectionVo initWithParams:36 sectionHeaderClass:RefreshFundViewSection.class sectionHeaderData:@"精品专区" nextBlock:^(SectionVo *svo) {
        //添加section内的cell...
    }]];
    endRefreshHandler(YES);
}
```
### 分类结构如下
![静态图](https://images2018.cnblogs.com/blog/1356734/201803/1356734-20180329191308248-1915487102.png) <br/>
![案例1-3](https://images2018.cnblogs.com/blog/1356734/201803/1356734-20180330113229571-424878319.gif)

<a name="isunique唯一性"></a>
# isUnique唯一性
默认所有相同Class的Cell实例都是相互复用，每次下拉刷新或者table设置reloadData，被复用的Cell实例都会重新触发刷新调用showSubviews，从而根据传递的data展开；然而，一些特殊的Cell不需要复用或只实例化一次，比如标签按钮区域的Cell或者banner区域的Cell，每次下拉都是只用这个实例，可以设置为isUnique作为唯一Cell实例优化提高性能
```objc
-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
       //添加一个高度为230，类型为BannerViewCell，展示banner图片列表的Cell
        [svo addCellVo:[CellVo initWithParams:230 cellClass:RefreshBannerViewCell.class cellData:self.bannerUrlGroup isUnique:YES]];
        //添加一个高度为90，类型为RefreshHotViewCell，展示banner图片列表的Cell
        [svo addCellVo:[CellVo initWithParams:90 cellClass:RefreshHotViewCell.class cellData:self.hotModels isUnique:YES]];
    }]];
    endRefreshHandler(YES);
}
```

# 调用上拉加载
### 列表控制器内部设置显示上拉加载控制器
```objc
-(BOOL)isShowFooter{
    return YES;
}
```
### 列表控制器内部重写footerLoadMore
```objc
//endLoadMoreHandler:结束刷新回调block,lastSectionVo:上一节sectionVo数据，即当前列表页最后一节
-(void)footerLoadMore:(MJTableBaseView *)tableView endLoadMoreHandler:(FooterLoadMoreHandler)endLoadMoreHandler lastSectionVo:(SectionVo *)lastSectionVo{
    [lastSectionVo addCellVoByList:[CellVo dividingCellVoBySourceArray:80 cellClass:RefreshFundViewCell.class sourceArray:self.fundNewModels]];//将新增的CellVo实例继续添加到上一节SectionVo实例中
    endLoadMoreHandler(YES);
}
```
### 根据需求添加到列表页最后一节，或者添加到新的一节数据中，并设置添加上限
```objc
if([tableView getTotalCellVoCount] > 30){//总共超出30条数据不添加数据
    endLoadMoreHandler(NO);//直接结束上拉加载刷新，并显示"已经全部加载完毕"
    return;
}
//根据业务需求的不同，可以继续添加到上一节sectionVo，也可以添加到新的一节sectionVo中
if([lastSectionVo getCellVoCount] < 15){//上一节少于15条继续添加到上一节sectionVo
    [lastSectionVo addCellVoByList:[CellVo dividingCellVoBySourceArray:80 cellClass:RefreshFundViewCell.class sourceArray:self.fundNewModels]];
}else{//上一节超了 添加到新的一节sectionVo
    [tableView addSectionVo:[SectionVo initWithParams:36 sectionHeaderClass:RefreshFundViewSection.class sectionHeaderData:@"推荐专区" nextBlock:^(SectionVo *svo) {
        [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:80 cellClass:RefreshFundViewCell.class sourceArray:self.fundNewModels]];
    }]];
}
endLoadMoreHandler(YES);//不要忘了结束上拉加载刷新
```
![案例1-4](https://images2018.cnblogs.com/blog/1356734/201803/1356734-20180330125420770-895910655.gif)

<a name="更改ui-tableView的frame"></a>
# 更改UITableView的frame
### 列表控制器内部重写getTableViewFrame
如存在和容器底部对齐的元素，请在此方法对齐底部位置(默认占满controller边界)；autoLayerout无需重写此方法，自行设置tableView和其他元素布局关系
```objc
-(CGRect)getTableViewFrame{
    self.noticeBack.frame = CGRectMake(0, 0, self.view.width, 30);
    self.submitButton.maxY = self.view.height;//底部按钮对齐容器底部
    //返回设置好的tableView位置frame 高度=总高度-公告区高-底部按钮高
    return CGRectMake(0, self.noticeBack.height, self.view.width, self.view.height - self.noticeBack.height - self.submitButton.height);
}
```
![案例2-1](https://images2018.cnblogs.com/blog/1356734/201803/1356734-20180330134633439-2144359463.gif)

# 自定义下拉刷新控件
### 列表控制器内部重写getRefreshHeader
```objc
-(MJRefreshHeader *)getRefreshHeader{
    return [[DiyRotateRefreshHeader alloc]init];
}
```
![案例2-2](https://images2018.cnblogs.com/blog/1356734/201803/1356734-20180330112718771-789334939.gif)

<a name="侦听选中的cell"></a>
# 侦听选中的Cell
### 列表控制器内部实现代理，原生的方法一致
```objc
-(void)tableView:(MJTableBaseView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CellVo* cvo = [tableView getCellVoByIndexPath:indexPath];//获取到绑定的CellVo
    //...
}
```
### 设置cell点击效果，cell实例内部重写showSelectionStyle
```objc
-(BOOL)showSelectionStyle{
    return YES;
}
```
![案例2-3](https://images2018.cnblogs.com/blog/1356734/201803/1356734-20180330112705665-822050745.gif)

<a name="设置cell或section元素间距"></a>
# 设置Cell或Section元素间距
### 列表控制器内部设置tableView属性cellGap或sectionGap
```objc
- (void)viewDidLoad {
    self.tableView.sectionGap = 6;//设置每一节区域之间间距
    self.tableView.cellGap = 3;//设置每个Cell之间间距(包含每一节区域)
}
```
![案例3-1](https://images2018.cnblogs.com/blog/1356734/201803/1356734-20180330125032511-1083797657.gif)

<a name="设置选中某个位置的cell"></a>
# 设置选中某个位置的Cell
### 当刷新完成后设置，列表控制器内部设置tableView属性selectedIndexPath
```objc
-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
     [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
        //..添加cell数据
     }]];
     tableView.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];//设置选中某个indexPath
     endRefreshHandler(YES);    
}
```
### Cell实例设置选中效果，重写setSelected方法，选中样式请根据需求自行添加
```objc
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self checkCellRelate];//自定义选中样式方法，非框架内部方法，实现如下
}
```
### Cell实例位置关系isFirst，isLast，位于第一个或最后一个和中间段的Cell样式不同
```objc
-(void)checkCellRelate{
    if (self.isFirst) {
        [self drawFirstStyle:nodeColor];
    }else if(self.isLast){
        [self drawLastStyle:nodeColor];
    }else{
        [self drawNormalStyle:nodeColor];
    }
}
```
![案例4-1](https://images2018.cnblogs.com/blog/1356734/201803/1356734-20180329202557199-79046014.gif)

<a name="设置交互点击某个位置cell并高亮"></a>
# 设置交互点击某个位置Cell并高亮
```objc
- (void)viewDidLoad {
    self.tableView.clickCellHighlight = YES;
}
```
![案例4-2](https://images2018.cnblogs.com/blog/1356734/201803/1356734-20180330125441581-812210708.gif)

<a name="设置点击cell自动居中"></a>
# 设置点击Cell自动居中
```objc
- (void)viewDidLoad {
    self.tableView.clickCellMoveToCenter = YES;
}
```
![案例4-3](https://images2018.cnblogs.com/blog/1356734/201803/1356734-20180329202654311-1573826271.gif)

<a name="cell自动调整高度"></a>
# Cell自动调整高度
### 列表控制器内部设置CellVo传入高度CELL_AUTO_HEIGHT
```objc
-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
     [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
         [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:CELL_AUTO_HEIGHT cellClass:AutoHeightWeiboCell.class sourceArray:self.weiboModels]];
     }]];
     endRefreshHandler(YES);  
}
```
### Cell实例重写getCellHeight方法获取动态高度，获取高度内容会被缓存不会二次计算
```objc
-(CGFloat)getCellHeight:(CGFloat)cellWidth{
    WeiboModel* weiboModel = GET_CELL_DATA(WeiboModel.class);//获取Model
    NSString* content = weiboModel.content;//获取动态内容字符串
    CGRect contentSize = [content boundingRectWithSize:CGSizeMake(cellWidth - LEFT_PADDING - RIGHT_PADDING, FLT_MAX)
                             options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SIZE_TEXT_SECONDARY]}
                             context:nil];//计算给定范围内最佳尺寸
    return TOPIC_AREA_HEIGHT + contentSize.size.height + IMAGE_AREA_HEIGHT + BOTTOM_PADDING * 2;//返回计算后的最终高度
}
```
![案例5-1](https://images2018.cnblogs.com/blog/1356734/201803/1356734-20180330124629331-180933660.gif)
