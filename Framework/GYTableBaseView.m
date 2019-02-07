//
//  GYTableBaseView.m
//  GYTableViewController
//
//  Created by 高扬 on 2016/10/13.
//  Copyright © 2016年 高扬. All rights reserved.
//

#import "GYTableBaseView.h"
#import "GYRefreshAutoFooter.h"
#import <objc/runtime.h>

typedef enum {
    CellTypeNormal,//除头尾中间段的
    CellTypeFirst,//小组第一个
    CellTypeLast,//小组最后一个
    CellTypeSectionGap,//section的gap
    CellTypeCellGap //cell的gap
} CellType;

@interface SectionNode()

/** 存储该节包含的cellNode数据列表 注:包含用户数据和gap数据 不能直接对外遍历使用 **/
@property (nonatomic, strong) NSMutableArray<CellNode *> *cellNodeList;
//@property (nonatomic, assign) BOOL isSectionGap;//作为间距容器存在

@end

@interface CellNode()

@property (nonatomic, assign) CellType cellType;

- (BOOL)isRealCell;

@end

@interface GYTableBaseView()<UITableViewDelegate,UITableViewDataSource> {//
    
}

@property (nonatomic, strong) NSMutableArray<SectionNode *> *dataArray;

@property (nonatomic, assign) BOOL useCellIdentifer;
@property (nonatomic, assign) BOOL showHeader;
@property (nonatomic, assign) BOOL showFooter;
/**
 *  是否设置顶部偏离 满足ViewController在自动测量导航栏高度占用的Insets偏移的补位
 */
//@property (nonatomic,assign) BOOL topEdgeDiverge;

@end

@implementation GYTableBaseView

+ (instancetype)table:(id<GYTableBaseViewDelegate>)delegate {
    return [[self alloc] initWithFrameAndParams:CGRectZero showHeader:NO showFooter:NO useCellIdentifer:YES delegate:delegate];
}

- (instancetype)initWithFrameAndParams:(CGRect)frame showHeader:(BOOL)showHeader showFooter:(BOOL)showFooter useCellIdentifer:(BOOL)useCellIdentifer delegate:(id<GYTableBaseViewDelegate>)delegate {// topEdgeDiverge:(BOOL)topEdgeDiverge
    self = [super initWithFrame:frame];
    if (self) {
        self.useCellIdentifer = useCellIdentifer;
        self.showHeader = showHeader;
        self.showFooter = showFooter;
//        self.topEdgeDiverge = topEdgeDiverge;
        self.gy_delegate = delegate;
        [self prepare];
    }
    return self;
}

- (instancetype)initWithFrameAndParams:(CGRect)frame style:(UITableViewStyle)style showHeader:(BOOL)showHeader showFooter:(BOOL)showFooter useCellIdentifer:(BOOL)useCellIdentifer delegate:(id<GYTableBaseViewDelegate>)delegate {//topEdgeDiverge:(BOOL)topEdgeDiverge
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.useCellIdentifer = useCellIdentifer;
        self.showHeader = showHeader;
        self.showFooter = showFooter;
//        self.topEdgeDiverge = topEdgeDiverge;
        self.gy_delegate = delegate;
        [self prepare];
    }
    return self;
}

//alloc会调用allocWithZone:
+ (id)allocWithZone:(NSZone *)zone
{
    GYTableBaseView* instance;
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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
    }
    return self;
}

- (NSMutableArray<SectionNode *> *)dataArray {
    if(!_dataArray){
        _dataArray = [[NSMutableArray<SectionNode *> alloc]init];
    }
    return _dataArray;
}

- (NSMutableArray<SectionNode *> *)dataSourceArray {
    return self.dataArray;
}

/** 重新刷新界面 */
- (void)headerBeginRefresh {
    if (!self.mj_header.isRefreshing) {
        [self clearAllSectionNode];
        [self reloadData];
        [self.mj_header beginRefreshing];
    }
}

- (void)clearAllSectionNode {
    _selectedIndexPath = nil;
    [self.dataArray removeAllObjects];
}

- (void)addSectionNode:(SectionNode *)sectionNode {
    [self.dataArray addObject:sectionNode];
}

- (void)insertSectionNode:(SectionNode *)sectionNode atIndex:(NSInteger)index {
    [self.dataArray insertObject:sectionNode atIndex:index];
}

- (void)removeSectionNodeAt:(NSInteger)index {
    [self.dataArray removeObjectAtIndex:index];
}

- (SectionNode *)getSectionNodeByIndex:(NSInteger)index {
    if (index < self.dataArray.count) {
        return self.dataArray[index];
    }
    return nil;
}

- (CellNode *)getCellNodeByIndexPath:(NSIndexPath *)indexPath {
    SectionNode *sectionNode = [self getSectionNodeByIndex:indexPath.section];
    if (sectionNode && sectionNode.cellNodeList && indexPath.row < sectionNode.cellNodeList.count) {
        return sectionNode.cellNodeList[indexPath.row];
    }
    return nil;
}

- (NSUInteger)getSectionNodeCount {
    return self.dataArray.count;
}

- (NSUInteger)getTotalCellNodeCount {
    NSInteger cellCount = 0;
    for (SectionNode *sNode in self.dataArray) {
        for (__unused CellNode *cNode in sNode.cellNodeList) {
            cellCount ++;
        }
    }
    return cellCount;
}

//动态添加obj中的方法，使用当前self的实现IMP
- (void)p_addInstanceMethod:(id)obj selectorName:(NSString *)selectorName {
    SEL sel = NSSelectorFromString(selectorName);
    if (![obj respondsToSelector:sel]) {
        Method exchangeM = class_getInstanceMethod([self class], sel);
        class_addMethod([obj class], sel, class_getMethodImplementation([self class], sel),method_getTypeEncoding(exchangeM));
        class_addMethod([obj class], sel, class_getMethodImplementation([self class], sel),method_getTypeEncoding(exchangeM));
    }
}

- (void)setGy_delegate:(id<GYTableBaseViewDelegate>)gy_delegate {
    _gy_delegate = gy_delegate;
    
    [self p_addInstanceMethod:gy_delegate selectorName:@"numberOfSectionsInTableView:"];
    [self p_addInstanceMethod:gy_delegate selectorName:@"tableView:numberOfRowsInSection:"];
    [self p_addInstanceMethod:gy_delegate selectorName:@"tableView:heightForHeaderInSection:"];
    [self p_addInstanceMethod:gy_delegate selectorName:@"tableView:heightForFooterInSection:"];
    [self p_addInstanceMethod:gy_delegate selectorName:@"tableView:heightForRowAtIndexPath:"];
    [self p_addInstanceMethod:gy_delegate selectorName:@"tableView:cellForRowAtIndexPath:"];
    [self p_addInstanceMethod:gy_delegate selectorName:@"tableView:viewForHeaderInSection:"];
    [self p_addInstanceMethod:gy_delegate selectorName:@"tableView:viewForFooterInSection:"];
    [self p_addInstanceMethod:gy_delegate selectorName:@"tableView:didSelectRowAtIndexPath:"];
    
    self.delegate = gy_delegate;
    self.dataSource = gy_delegate;
}

//- (void)setTopEdgeDiverge:(BOOL)topEdgeDiverge{
////    if (topEdgeDiverge) {
//////        self.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
////        self.mj_insetB = 64;
////    }else{
//////        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
////    }
//}

- (void)prepare {
//    dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
    
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;//默认自动回弹键盘
    
//        self.delegate = self;
//        self.dataSource = self;
    
        self.separatorStyle = UITableViewCellSeparatorStyleNone; //去掉Cell自带线条
        self.backgroundColor = [UIColor clearColor];
        
//        if (self.topEdgeDiverge) {
//            self.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
//        }
    
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
            MJRefreshAutoNormalFooter* footer = [[GYRefreshAutoFooter alloc]init];
            //            footer.automaticallyHidden = YES;
            footer.onlyRefreshPerDrag = YES; //MARK: 每一次拖拽只发一次请求(坑 不设置每次拖拽会触发2次以上)
            footer.stateLabel.userInteractionEnabled = NO;//无法点击交互
            [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
            self.footer = footer;
        }
//    });
}

- (void)headerEndRefresh:(BOOL)hasData {
    self->_hasFirstRefreshed = YES;
    [self gy_reloadData];
    [self.mj_header endRefreshing];// 结束刷新
    if (hasData) {
        if (self.mj_footer) {
            [self.mj_footer resetNoMoreData];
        }
    }else{
        if (self.mj_footer) {
            [self.mj_footer endRefreshingWithNoMoreData];
        }
    }
}

- (void)setHeader:(MJRefreshHeader *)header {
    if (self.showHeader) {
        __weak __typeof(self) weakSelf = self;
        header.refreshingBlock = ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.gy_delegate && [strongSelf.gy_delegate respondsToSelector:@selector(headerRefresh:)]) {
                [strongSelf clearAllSectionNode];//预先清除数据
                [strongSelf.gy_delegate headerRefresh:strongSelf];
            }
        };
        header.endRefreshingCompletionBlock = ^(){
            [self moveSelectedIndexPathToCenter];
        };
        self.mj_header = header;
    }
}

- (void)footerEndLoadMore:(BOOL)hasData {
    if (hasData) {
        [self checkGaps];
        //                            strongSelf.refreshAll = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
            if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(didLoadMoreComplete:)]){
                [self.gy_delegate didLoadMoreComplete:self];
            }
        });
        [self.mj_footer endRefreshing];
    }else{
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)setFooter:(MJRefreshFooter *)footer {
    if (self.showFooter) {
        __weak __typeof(self) weakSelf = self;
        footer.refreshingBlock = ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.gy_delegate && [strongSelf.gy_delegate respondsToSelector:@selector(footerLoadMore:lastSectionNode:)]){
                [strongSelf.gy_delegate footerLoadMore:strongSelf lastSectionNode:[strongSelf getLastSectionNode]];
            }
        };
        self.mj_footer = footer;// 上拉刷新
    }
}

- (void)moveSelectedIndexPathToCenter {
    if(!self.mj_header || (self.mj_header && self.mj_header.isIdle)){//不设置下拉刷新控件 or 刷新控件不在刷新状态下可以使用
        if (self.clickCellMoveToCenter && self->_selectedIndexPath) {
            //                GYTableViewCell* cell = [self cellForRowAtIndexPath:_selectedIndexPath];
            //                DDLog(@"selectedIndexPath.row:%ld",(long)_selectedIndexPath.row);
            [self moveCellToCenter:self->_selectedIndexPath];
        }
    }
}

- (void)gy_reloadData {
//    self.refreshAll = YES;
    [self checkGaps];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
        if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(didRefreshComplete:)]){
            [self.gy_delegate didRefreshComplete:self];
        }
        if (self.selectedIndexPath) {
            [self dispatchSelectRow:self.selectedIndexPath];
        }
    });
}

- (MJRefreshHeader *)header {
    return self.mj_header;
}

- (NSInteger)numberOfSectionsInTableView:(GYTableBaseView *)tableView {
    return tableView.dataArray.count;
}

- (CGFloat)tableView:(GYTableBaseView *)tableView heightForHeaderInSection:(NSInteger)section {
    SectionNode *sectionNode = [tableView getSectionNodeByIndex:section];
    return sectionNode ? sectionNode.sectionHeaderHeight : 0;
}

//- (CGFloat)tableView:(GYTableBaseView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
//    return [self tableView:tableView heightForHeaderInSection:section];
//}

- (CGFloat)tableView:(GYTableBaseView *)tableView heightForFooterInSection:(NSInteger)section {
    SectionNode *sectionNode = [tableView getSectionNodeByIndex:section];
    return sectionNode ? sectionNode.sectionFooterHeight : 0;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
//    return [self tableView:tableView heightForFooterInSection:section];
//}

- (NSInteger)tableView:(GYTableBaseView *)tableView numberOfRowsInSection:(NSInteger)section {
    SectionNode *sectionNode = [tableView getSectionNodeByIndex:section];
    return sectionNode && sectionNode.cellNodeList ? sectionNode.cellNodeList.count : 0;
}

- (UITableViewCell *)tableView:(GYTableBaseView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section >= tableView.dataArray.count) {
        NSLog(@"产生无效UITableViewCell 可能是一个刷新列表正在进行中 另一个刷新就来了引起的");
        return [[UITableViewCell alloc] init];
    }
    SectionNode *sectionNode = [tableView getSectionNodeByIndex:section];
    CellNode *cellNode = sectionNode.cellNodeList[row];//获取的数据给cell显示
    Class cellClass = cellNode.cellClass;
//    if(autoCellClass != nil){
//        cellClass = autoCellClass!
//    }
    
    GYTableViewCell *cell;
    BOOL isCreate = NO;
    if (tableView.useCellIdentifer) {
        NSString *cellIdentifer;
        NSString *classString = NSStringFromClass(cellClass);
        if (cellNode.isUnique) {//唯一
            cellIdentifer = [classString stringByAppendingString:[NSString stringWithFormat:@"_%lu_%lu", section, row]];
        } else {
            cellIdentifer = classString;
        }
        //        println("className:" + className)
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
        if (cell == NULL) {
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
            isCreate = YES;
        }
    } else {
        cell = [[cellClass alloc] init];
        isCreate = YES;
    }
    
    if (isCreate) { //创建阶段设置
        cell.backgroundColor = [UIColor clearColor];//无色
    }
    if (isCreate || !cell.isSubviewShow || !cellNode.isUnique || (cellNode.isUnique && cellNode.forceUpdate)) {//cell.CellNode !=
        cell.needRefresh = YES; //需要刷新
    } else {
        cell.needRefresh = NO; //不需要刷新
    }
//    NSObject* data = CellNode.cellData;
    cell.isSingle = sectionNode.cellNodeList.count <= 1;
    cell.isFirst = cellNode.cellType == CellTypeFirst;
    if (sectionNode.cellNodeList != NULL) {
        cell.isLast = cellNode.cellType == CellTypeLast;//row == source.data!.count - 1//索引在最后
    }
    cell.indexPath = indexPath;
    cell.tableView = tableView;
//    cell.data = data;
    cell.cellNode = cellNode;
    
    //当cellNode数据设置完毕后再设置选中样式，有可能根据业务数据返回showSelectionStyle值
    if ([cell showSelectionStyle]) {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.selected = [indexPath isEqual:tableView.selectedIndexPath];
    
    if (tableView.gy_delegate && [tableView.gy_delegate respondsToSelector:@selector(preparCell:targetCell:indexPath:)]) {
        [tableView.gy_delegate preparCell:tableView targetCell:cell indexPath:indexPath];
    }
    
    return cell;
}

//防止子类交互影响屏蔽父类
- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    return YES;
}

- (CGFloat)tableView:(GYTableBaseView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellNode *cellNode = [tableView getCellNodeByIndexPath:indexPath];
    if (cellNode) {
        return cellNode.cellHeight;
    }
    return 0;
}

//- (CGFloat)tableView:(GYTableBaseView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [tableView tableView:tableView heightForRowAtIndexPath:indexPath];
//}

- (UIView *)tableView:(GYTableBaseView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionNode *sectionNode = [tableView getSectionNodeByIndex:section];
    Class headerClass = sectionNode.sectionHeaderClass;
    GYTableViewSection* sectionView;
    if (headerClass != NULL) {
        sectionView = [[headerClass alloc]init];
        sectionView.sectionCount = [tableView getSectionNodeCount];
        sectionView.sectionIndex = section;
        sectionView.isFirst = section == 0;
        sectionView.isLast = section == tableView.dataArray.count - 1;
        sectionView.data = sectionNode.sectionHeaderData;
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

- (nullable UIView *)tableView:(GYTableBaseView *)tableView viewForFooterInSection:(NSInteger)section {
    SectionNode *sectionNode = [tableView getSectionNodeByIndex:section];
    Class footerClass = sectionNode.sectionFooterClass;
    GYTableViewSection* sectionView;
    if (footerClass != NULL) {
        sectionView = [[footerClass alloc]init];
        sectionView.sectionCount = [tableView getSectionNodeCount];
        sectionView.sectionIndex = section;
        sectionView.isFirst = section == 0;
        sectionView.isLast = section == tableView.dataArray.count - 1;
        sectionView.data = sectionNode.sectionFooterData;
    }
    return sectionView;
}

- (void)tableView:(GYTableBaseView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.clickCellMoveToCenter) {
        [tableView moveCellToCenter:indexPath];
    }
    //    if (cell) {
////        tableView
//        cell.needRefresh = NO; //不需要刷新
//    }
//    CellNode* cellNode = [self getCellNodeByIndexPath:indexPath];
//    CellNode.isSelect = YES;
    if(tableView.clickCellHighlight){
        [tableView changeSelectIndexPath:indexPath];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated: false];//反选
    [tableView dispatchSelectRow:indexPath];
}

- (void)moveCellToCenter:(NSIndexPath *)indexPath {
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

- (void)dispatchSelectRow:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(didSelectRow:indexPath:)]){
        [self.gy_delegate didSelectRow:self indexPath:indexPath];
    }
}

- (void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath {
    [self changeSelectIndexPath:selectedIndexPath];
}

- (void)changeSelectIndexPath:(NSIndexPath *)selectedIndexPath {
    if (self->_selectedIndexPath) {
        GYTableViewCell *prevCell = [self cellForRowAtIndexPath:self->_selectedIndexPath];
        if (prevCell) {
            prevCell.selected = NO;
        }
    }
    self->_selectedIndexPath = selectedIndexPath;
    GYTableViewCell *cell = [self cellForRowAtIndexPath:selectedIndexPath];
    if (cell) {
        cell.selected = YES;
    }
}

- (void)checkGaps {
    //遍历整个数据链 判断头尾标记和gap是否存在
    for (NSInteger i = [self getSectionNodeCount] - 1; i >= 0; i --) {
        SectionNode *sNode = [self getSectionNodeByIndex:i];
        if (sNode && sNode.cellNodeList != nil && sNode.cellNodeList.count > 0) {
            BOOL hasFirst = NO;
            BOOL hasLast = NO;
//            if (sNode.isSectionGap) {
//                if (sNode.cellNodeList.count <= 0) {//已全部清除
//                    [self removeSectionNodeAt:i];//sectionNode也移除
//                }else{
//                    sNode.isSectionGap = NO;
//                }
//            }
            for (NSInteger j = sNode.cellNodeList.count - 1; j >= 0; j --) {
                CellNode *cNode = sNode.cellNodeList[j];
                if (cNode.cellType == CellTypeFirst) {
                    hasFirst = YES;
                }else if(cNode.cellType == CellTypeLast){
                    hasLast = YES;
                }
                else if(cNode.cellType == CellTypeSectionGap){
                    [sNode.cellNodeList removeObjectAtIndex:j]; //先清除
                    if (sNode.cellNodeList.count <= 0) {//已全部清除
                        [self removeSectionNodeAt:i];//sectionNode也移除
                    }
                }
                else if(cNode.cellType == CellTypeCellGap){
                    [sNode.cellNodeList removeObjectAtIndex:j];//先清除
                }
            }
            if(!hasFirst){//不存在
                ((CellNode *)sNode.cellNodeList[0]).cellType = CellTypeFirst;//标记第一个就是
            }
            if(!hasLast){
                ((CellNode *)sNode.cellNodeList[sNode.cellNodeList.count - 1]).cellType = CellTypeLast;//标记最后一个就是
            }
        }
    }
    
    if(self.sectionGap > 0 || self.cellGap > 0){
        for (NSInteger i = [self getSectionNodeCount] - 1; i >= 0; i --) {
            SectionNode *sNode = [self getSectionNodeByIndex:i];
            //            var preCellNode:CellNode? = nil
            if(self.sectionGap > 0 && [self getSectionNodeByIndex:i - 1]){//有间距且前一个存在
                [self insertSectionNode:[self getSectionGapNode] atIndex:i];//直接插入一条
            }
            if(self.cellGap > 0 && sNode && sNode.cellNodeList != nil && sNode.cellNodeList.count > 0){
                for (NSInteger j = sNode.cellNodeList.count - 1; j >= 0; j --) {
//                    if(self.sectionGap > 0 && j == sNode.cellNodeList.count - 1 && i != self.dataArray.count - 1 && [self getSectionNodeByIndex:i + 1].sectionHeaderHeight > 0){//非最后一节 且最后一个实体存到最后 且下一个section有高度
//                        [sNode.cellNodeList addObject:[self getSectionGapCellNode]];
//                    }else
                    if(j != sNode.cellNodeList.count - 1){//不是最后一个直接插入
                        [sNode.cellNodeList insertObject:[self getCellGapCellNode] atIndex:j + 1];
                    }
                }
            }
        }
    }
}

- (SectionNode *)getSectionGapNode {
//    if (sNode != nil) {
//        sNode.sectionHeaderHeight = self.sectionGap;
//    }else{
    SectionNode *sNode = [SectionNode initWithParams:0 sectionHeaderClass:nil sectionHeaderData:nil nextBlock:^(SectionNode *sNode) {
        CellNode *cNode = [CellNode initWithParams:self.sectionGap cellClass:[GYTableViewCell class] cellData:nil];
        cNode.cellType = CellTypeSectionGap;
        [sNode addCellNode:cNode];
    }];
//    }
    return sNode;
}

- (CellNode *)getCellGapCellNode {
    CellNode *cNode = [CellNode initWithParams:self.cellGap cellClass:[GYTableViewCell class] cellData:nil];
    cNode.cellType = CellTypeCellGap;
    return cNode;
}

- (SectionNode *)getLastSectionNode {
    if (self.dataArray.count > 0) {
        return self.dataArray.lastObject;
    }
    return NULL;
}

- (SectionNode *)getFirstSectionNode {
    if (self.dataArray.count > 0) {
        return self.dataArray.firstObject;
    }
    return NULL;
}

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(didScrollToRow:indexPath:)]) {
        //        NSLog(@"这是第%li栏目",(long)path.section);
        [self.gy_delegate didScrollToRow:self indexPath:indexPath];
    }
}

@end

@implementation SectionNode

+ (instancetype)initWithParams:(void (^)(SectionNode *sNode))nextBlock {
    return [SectionNode initWithParams:0 sectionHeaderClass:nil sectionHeaderData:nil nextBlock:nextBlock];
}

+ (instancetype)initWithParams:(CGFloat)sectionHeaderHeight sectionHeaderClass:(Class)sectionHeaderClass sectionHeaderData:(id)sectionHeaderData nextBlock:(void (^)(SectionNode *))nextBlock {
    return [SectionNode initWithParams:sectionHeaderHeight sectionHeaderClass:sectionHeaderClass sectionHeaderData:sectionHeaderData sectionFooterHeight:0 sectionFooterClass:nil sectionFooterData:nil nextBlock:nextBlock];
}

+ (instancetype)initWithParams:(CGFloat)sectionHeaderHeight sectionHeaderClass:(Class)sectionHeaderClass sectionHeaderData:(id)sectionHeaderData sectionFooterHeight:(CGFloat)sectionFooterHeight sectionFooterClass:(Class)sectionFooterClass sectionFooterData:(id)sectionFooterData nextBlock:(void (^)(SectionNode *))nextBlock {
    SectionNode *instance;
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

- (NSMutableArray<CellNode *> *)cellNodeList {
    if(!_cellNodeList){
        _cellNodeList = [NSMutableArray<CellNode *> array];
    }
    return _cellNodeList;
}

- (NSInteger)getCellNodeCount {
    if (!self.cellNodeList || self.cellNodeList.count == 0) {
        return 0;
    }
    NSInteger count = 0;
    for (CellNode *cNode in self.cellNodeList) {
        if ([cNode isRealCell]) {
            count++;
        }
    }
    return count;
}

- (void)addCellNode:(CellNode *)cellNode {
    [self.cellNodeList addObject:cellNode];
}

- (void)addCellNodeByList:(NSArray<CellNode *> *)otherNodeList {
    [self.cellNodeList addObjectsFromArray:otherNodeList];
}

@end

@implementation CellNode

+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(NSObject*)cellData {
    return [CellNode initWithParams:cellHeight cellClass:cellClass cellData:cellData isUnique:false];
}

+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData isUnique:(BOOL)isUnique {
    return [CellNode initWithParams:cellHeight cellClass:cellClass cellData:cellData isUnique:isUnique forceUpdate:false];
}

+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData isUnique:(BOOL)isUnique forceUpdate:(BOOL)forceUpdate
{
    CellNode *instance;
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

+ (NSArray<CellNode *> *)dividingCellNodeBySourceArray:(CGFloat)cellHeight cellClass:(Class)cellClass sourceArray:(NSArray *)sourceArray {
    if (!sourceArray || sourceArray.count <= 0) {
        return nil;
    }
    NSMutableArray<CellNode *> *cellNodeList = [NSMutableArray<CellNode *> array];
    for (id source in sourceArray) {
        [cellNodeList addObject:
         [CellNode initWithParams:cellHeight cellClass:cellClass cellData:source]];
    }
    return cellNodeList;
}

- (BOOL)isRealCell {
    return self.cellType == CellTypeNormal || self.cellType == CellTypeFirst || self.cellType == CellTypeLast;
}

@end
