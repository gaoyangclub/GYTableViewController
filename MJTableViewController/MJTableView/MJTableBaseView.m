//
//  MJTableBaseView.m
//  MJRefreshTest
//
//  Created by 高扬 on 16/10/13.
//  Copyright © 2016年 高扬. All rights reserved.
//

#import "MJTableBaseView.h"
#import "MJRefreshAutoFooterGY.h"

typedef enum {
    CellTypeNormal,//除头尾中间段的
    CellTypeFirst,//小组第一个
    CellTypeLast,//小组最后一个
    CellTypeSectionGap,//section的gap
    CellTypeCellGap //cell的gap
} CellType;

@interface SectionVo()

/** 存储该节包含的cellVo数据列表 注:包含用户数据和gap数据 不能直接对外遍历使用 **/
@property (nonatomic,retain)NSMutableArray<CellVo*>* cellVoList;
//@property (nonatomic,assign)BOOL isSectionGap;//作为间距容器存在

@end

@interface CellVo()

//#define CELL_TAG_NORMAL 0 //除头尾中间段的
//#define CELL_TAG_FIRST 1 //小组第一个
//#define CELL_TAG_LAST 2 //小组最后一个
//#define CELL_TAG_SECTION_GAP 10 //section的gap
//#define CELL_TAG_CELL_GAP 11 //cell的gap

@property (nonatomic,assign)CellType cellType;

-(BOOL)isRealCell;

@end

@interface MJTableBaseView()<UITableViewDelegate,UITableViewDataSource>{//
    
}
@property(nonatomic,retain)NSMutableArray<SectionVo*>* dataArray;

@property (nonatomic,assign) BOOL useCellIdentifer;
@property (nonatomic,assign) BOOL showHeader;
@property (nonatomic,assign) BOOL showFooter;
/**
 *  是否设置顶部偏离 满足ViewController在自动测量导航栏高度占用的Insets偏移的补位
 */
@property (nonatomic,assign) BOOL topEdgeDiverge;

@end

@implementation MJTableBaseView

-(instancetype)initWithFrameAndParams:(CGRect)frame showHeader:(BOOL)showHeader showFooter:(BOOL)showFooter useCellIdentifer:(BOOL)useCellIdentifer topEdgeDiverge:(BOOL)topEdgeDiverge{//
    self = [super initWithFrame:frame];
    if (self) {
        self.useCellIdentifer = useCellIdentifer;
        self.showHeader = showHeader;
        self.showFooter = showFooter;
        self.topEdgeDiverge = topEdgeDiverge;
        [self prepare];
    }
    return self;
}

-(instancetype)initWithFrameAndParams:(CGRect)frame style:(UITableViewStyle)style showHeader:(BOOL)showHeader showFooter:(BOOL)showFooter useCellIdentifer:(BOOL)useCellIdentifer topEdgeDiverge:(BOOL)topEdgeDiverge{//
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.useCellIdentifer = useCellIdentifer;
        self.showHeader = showHeader;
        self.showFooter = showFooter;
        self.topEdgeDiverge = topEdgeDiverge;
        [self prepare];
    }
    return self;
}

//alloc会调用allocWithZone:
+(id)allocWithZone:(NSZone *)zone
{
    MJTableBaseView* instance;
    @synchronized (self) {
        if (instance == nil) {
            instance = [super allocWithZone:zone];
//            instance.refreshAll = YES;
//            instance.useCellIdentifer = YES;
//            instance.showHeader = YES;
//            instance.showFooter = YES;
            return instance;
        }
    }
    return nil;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
    }
    return self;
}

-(NSMutableArray<SectionVo*> *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray<SectionVo*> alloc]init];
    }
    return _dataArray;
}

-(NSMutableArray<SectionVo *> *)dataSourceArray{
    return self.dataArray;
}

/** 重新刷新界面 */
-(void)headerBeginRefresh {
    if (!self.mj_header.isRefreshing) {
        [self clearAllSectionVo];
        [self reloadData];
        [self.mj_header beginRefreshing];
    }
}

-(void)clearAllSectionVo {
    _selectedIndexPath = nil;
    [self.dataArray removeAllObjects];
}

-(void)addSectionVo:(SectionVo*)sectionVo {
    [self.dataArray addObject:sectionVo];
}

-(void)insertSectionVo:(SectionVo *)sectionVo atIndex:(NSInteger)index{
    [self.dataArray insertObject:sectionVo atIndex:index];
}

-(void)removeSectionVoAt:(NSInteger)index{
    [self.dataArray removeObjectAtIndex:index];
}

-(SectionVo*)getSectionVoByIndex:(NSInteger)index{
    if (index < self.dataArray.count) {
        return self.dataArray[index];
    }
    return nil;
}

-(CellVo *)getCellVoByIndexPath:(NSIndexPath *)indexPath{
    SectionVo* sectionVo = [self getSectionVoByIndex:indexPath.section];
    if (sectionVo && sectionVo.cellVoList && indexPath.row < sectionVo.cellVoList.count) {
        return sectionVo.cellVoList[indexPath.row];
    }
    return nil;
}

-(NSUInteger)getSectionVoCount{
    return self.dataArray.count;
}

-(NSUInteger)getTotalCellVoCount{
    NSInteger cellCount = 0;
    for (SectionVo* svo in self.dataArray) {
        for (CellVo* cvo in svo.cellVoList) {
            cellCount ++;
        }
    }
    return cellCount;
}

-(void)setRefreshDelegate:(id<MJTableBaseViewDelegate>)refreshDelegate{
    _refreshDelegate = refreshDelegate;
}

//-(void)setTopEdgeDiverge:(BOOL)topEdgeDiverge{
////    if (topEdgeDiverge) {
//////        self.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
////        self.mj_insetB = 64;
////    }else{
//////        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
////    }
//}

-(void)prepare{
//    dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
    
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;//默认自动回弹键盘
    
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone; //去掉Cell自带线条
        self.backgroundColor = [UIColor clearColor];
        
        
        if (self.topEdgeDiverge) {
            self.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        }
    
        if (self.showHeader) {
            MJRefreshNormalHeader* header = [[MJRefreshNormalHeader alloc]init]; //[MJRefreshNormalHeader headerWithRefreshingBlock:
            header.lastUpdatedTimeLabel.hidden = YES;//隐藏时间
            header.automaticallyChangeAlpha = YES;
//            header.ignoredScrollViewContentInsetTop = 50;
//            self.mj_header = header;
            // 设置自动切换透明度(在导航栏下面自动隐藏)
            self.header = header;
        }
        
        if (self.showFooter) {
            __weak __typeof(self) weakSelf = self;
            MJRefreshAutoNormalFooter* footer = [MJRefreshAutoFooterGY footerWithRefreshingBlock:^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (strongSelf.refreshDelegate && [strongSelf.refreshDelegate respondsToSelector:@selector(footerLoadMore:endLoadMoreHandler:lastSectionVo:)]){
                    [strongSelf.refreshDelegate footerLoadMore:strongSelf endLoadMoreHandler:^(BOOL hasData){
//                        [strongSelf footerLoaded:hasData];
                        if (hasData) {
                            [strongSelf checkGaps];
//                            strongSelf.refreshAll = NO;
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [strongSelf reloadData];
                                if (strongSelf.refreshDelegate && [strongSelf.refreshDelegate respondsToSelector:@selector(didLoadMoreComplete:)]){
                                    [strongSelf.refreshDelegate didLoadMoreComplete:strongSelf];
                                }
                            });
                            [strongSelf.mj_footer endRefreshing];
                        }else{
                            [strongSelf.mj_footer endRefreshingWithNoMoreData];
                        }
                    } lastSectionVo:[strongSelf getLastSectionVo]];
                }
            }];
//            footer.automaticallyHidden = YES;
            footer.stateLabel.userInteractionEnabled = NO;//无法点击交互
            [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
            
//            footer.ignoredScrollViewContentInsetBottom = 0;
//            UIEdgeInsets insets = footer.scrollViewOriginalInset;
//            insets.bottom = insets.top = 0;
//            footer.scrollViewOriginalInset = insets;
            self.mj_footer = footer;// 上拉刷新
        }
        
//    });

}

//-(void)footerLoaded:(BOOL)hasData{
//    
//}

-(void)setHeader:(MJRefreshHeader *)header{
    if (self.showHeader) {
        __weak __typeof(self) weakSelf = self;
        header.refreshingBlock = ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.refreshDelegate && [strongSelf.refreshDelegate respondsToSelector:@selector(headerRefresh:endRefreshHandler:)]) {
                [strongSelf clearAllSectionVo];//预先清除数据
                [strongSelf.refreshDelegate headerRefresh:strongSelf endRefreshHandler:^(BOOL hasData){
                    strongSelf->_hasFirstRefreshed = YES;
                    [strongSelf reloadMJData];
                    [strongSelf.mj_header endRefreshing];// 结束刷新
                    if (hasData) {
                        if (strongSelf.mj_footer) {
                            [strongSelf.mj_footer resetNoMoreData];
                        }
                    }else{
                        if (strongSelf.mj_footer) {
                            [strongSelf.mj_footer endRefreshingWithNoMoreData];
                        }
                    }
                }];
            }
        };
        header.endRefreshingCompletionBlock = ^(){
            [self moveSelectedIndexPathToCenter];
        };
        self.mj_header = header;
    }
}

-(void)moveSelectedIndexPathToCenter{
    if(self.mj_header.isIdle){//不在刷新状态下可以使用
        if (self.clickCellMoveToCenter && self->_selectedIndexPath) {
            //                MJTableViewCell* cell = [self cellForRowAtIndexPath:_selectedIndexPath];
            //                DDLog(@"selectedIndexPath.row:%ld",(long)_selectedIndexPath.row);
            [self moveCellToCenter:self->_selectedIndexPath];
        }
    }
}

-(void)reloadMJData{
//    self.refreshAll = YES;
    [self checkGaps];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
        if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(didRefreshComplete:)]){
            [self.refreshDelegate didRefreshComplete:self];
        }
        if (self.selectedIndexPath) {
            [self dispatchSelectRow:self.selectedIndexPath];
        }
    });
}

-(MJRefreshHeader *)header{
    return self.mj_header;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    SectionVo* sectionVo = [self getSectionVoByIndex:section];
    return sectionVo ? sectionVo.sectionHeaderHeight : 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return [self tableView:tableView heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    SectionVo* sectionVo = [self getSectionVoByIndex:section];
    return sectionVo ? sectionVo.sectionFooterHeight : 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    return [self tableView:tableView heightForFooterInSection:section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionVo* sectionVo = [self getSectionVoByIndex:section];
    return sectionVo && sectionVo.cellVoList ? sectionVo.cellVoList.count : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if(section >= self.dataArray.count){
        NSLog(@"产生无效UITableViewCell 可能是一个刷新列表正在进行中 另一个刷新就来了引起的");
        return [[UITableViewCell alloc] init];
    }
    SectionVo* sectionVo = [self getSectionVoByIndex:section];
    CellVo* cellVo = sectionVo.cellVoList[row];//获取的数据给cell显示
    Class cellClass = cellVo.cellClass;
//    if(autoCellClass != nil){
//        cellClass = autoCellClass!
//    }
    
    MJTableViewCell* cell;
    BOOL isCreate = NO;
    if(self.useCellIdentifer) {
        NSString* cellIdentifer;
        NSString* classString = NSStringFromClass(cellClass);
        if(cellVo.isUnique){//唯一
            cellIdentifer = [classString stringByAppendingString:[NSString stringWithFormat:@"_%lu_%lu",section,row]];
        }else{
            cellIdentifer = classString;
        }
        //        println("className:" + className)
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
        if(cell == NULL){
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
            isCreate = YES;
        }
    }else{
        cell = [[cellClass alloc] init];
        isCreate = YES;
    }
    
    if(isCreate){ //创建阶段设置
        if([cell showSelectionStyle]){
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }else{
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.backgroundColor = [UIColor clearColor];//无色
    }
    if (isCreate || !cell.isSubviewShow || !cellVo.isUnique || (cellVo.isUnique && cellVo.forceUpdate)) {//cell.cellVo != cellVo
        cell.needRefresh = YES; //需要刷新
    }else{
        cell.needRefresh = NO; //不需要刷新
    }
    NSObject* data = cellVo.cellData;
    cell.isSingle = sectionVo.cellVoList.count <= 1;
    cell.isFirst = cellVo.cellType == CellTypeFirst;
    if(sectionVo.cellVoList != NULL){
        cell.isLast = cellVo.cellType == CellTypeLast;//row == source.data!.count - 1//索引在最后
    }
    cell.indexPath = indexPath;
    cell.tableView = self;
//    cell.data = data;
    cell.cellVo = cellVo;
    
    cell.selected = [indexPath isEqual:self.selectedIndexPath];
    return cell;
}

//防止子类交互影响屏蔽父类
-(BOOL)touchesShouldCancelInContentView:(UIView *)view{
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellVo* cellVo = [self getCellVoByIndexPath:indexPath];
    if (cellVo) {
        return cellVo.cellHeight;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionVo* sectionVo = [self getSectionVoByIndex:section];
    Class headerClass = sectionVo.sectionHeaderClass;
    MJTableViewSection* sectionView;
    if (headerClass != NULL) {
        sectionView = [[headerClass alloc]init];
        sectionView.sectionCount = [self getSectionVoCount];
        sectionView.sectionIndex = section;
        sectionView.isFirst = section == 0;
        sectionView.isLast = section == self.dataArray.count - 1;
        sectionView.data = sectionVo.sectionHeaderData;
    }
//    var headerView = nsSectionDic[section]
//    if headerView == nil{
//        if(headerClass != nil){
//            headerView = headerClass!.init()
//            nsSectionDic.updateValue(headerView!, forKey: section)
//        }
//    }
    return sectionView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    SectionVo* sectionVo = [self getSectionVoByIndex:section];
    Class footerClass = sectionVo.sectionFooterClass;
    MJTableViewSection* sectionView;
    if (footerClass != NULL) {
        sectionView = [[footerClass alloc]init];
        sectionView.sectionCount = [self getSectionVoCount];
        sectionView.sectionIndex = section;
        sectionView.isFirst = section == 0;
        sectionView.isLast = section == self.dataArray.count - 1;
        sectionView.data = sectionVo.sectionFooterData;
    }
    return sectionView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.clickCellMoveToCenter) {
        [self moveCellToCenter:indexPath];
    }
    //    if (cell) {
////        tableView
//        cell.needRefresh = NO; //不需要刷新
//    }
//    CellVo* cellVo = [self getCellVoByIndexPath:indexPath];
//    cellVo.isSelect = YES;
    if(self.clickCellHighlight){
        [self changeSelectIndexPath:indexPath];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated: false];//反选
    [self dispatchSelectRow:indexPath];
}

-(void)moveCellToCenter:(NSIndexPath *)indexPath{
    CGRect btnToSelf = [self rectForRowAtIndexPath:indexPath];
    CGPoint contentOffset = self.contentOffset;
    CGFloat moveY = btnToSelf.origin.y + btnToSelf.size.height / 2. - contentOffset.y - CGRectGetHeight(self.bounds) / 2.;// - self.contentInset.top
    CGFloat maxOffsetY = self.contentSize.height - CGRectGetHeight(self.bounds);// - self.contentInset.top;
    maxOffsetY = maxOffsetY > 0 ? maxOffsetY : 0;
    CGFloat moveOffsetY = contentOffset.y + moveY;
    if (moveOffsetY < 0) {
        moveOffsetY = 0;
    }else if(moveOffsetY > maxOffsetY){
        moveOffsetY = maxOffsetY;
    }
    [self setContentOffset:CGPointMake(contentOffset.x,moveOffsetY) animated:YES];
}

-(void)dispatchSelectRow:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
        [self.refreshDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
//    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(didSelectRow:didSelectRowAtIndexPath:)]) {
//        [self.refreshDelegate didSelectRow:self didSelectRowAtIndexPath:indexPath];
//    }
}

-(void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath{
    [self changeSelectIndexPath:selectedIndexPath];
}

-(void)changeSelectIndexPath:(NSIndexPath *)selectedIndexPath{
    if (self->_selectedIndexPath) {
        MJTableViewCell* prevCell = [self cellForRowAtIndexPath:self->_selectedIndexPath];
        if (prevCell) {
            prevCell.selected = NO;
        }
    }
    self->_selectedIndexPath = selectedIndexPath;
    MJTableViewCell* cell = [self cellForRowAtIndexPath:selectedIndexPath];
    if (cell) {
        cell.selected = YES;
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(didEndScrollingAnimation:)]) {
        [self.refreshDelegate didEndScrollingAnimation:self];
    }
}

-(void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(didScrollToRow:indexPath:)]) {
        //        NSLog(@"这是第%li栏目",(long)path.section);
        [self.refreshDelegate didScrollToRow:self indexPath:indexPath];
    }
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(didScrollToRow:indexPath:)]) {
//        NSIndexPath *path =  [self indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
////        NSLog(@"这是第%li栏目",(long)path.section);
//        [self.refreshDelegate didScrollToRow:self indexPath:path];
//    }
//}

-(void)checkGaps {
    //遍历整个数据链 判断头尾标记和gap是否存在
//    for (SectionVo* svo in self.dataArray) {
    for (NSInteger i = [self getSectionVoCount] - 1; i >= 0; i --) {
        SectionVo* svo = [self getSectionVoByIndex:i];
        if (svo && svo.cellVoList != nil && svo.cellVoList.count > 0) {
            BOOL hasFirst = NO;
            BOOL hasLast = NO;
//            if (svo.isSectionGap) {
//                if (svo.cellVoList.count <= 0) {//已全部清除
//                    [self removeSectionVoAt:i];//sectionVo也移除
//                }else{
//                    svo.isSectionGap = NO;
//                }
//            }
            for (NSInteger j = svo.cellVoList.count - 1; j >= 0; j --) {
                CellVo* cvo = svo.cellVoList[j];
                if (cvo.cellType == CellTypeFirst) {
                    hasFirst = YES;
                }else if(cvo.cellType == CellTypeLast){
                    hasLast = YES;
                }
                else if(cvo.cellType == CellTypeSectionGap){
                    [svo.cellVoList removeObjectAtIndex:j]; //先清除
                    if (svo.cellVoList.count <= 0) {//已全部清除
                        [self removeSectionVoAt:i];//sectionVo也移除
                    }
                }
                else if(cvo.cellType == CellTypeCellGap){
                    [svo.cellVoList removeObjectAtIndex:j];//先清除
                }
            }
            if(!hasFirst){//不存在
                ((CellVo*)svo.cellVoList[0]).cellType = CellTypeFirst;//标记第一个就是
            }
            if(!hasLast){
                ((CellVo*)svo.cellVoList[svo.cellVoList.count - 1]).cellType = CellTypeLast;//标记最后一个就是
            }
        }
    }
    
    if(self.sectionGap > 0 || self.cellGap > 0){
        for (NSInteger i = [self getSectionVoCount] - 1; i >= 0; i --) {
            SectionVo* svo = [self getSectionVoByIndex:i];
            //            var preCellVo:CellVo? = nil
            if(self.sectionGap > 0 && [self getSectionVoByIndex:i - 1]){//有间距且前一个存在
                [self insertSectionVo:[self getSectionGapVo] atIndex:i];//直接插入一条
            }
            if(self.cellGap > 0 && svo && svo.cellVoList != nil && svo.cellVoList.count > 0){
                for (NSInteger j = svo.cellVoList.count - 1; j >= 0; j --) {
//                    if(self.sectionGap > 0 && j == svo.cellVoList.count - 1 && i != self.dataArray.count - 1 && [self getSectionVoByIndex:i + 1].sectionHeaderHeight > 0){//非最后一节 且最后一个实体存到最后 且下一个section有高度
//                        [svo.cellVoList addObject:[self getSectionGapCellVo]];
//                    }else
                    if(j != svo.cellVoList.count - 1){//不是最后一个直接插入
                        [svo.cellVoList insertObject:[self getCellGapCellVo] atIndex:j + 1];
                    }
                }
            }
        }
    }
}

-(SectionVo*)getSectionGapVo{
//    if (svo != nil) {
//        svo.sectionHeaderHeight = self.sectionGap;
//    }else{
    SectionVo* svo = [SectionVo initWithParams:0 sectionHeaderClass:nil sectionHeaderData:nil nextBlock:^(SectionVo *svo) {
        CellVo* cvo = [CellVo initWithParams:self.sectionGap cellClass:[MJTableViewCell class] cellData:nil];
        cvo.cellType = CellTypeSectionGap;
        [svo addCellVo:cvo];
    }];
//    }
    return svo;
}

-(CellVo*)getCellGapCellVo{
    CellVo* cvo = [CellVo initWithParams:self.cellGap cellClass:[MJTableViewCell class] cellData:nil];
    cvo.cellType = CellTypeCellGap;
    return cvo;
}

-(SectionVo*)getLastSectionVo {
    if (self.dataArray.count > 0) {
        return self.dataArray.lastObject;
    }
    return NULL;
}

-(SectionVo*)getFirstSectionVo {
    if (self.dataArray.count > 0) {
        return self.dataArray.firstObject;
    }
    return NULL;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.refreshDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [self.refreshDelegate tableView:tableView willDisplayHeaderView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
        [self.refreshDelegate tableView:tableView willDisplayFooterView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        [self.refreshDelegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
        [self.refreshDelegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
        [self.refreshDelegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [self.refreshDelegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:didHighlightRowAtIndexPath:)]) {
        [self.refreshDelegate tableView:tableView didHighlightRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)]) {
        [self.refreshDelegate tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
    }
}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        return [self.refreshDelegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    }
    return indexPath;
}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
        return [self.refreshDelegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
    }
    return indexPath;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        return [self.refreshDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.refreshDelegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleNone;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.refreshDelegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return nil;
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]) {
        return [self.refreshDelegate tableView:tableView editActionsForRowAtIndexPath:indexPath];
    }
    return nil;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
        return [self.refreshDelegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }
    return false;
}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
        [self.refreshDelegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
        [self.refreshDelegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)]) {
        [self.refreshDelegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)]) {
        return [self.refreshDelegate tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
    return 0;
}
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)]) {
        return [self.refreshDelegate tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    }
    return false;
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)]) {
        return [self.refreshDelegate tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
    return false;
}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)]) {
        [self.refreshDelegate tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
}
- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:canFocusRowAtIndexPath:)]) {
        [self.refreshDelegate tableView:tableView canFocusRowAtIndexPath:indexPath];
    }
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:shouldUpdateFocusInContext:)]) {
        [self.refreshDelegate tableView:tableView shouldUpdateFocusInContext:context];
    }
    return YES;
}
- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(tableView:didUpdateFocusInContext:withAnimationCoordinator:)]) {
        [self.refreshDelegate tableView:tableView didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    }
}
- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(indexPathForPreferredFocusedViewInTableView:)]) {
        [self.refreshDelegate indexPathForPreferredFocusedViewInTableView:tableView];
    }
    return nil;
}

@end

@implementation SectionVo

+(instancetype)initWithParams:(void (^)(SectionVo* svo))nextBlock{
    return [SectionVo initWithParams:0 sectionHeaderClass:nil sectionHeaderData:nil nextBlock:nextBlock];
}

+(instancetype)initWithParams:(CGFloat)sectionHeaderHeight sectionHeaderClass:(Class)sectionHeaderClass sectionHeaderData:(id)sectionHeaderData nextBlock:(void (^)(SectionVo *))nextBlock{
    return [SectionVo initWithParams:sectionHeaderHeight sectionHeaderClass:sectionHeaderClass sectionHeaderData:sectionHeaderData sectionFooterHeight:0 sectionFooterClass:nil sectionFooterData:nil nextBlock:nextBlock];
}

+(instancetype)initWithParams:(CGFloat)sectionHeaderHeight sectionHeaderClass:(Class)sectionHeaderClass sectionHeaderData:(id)sectionHeaderData sectionFooterHeight:(CGFloat)sectionFooterHeight sectionFooterClass:(Class)sectionFooterClass sectionFooterData:(id)sectionFooterData nextBlock:(void (^)(SectionVo *))nextBlock{
    SectionVo *instance;
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
            instance.sectionHeaderHeight = sectionHeaderHeight;
            instance.sectionHeaderClass = sectionHeaderClass;
            instance.sectionHeaderData = sectionHeaderData;
            instance.sectionFooterHeight = sectionFooterHeight;
            instance.sectionFooterClass = sectionFooterClass;
            instance.sectionFooterData = sectionFooterData;
            if (nextBlock) {
                nextBlock(instance);
            }
        }
    }
    return instance;
}

-(NSMutableArray<CellVo *> *)cellVoList{
    if(!_cellVoList){
        _cellVoList = [NSMutableArray<CellVo*> array];
    }
    return _cellVoList;
}

-(NSInteger)getCellVoCount {
    if (!self.cellVoList || self.cellVoList.count == 0) {
        return 0;
    }
    NSInteger count = 0;
    for (CellVo* cvo in self.cellVoList) {
        if ([cvo isRealCell]) {
            count++;
        }
    }
    return count;
}

-(void)addCellVo:(CellVo *)cellVo{
    [self.cellVoList addObject:cellVo];
}

-(void)addCellVoByList:(NSArray<CellVo *> *)otherVoList{
    [self.cellVoList addObjectsFromArray:otherVoList];
}

@end

@implementation CellVo

+(instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(NSObject*)cellData{
    return [CellVo initWithParams:cellHeight cellClass:cellClass cellData:cellData isUnique:false];
}

+(instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData isUnique:(BOOL)isUnique{
    return [CellVo initWithParams:cellHeight cellClass:cellClass cellData:cellData isUnique:isUnique forceUpdate:false];
}

+(instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData isUnique:(BOOL)isUnique forceUpdate:(BOOL)forceUpdate
{
    CellVo *instance;
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
            if (cellHeight == CELL_AUTO_HEIGHT) {
                instance.isAutoHeight = YES;
                cellHeight = [UIScreen mainScreen].bounds.size.height;
            }
            instance.cellHeight = cellHeight;
            instance.cellClass = cellClass;
            instance.cellData = cellData;
//            instance.cellTag = cellTag;
            instance.isUnique = isUnique;
            instance.forceUpdate = forceUpdate;
        }
    }
    return instance;
}

+(NSArray<CellVo *> *)dividingCellVoBySourceArray:(CGFloat)cellHeight cellClass:(Class)cellClass sourceArray:(NSArray *)sourceArray{
    if (!sourceArray || sourceArray.count <= 0) {
        return nil;
    }
    NSMutableArray<CellVo *> * cellVoList = [NSMutableArray<CellVo *> array];
    for (id source in sourceArray) {
        [cellVoList addObject:
         [CellVo initWithParams:cellHeight cellClass:cellClass cellData:source]];
    }
    return cellVoList;
}

-(BOOL)isRealCell{
    return self.cellType == CellTypeNormal || self.cellType == CellTypeFirst || self.cellType == CellTypeLast;
}

@end
