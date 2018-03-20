# MJTableViewController
自定义封装TableView和MJRefresh结合

特点:<br/>
1.将tableView常用的delegate和dataSource方法封装在内部处理，通过外部包装数据的方式展示相关内容，控制cell状态<br/>
2.cell内部根据传递的数据展示内容<br/>
3.内部自带MJRefresh框架，提供下拉刷新和上拉加载功能，外部暴露接口调用<br/>

用法:<br/>
此框架基于MJRefresh，所以务必先添加该framework，手动或者pod都可以，使用链接<br/>
请使用该框架中的元素来代替原生列表控件，对应关系如下:<br/>
MJTableBaseView -> UITableView<br/>
MJTableViewController -> UITableViewController<br/>
MJTableViewCell -> UITableViewCell<br/>
MJTableViewSection 原生使用UIView展示section内容，这里使用MJTableViewSection<br/>

使用时直接创建Controller继承MJTableViewController，在Controller内部重写相关方法控制界面刷新，列表内容层次搭建，以及各种类型的Cell位置如何摆放等

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
