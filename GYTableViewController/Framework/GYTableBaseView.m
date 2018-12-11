//
//  GYTableBaseView.m
//  GYTableViewController
//
//  Created by 高扬 on 16/10/13.
//  Copyright © 2016年 高扬. All rights reserved.
//

#import "GYTableBaseView.h"
#import "GYRefreshAutoFooter.h"
#import <objc/runtime.h>
//#import <Foundation/Foundation.h>

//#define iOS9+ [UIDevice currentDevice].systemVersion.doubleValue >= 9.0

typedef enum {
    CellTypeNormal,//除头尾中间段的
    CellTypeFirst,//小组第一个
    CellTypeLast,//小组最后一个
    CellTypeSectionGap,//section的gap
    CellTypeCellGap //cell的gap
} CellType;

@interface SectionVo()

/** 存储该节包含的cellVo数据列表 注:包含用户数据和gap数据 不能直接对外遍历使用 **/
@property (nonatomic,strong) NSMutableArray<CellVo *> *cellVoList;
//@property (nonatomic,assign) BOOL isSectionGap;//作为间距容器存在

@end

@interface CellVo()

@property (nonatomic,assign)CellType cellType;

- (BOOL)isRealCell;

@end

@interface GYTableBaseView()<UITableViewDelegate,UITableViewDataSource>{//
    
}
@property (nonatomic,strong) NSMutableArray<SectionVo *> *dataArray;

@property (nonatomic,assign) BOOL useCellIdentifer;
@property (nonatomic,assign) BOOL showHeader;
@property (nonatomic,assign) BOOL showFooter;

@property (nonatomic, weak) id<GYTableBaseViewDelegate> gy_delegate;
/**
 *  是否设置顶部偏离 满足ViewController在自动测量导航栏高度占用的Insets偏移的补位
 */
//@property (nonatomic,assign) BOOL topEdgeDiverge;

@end

@implementation GYTableBaseView

- (instancetype)initWithFrameAndParams:(CGRect)frame showHeader:(BOOL)showHeader showFooter:(BOOL)showFooter useCellIdentifer:(BOOL)useCellIdentifer delegate:(id<GYTableBaseViewDelegate>)delegate{// topEdgeDiverge:(BOOL)topEdgeDiverge
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

- (NSMutableArray<SectionVo*> *)dataArray {
    if(!_dataArray){
        _dataArray = [[NSMutableArray<SectionVo *> alloc]init];
    }
    return _dataArray;
}

- (NSMutableArray<SectionVo *> *)dataSourceArray {
    return self.dataArray;
}

/** 重新刷新界面 */
- (void)headerBeginRefresh {
    if (!self.mj_header.isRefreshing) {
        [self clearAllSectionVo];
        [self reloadData];
        [self.mj_header beginRefreshing];
    }
}

- (void)clearAllSectionVo {
    _selectedIndexPath = nil;
    [self.dataArray removeAllObjects];
}

- (void)addSectionVo:(SectionVo*)sectionVo {
    [self.dataArray addObject:sectionVo];
}

- (void)insertSectionVo:(SectionVo *)sectionVo atIndex:(NSInteger)index {
    [self.dataArray insertObject:sectionVo atIndex:index];
}

- (void)removeSectionVoAt:(NSInteger)index {
    [self.dataArray removeObjectAtIndex:index];
}

- (SectionVo*)getSectionVoByIndex:(NSInteger)index {
    if (index < self.dataArray.count) {
        return self.dataArray[index];
    }
    return nil;
}

- (CellVo *)getCellVoByIndexPath:(NSIndexPath *)indexPath {
    SectionVo *sectionVo = [self getSectionVoByIndex:indexPath.section];
    if (sectionVo && sectionVo.cellVoList && indexPath.row < sectionVo.cellVoList.count) {
        return sectionVo.cellVoList[indexPath.row];
    }
    return nil;
}

- (NSUInteger)getSectionVoCount {
    return self.dataArray.count;
}

- (NSUInteger)getTotalCellVoCount {
    NSInteger cellCount = 0;
    for (SectionVo *svo in self.dataArray) {
        for (__unused CellVo *cvo in svo.cellVoList) {
            cellCount ++;
        }
    }
    return cellCount;
}

/**----- mark下 如下代码利用runtime动态增加代理方法给外部控制器使用，存在一些问题，暂时还是手动放开底部一堆delegate方法进行转发   start  -----*/

- (void)setGy_delegate:(id<GYTableBaseViewDelegate>)gy_delegate {
    _gy_delegate = gy_delegate;
    
//    unsigned int mothCout_f = 0;
//    Method* mothList_f = class_copyMethodList([_gy_delegate class],&mothCout_f);
//    for(int i = 0; i < mothCout_f; i++)
//    {
//        Method temp_f = mothList_f[i];
////        IMP imp_f = method_getImplementation(temp_f);
//        SEL name_f = method_getName(temp_f);
//        const char* name_s = sel_getName(method_getName(temp_f));
//        int arguments = method_getNumberOfArguments(temp_f);
//        const char* encoding = method_getTypeEncoding(temp_f);
//        
//        if(![self respondsToSelector:name_f] &&
//           (ProtocolContainSel(@protocol(UITableViewDelegate),name_f) || ProtocolContainSel(@protocol(UITableViewDataSource),name_f))
//           ){//没有实现 添加实
//            class_addMethod(self.class,name_f,(IMP)addMethodForMyClass,encoding);
//            NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
//                  arguments,[NSString stringWithUTF8String:encoding]);
//        }
//    }
//    free(mothList_f);
}

//static void addMethodForMyClass(id self, SEL _cmd, id fistPara,...) {
//    // 获取类中指定名称实例成员变量的信息
////    Ivar ivar = class_getInstanceVariable([self class], "test");
//    // 获取整个成员变量列表
//    //   Ivar * class_copyIvarList ( Class cls, unsigned intint * outCount );
//    // 获取类中指定名称实例成员变量的信息
//    //   Ivar class_getInstanceVariable ( Class cls, const charchar *name );
//    // 获取类成员变量的信息
//    //   Ivar class_getClassVariable ( Class cls, const charchar *name );
//    
//    // 返回名为test的ivar变量的值
////    id obj = object_getIvar(self, ivar);
////    NSLog(@"%@",obj);
////    NSLog(@"addMethodForMyClass:参数：%@",test);
////    NSLog(@"ClassName：%@",NSStringFromClass([self class]));
//    if ([self isKindOfClass:GYTableBaseView.class]) {
//        id gy_delegate = ((GYTableBaseView*)self).gy_delegate;
//        if ([gy_delegate respondsToSelector:_cmd]) {
//            
//            //创建签名对象的时候不是使用NSMethodSignature这个类创建，而是方法属于谁就用谁来创建
//            NSMethodSignature*signature = [[gy_delegate class] instanceMethodSignatureForSelector:_cmd];
//            //1、创建NSInvocation对象
//            NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
//            invocation.target = gy_delegate;
//            //invocation中的方法必须和签名中的方法一致。
//            invocation.selector = _cmd;
//            
//            NSInteger startIndex = 2;
//            [invocation setArgument:&fistPara atIndex:startIndex++];
//            
////            if([NSStringFromSelector(_cmd) isEqual:@"tableView:shouldHighlightRowAtIndexPath:"]){
//                //1.定义一个指向个数可变的参数列表指针；
//                va_list args;
//                //2.va_start(args, fistPara);
//                va_start(args, fistPara);
//                id eachObject;
//                
//                @try {
//                    //执行的代码，如果异常,就会抛出，程序不继续执行啦
//                    while ((eachObject = va_arg(args, id))) {
//                        if([eachObject isKindOfClass:UIDevice.class]){
//                            break;
//                        }
//                        //[invocation setArgument:&eachObject atIndex:startIndex++];
//                        //        NSLog(@"%@",eachObject);
//                    }
//                } @catch (NSException *exception) {
//                    //捕获异常
//                    NSLog(@"%@",exception);
//                }
//                va_end(args);
////            }
//            
//            [invocation invoke];
//        }
//    }
//}

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    return [super resolveInstanceMethod:sel];
//}

//struct objc_method_description MethodDescriptionForSELInProtocol(Protocol *protocol, SEL sel) {
//    struct objc_method_description description = protocol_getMethodDescription(protocol, sel, YES, YES);
//    if (description.types) {
//        return description;
//    }
//    description = protocol_getMethodDescription(protocol, sel, NO, YES);
//    if (description.types) {
//        return description;
//    }
//    return (struct objc_method_description){NULL, NULL};
//}
//
//BOOL ProtocolContainSel(Protocol *protocol, SEL sel) {
//    return MethodDescriptionForSELInProtocol(protocol, sel).types ? YES: NO;
//}

/**----------------   end   ------------**/

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
    
        self.delegate = self;
        self.dataSource = self;
        
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
            footer.stateLabel.userInteractionEnabled = NO;//无法点击交互
            [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
            self.footer = footer;
        }
//    });
}

- (void)setHeader:(MJRefreshHeader *)header {
    if (self.showHeader) {
        __weak __typeof(self) weakSelf = self;
        header.refreshingBlock = ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.gy_delegate && [strongSelf.gy_delegate respondsToSelector:@selector(headerRefresh:endRefreshHandler:)]) {
                [strongSelf clearAllSectionVo];//预先清除数据
                [strongSelf.gy_delegate headerRefresh:strongSelf endRefreshHandler:^(BOOL hasData){
                    strongSelf->_hasFirstRefreshed = YES;
                    [strongSelf gy_reloadData];
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

- (void)setFooter:(MJRefreshFooter *)footer {
    if (self.showFooter) {
        __weak __typeof(self) weakSelf = self;
        footer.refreshingBlock = ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.gy_delegate && [strongSelf.gy_delegate respondsToSelector:@selector(footerLoadMore:endLoadMoreHandler:lastSectionVo:)]){
                [strongSelf.gy_delegate footerLoadMore:strongSelf endLoadMoreHandler:^(BOOL hasData){
                    //                        [strongSelf footerLoaded:hasData];
                    if (hasData) {
                        [strongSelf checkGaps];
                        //                            strongSelf.refreshAll = NO;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [strongSelf reloadData];
                            if (strongSelf.gy_delegate && [strongSelf.gy_delegate respondsToSelector:@selector(didLoadMoreComplete:)]){
                                [strongSelf.gy_delegate didLoadMoreComplete:strongSelf];
                            }
                        });
                        [strongSelf.mj_footer endRefreshing];
                    }else{
                        [strongSelf.mj_footer endRefreshingWithNoMoreData];
                    }
                } lastSectionVo:[strongSelf getLastSectionVo]];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SectionVo *sectionVo = [self getSectionVoByIndex:section];
    return sectionVo ? sectionVo.sectionHeaderHeight : 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return [self tableView:tableView heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    SectionVo *sectionVo = [self getSectionVoByIndex:section];
    return sectionVo ? sectionVo.sectionFooterHeight : 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return [self tableView:tableView heightForFooterInSection:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SectionVo *sectionVo = [self getSectionVoByIndex:section];
    return sectionVo && sectionVo.cellVoList ? sectionVo.cellVoList.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if(section >= self.dataArray.count){
        NSLog(@"产生无效UITableViewCell 可能是一个刷新列表正在进行中 另一个刷新就来了引起的");
        return [[UITableViewCell alloc] init];
    }
    SectionVo *sectionVo = [self getSectionVoByIndex:section];
    CellVo *cellVo = sectionVo.cellVoList[row];//获取的数据给cell显示
    Class cellClass = cellVo.cellClass;
//    if(autoCellClass != nil){
//        cellClass = autoCellClass!
//    }
    
    GYTableViewCell *cell;
    BOOL isCreate = NO;
    if(self.useCellIdentifer) {
        NSString *cellIdentifer;
        NSString *classString = NSStringFromClass(cellClass);
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
    
    if (isCreate) { //创建阶段设置
        cell.backgroundColor = [UIColor clearColor];//无色
    }
    if (isCreate || !cell.isSubviewShow || !cellVo.isUnique || (cellVo.isUnique && cellVo.forceUpdate)) {//cell.cellVo !=
        cell.needRefresh = YES; //需要刷新
    } else {
        cell.needRefresh = NO; //不需要刷新
    }
//    NSObject* data = cellVo.cellData;
    cell.isSingle = sectionVo.cellVoList.count <= 1;
    cell.isFirst = cellVo.cellType == CellTypeFirst;
    if (sectionVo.cellVoList != NULL) {
        cell.isLast = cellVo.cellType == CellTypeLast;//row == source.data!.count - 1//索引在最后
    }
    cell.indexPath = indexPath;
    cell.tableView = self;
//    cell.data = data;
    cell.cellVo = cellVo;
    
    //当cellVo数据设置完毕后再设置选中样式，有可能根据业务数据返回showSelectionStyle值
    if ([cell showSelectionStyle]) {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.selected = [indexPath isEqual:self.selectedIndexPath];
    
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(preparCell:targetCell:indexPath:)]) {
        [self.gy_delegate preparCell:self targetCell:cell indexPath:indexPath];
    }
    
    return cell;
}

//防止子类交互影响屏蔽父类
- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellVo *cellVo = [self getCellVoByIndexPath:indexPath];
    if (cellVo) {
        return cellVo.cellHeight;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionVo *sectionVo = [self getSectionVoByIndex:section];
    Class headerClass = sectionVo.sectionHeaderClass;
    GYTableViewSection* sectionView;
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

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SectionVo *sectionVo = [self getSectionVoByIndex:section];
    Class footerClass = sectionVo.sectionFooterClass;
    GYTableViewSection* sectionView;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
        [self.gy_delegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
//    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(didSelectRow:didSelectRowAtIndexPath:)]) {
//        [self.gy_delegate didSelectRow:self didSelectRowAtIndexPath:indexPath];
//    }
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
                CellVo *cvo = svo.cellVoList[j];
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

- (SectionVo *)getSectionGapVo {
//    if (svo != nil) {
//        svo.sectionHeaderHeight = self.sectionGap;
//    }else{
    SectionVo *svo = [SectionVo initWithParams:0 sectionHeaderClass:nil sectionHeaderData:nil nextBlock:^(SectionVo *svo) {
        CellVo *cvo = [CellVo initWithParams:self.sectionGap cellClass:[GYTableViewCell class] cellData:nil];
        cvo.cellType = CellTypeSectionGap;
        [svo addCellVo:cvo];
    }];
//    }
    return svo;
}

- (CellVo *)getCellGapCellVo{
    CellVo *cvo = [CellVo initWithParams:self.cellGap cellClass:[GYTableViewCell class] cellData:nil];
    cvo.cellType = CellTypeCellGap;
    return cvo;
}

- (SectionVo *)getLastSectionVo {
    if (self.dataArray.count > 0) {
        return self.dataArray.lastObject;
    }
    return NULL;
}

- (SectionVo *)getFirstSectionVo {
    if (self.dataArray.count > 0) {
        return self.dataArray.firstObject;
    }
    return NULL;
}

// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.gy_delegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(didScrollToRow:indexPath:)]) {
        //        NSLog(@"这是第%li栏目",(long)path.section);
        [self.gy_delegate didScrollToRow:self indexPath:indexPath];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(didScrollToRow:indexPath:)]) {
    //        NSIndexPath *path =  [self indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    ////        NSLog(@"这是第%li栏目",(long)path.section);
    //        [self.gy_delegate didScrollToRow:self indexPath:path];
    //    }
    if(self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(scrollViewDidScroll:)]){
        [self.gy_delegate scrollViewDidScroll:scrollView];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.gy_delegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [self.gy_delegate tableView:tableView willDisplayHeaderView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
        [self.gy_delegate tableView:tableView willDisplayFooterView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        [self.gy_delegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
        [self.gy_delegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
        [self.gy_delegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [self.gy_delegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:didHighlightRowAtIndexPath:)]) {
        [self.gy_delegate tableView:tableView didHighlightRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)]) {
        [self.gy_delegate tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
    }
}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        return [self.gy_delegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    }
    return indexPath;
}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
        return [self.gy_delegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
    }
    return indexPath;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        return [self.gy_delegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.gy_delegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleNone;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.gy_delegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return nil;
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]) {
        return [self.gy_delegate tableView:tableView editActionsForRowAtIndexPath:indexPath];
    }
    return nil;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
        return [self.gy_delegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }
    return false;
}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
        [self.gy_delegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
        [self.gy_delegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
}
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)]) {
        [self.gy_delegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)]) {
        return [self.gy_delegate tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
    return 0;
}
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)]) {
        return [self.gy_delegate tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    }
    return false;
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)]) {
        return [self.gy_delegate tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
    return false;
}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)]) {
        [self.gy_delegate tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
}
- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0) {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:canFocusRowAtIndexPath:)]) {
        [self.gy_delegate tableView:tableView canFocusRowAtIndexPath:indexPath];
    }
    return YES;
}
- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0) {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(indexPathForPreferredFocusedViewInTableView:)]) {
        [self.gy_delegate indexPathForPreferredFocusedViewInTableView:tableView];
    }
    return nil;
}
- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0) {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:shouldUpdateFocusInContext:)]) {
        [self.gy_delegate tableView:tableView shouldUpdateFocusInContext:context];
    }
    return YES;
}
- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0) {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:didUpdateFocusInContext:withAnimationCoordinator:)]) {
        [self.gy_delegate tableView:tableView didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    }
}
// fixed font style. use custom view (UILabel) if you want something different
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        [self.gy_delegate tableView:tableView titleForHeaderInSection:section];
    }
    return nil;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        [self.gy_delegate tableView:tableView titleForFooterInSection:section];
    }
    return nil;
}
// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        [self.gy_delegate tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
}
// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
        [self.gy_delegate tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    return NO;
}
// return list of section titles to display in section index view (e.g. "ABCD...Z#")
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        [self.gy_delegate sectionIndexTitlesForTableView:tableView];
    }
    return nil;
}
// tell table which section corresponds to section title/index (e.g. "B",1))
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
        [self.gy_delegate tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }
    return -1;
}
// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.gy_delegate tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}
// Data manipulation - reorder / moving support
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
        [self.gy_delegate tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}
// any zoom scale changes
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.gy_delegate scrollViewDidZoom:scrollView];
    }
}
// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.gy_delegate scrollViewWillBeginDragging:scrollView];
    }
}
// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest 这个方法比较奇怪 必须实现后才能被动态捕捉
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.gy_delegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}
// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.gy_delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}
// called on finger up as we are moving
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.gy_delegate scrollViewWillBeginDecelerating:scrollView];
    }
}
// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.gy_delegate scrollViewDidEndDecelerating:scrollView];
    }
}
// return a view that will be scaled. if delegate returns nil, nothing happens
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.gy_delegate viewForZoomingInScrollView:scrollView];
    }
    return nil;
}
// called before the scroll view begins zooming its content
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.gy_delegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}
// scale between minimum and maximum. called after any 'bounce' animations
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.gy_delegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}
// return a yes if you want to scroll to the top. if not defined, assumes YES
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.gy_delegate scrollViewShouldScrollToTop:scrollView];
    }
    return YES;
}
// called when scrolling animation finished. may be called immediately if already at top
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.gy_delegate scrollViewDidScrollToTop:scrollView];
    }
}
#if __IPHONE_11_0
/* Also see -[UIScrollView adjustedContentInsetDidChange]
 */
- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView API_AVAILABLE(ios(11.0), tvos(11.0)) {
    if (self.gy_delegate && [self.gy_delegate respondsToSelector:@selector(scrollViewDidChangeAdjustedContentInset:)]) {
        [self.gy_delegate scrollViewDidChangeAdjustedContentInset:scrollView];
    }
}
#endif

@end

@implementation SectionVo

+ (instancetype)initWithParams:(void (^)(SectionVo *svo))nextBlock{
    return [SectionVo initWithParams:0 sectionHeaderClass:nil sectionHeaderData:nil nextBlock:nextBlock];
}

+ (instancetype)initWithParams:(CGFloat)sectionHeaderHeight sectionHeaderClass:(Class)sectionHeaderClass sectionHeaderData:(id)sectionHeaderData nextBlock:(void (^)(SectionVo *))nextBlock {
    return [SectionVo initWithParams:sectionHeaderHeight sectionHeaderClass:sectionHeaderClass sectionHeaderData:sectionHeaderData sectionFooterHeight:0 sectionFooterClass:nil sectionFooterData:nil nextBlock:nextBlock];
}

+ (instancetype)initWithParams:(CGFloat)sectionHeaderHeight sectionHeaderClass:(Class)sectionHeaderClass sectionHeaderData:(id)sectionHeaderData sectionFooterHeight:(CGFloat)sectionFooterHeight sectionFooterClass:(Class)sectionFooterClass sectionFooterData:(id)sectionFooterData nextBlock:(void (^)(SectionVo *))nextBlock {
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

- (NSMutableArray<CellVo *> *)cellVoList{
    if(!_cellVoList){
        _cellVoList = [NSMutableArray<CellVo *> array];
    }
    return _cellVoList;
}

- (NSInteger)getCellVoCount {
    if (!self.cellVoList || self.cellVoList.count == 0) {
        return 0;
    }
    NSInteger count = 0;
    for (CellVo *cvo in self.cellVoList) {
        if ([cvo isRealCell]) {
            count++;
        }
    }
    return count;
}

- (void)addCellVo:(CellVo *)cellVo {
    [self.cellVoList addObject:cellVo];
}

- (void)addCellVoByList:(NSArray<CellVo *> *)otherVoList {
    [self.cellVoList addObjectsFromArray:otherVoList];
}

@end

@implementation CellVo

+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(NSObject*)cellData {
    return [CellVo initWithParams:cellHeight cellClass:cellClass cellData:cellData isUnique:false];
}

+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData isUnique:(BOOL)isUnique {
    return [CellVo initWithParams:cellHeight cellClass:cellClass cellData:cellData isUnique:isUnique forceUpdate:false];
}

+ (instancetype)initWithParams:(CGFloat)cellHeight cellClass:(Class)cellClass cellData:(id)cellData isUnique:(BOOL)isUnique forceUpdate:(BOOL)forceUpdate
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

+ (NSArray<CellVo *> *)dividingCellVoBySourceArray:(CGFloat)cellHeight cellClass:(Class)cellClass sourceArray:(NSArray *)sourceArray {
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

- (BOOL)isRealCell {
    return self.cellType == CellTypeNormal || self.cellType == CellTypeFirst || self.cellType == CellTypeLast;
}

@end
