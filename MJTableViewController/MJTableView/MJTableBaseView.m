//
//  MJTableBaseView.m
//  MJRefreshTest
//
//  Created by admin on 16/10/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MJTableBaseView.h"
#import "MJRefreshAutoFooterGY.h"

@interface SectionVo()

/** 存储该节包含的cellVo数据列表 注:包含用户数据和gap数据 不能直接对外遍历使用 **/
@property (nonatomic,retain)NSMutableArray<CellVo*>* cellVoList;

@end

@interface CellVo()

#define CELL_TAG_NORMAL 0 //除头尾中间段的
#define CELL_TAG_FIRST 1 //小组第一个
#define CELL_TAG_LAST 2 //小组最后一个
#define CELL_TAG_SECTION_GAP 10 //section的gap
#define CELL_TAG_CELL_GAP 11 //cell的gap

@property (nonatomic,assign)NSInteger cellTag;

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
            footer.stateLabel.userInteractionEnabled = NO;//无法点击交互
            [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
            
//            footer.ignoredScrollViewContentInsetBottom = 64;
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
    return sectionVo ? sectionVo.sectionHeight : 0;
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
    cell.isFirst = cellVo.cellTag == CELL_TAG_FIRST;
    if(sectionVo.cellVoList != NULL){
        cell.isLast = cellVo.cellTag == CELL_TAG_LAST;//row == source.data!.count - 1//索引在最后
    }
    cell.indexPath = indexPath;
    cell.tableView = self;
    cell.data = data;
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionVo* sectionVo = [self getSectionVoByIndex:section];
    Class headerClass = sectionVo.sectionClass;
    MJTableViewSection* sectionView;
    if (headerClass != NULL) {
        sectionView = [[headerClass alloc]init];
        sectionView.sectionCount = [self getSectionVoCount];
        sectionView.sectionIndex = section;
        sectionView.isFirst = section == 0;
        sectionView.isLast = section == self.dataArray.count - 1;
        sectionView.data = sectionVo.sectionData;
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
    CGRect rectInTableView = [self rectForRowAtIndexPath:indexPath];
    CGRect btnToSelf = [self convertRect:rectInTableView toView:self.superview];
//    CGRect btnToSelf = [self convertRect:clickCell.frame toView:self.superview];
    CGFloat moveY = btnToSelf.origin.y - CGRectGetHeight(self.bounds) / 2. + btnToSelf.size.height / 2. - self.contentInset.top;
    CGPoint contentOffset = self.contentOffset;
    //    self.bottomAreaView.contentSize.width
    CGFloat maxOffsetY = self.contentSize.height - CGRectGetHeight(self.bounds) - self.contentInset.top;
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
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(didSelectRow:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate didSelectRow:self didSelectRowAtIndexPath:indexPath];
    }
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(didSelectRow:didSelectRowAtIndexPath:)]) {
        NSIndexPath *path =  [self indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
//        NSLog(@"这是第%li栏目",(long)path.section);
        [self.refreshDelegate didSelectRow:self didSelectRowAtIndexPath:path];
    }
}

-(void)checkGaps {
    //遍历整个数据链 判断头尾标记和gap是否存在
    for (NSInteger i = 0; i < self.dataArray.count; i ++) {
        SectionVo* svo = [self getSectionVoByIndex:i];
        if (svo && svo.cellVoList != nil && svo.cellVoList.count > 0) {
            BOOL hasFirst = NO;
            BOOL hasLast = NO;
            for (NSInteger j = svo.cellVoList.count - 1; j >= 0; j --) {
                CellVo* cvo = svo.cellVoList[j];
                if (cvo.cellTag == CELL_TAG_FIRST) {
                    hasFirst = YES;
                }else if(cvo.cellTag == CELL_TAG_LAST){
                    hasLast = YES;
                }else if(cvo.cellTag == CELL_TAG_SECTION_GAP){
                    //                        if sectionGap <= 0{//已经不需要
                    [svo.cellVoList removeObjectAtIndex:j]; //先全部清除
                    //                            continue
                    //                        }
                }else if(cvo.cellTag == CELL_TAG_CELL_GAP){
                    //                        if cellGap <= 0{//已经不需要
                    [svo.cellVoList removeObjectAtIndex:j];//先全部清除
                    //                            continue
                    //                        }
                }
            }
            if(!hasFirst){//不存在
                ((CellVo*)svo.cellVoList[0]).cellTag = CELL_TAG_FIRST;//标记第一个就是
            }
            if(!hasLast){
                ((CellVo*)svo.cellVoList[svo.cellVoList.count - 1]).cellTag = CELL_TAG_LAST;//标记最后一个就是
            }
        }
    }
    
    if(self.sectionGap > 0 || self.cellGap > 0){
        for (NSInteger i = 0; i < self.dataArray.count; i ++) {
            SectionVo* svo = [self getSectionVoByIndex:i];
            //            var preCellVo:CellVo? = nil
            if(svo && svo.cellVoList != nil && svo.cellVoList.count > 0){
                for (NSInteger j = svo.cellVoList.count - 1; j >= 0; j --) {
                    if(self.sectionGap > 0 && j == svo.cellVoList.count - 1 && i != self.dataArray.count - 1){//非最后一节 且最后一个实体存到最后
                        [svo.cellVoList addObject:[self getSectionGapCellVo]];
                    }else if(self.cellGap > 0 && j != svo.cellVoList.count - 1){//不是最后一个直接插入
                        [svo.cellVoList insertObject:[self getCellGapCellVo] atIndex:j + 1];
                    }
                }
            }
        }
    }
}

-(CellVo*)getSectionGapCellVo{
    CellVo* cvo = [CellVo initWithParams:self.sectionGap cellClass:[MJTableViewCell class] cellData:nil];
    cvo.cellTag = CELL_TAG_SECTION_GAP;
    return cvo;
}

-(CellVo*)getCellGapCellVo{
    CellVo* cvo = [CellVo initWithParams:self.cellGap cellClass:[MJTableViewCell class] cellData:nil];
    cvo.cellTag = CELL_TAG_CELL_GAP;
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

@end

@implementation SectionVo

+(instancetype)initWithParams:(void (^)(SectionVo* svo))nextBlock{
    return [SectionVo initWithParams:0 sectionClass:nil sectionData:nil nextBlock:nextBlock];
}

+(instancetype)initWithParams:(CGFloat)sectionHeight sectionClass:(Class)sectionClass sectionData:(id)sectionData nextBlock:(void (^)(SectionVo *))nextBlock
{
    SectionVo *instance;
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
            instance.sectionHeight = sectionHeight;
            instance.sectionClass = sectionClass;
            instance.sectionData = sectionData;
//            instance.isUnique = isUnique;
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
    return self.cellTag == CELL_TAG_NORMAL || self.cellTag == CELL_TAG_FIRST || self.cellTag == CELL_TAG_LAST;
}

@end
