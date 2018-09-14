//
//  UIViewController+GYTableView.m
//  GYTableViewController
//
//  Created by gaoyang on 2018/9/13.
//  Copyright © 2018年 高扬. All rights reserved.
//
#import "UIViewController+GYTableView.h"
#import <objc/runtime.h>

@implementation UIViewController (GYTableView)

+ (void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(loadView) withMethod:@selector(p_loadView)];
        [self swizzleMethod:@selector(viewWillAppear:) withMethod:@selector(p_viewWillAppear:)];
        [self swizzleMethod:@selector(viewDidLoad) withMethod:@selector(p_viewDidLoad)];
        [self swizzleMethod:@selector(viewDidLayoutSubviews) withMethod:@selector(p_viewDidLayoutSubviews)];
    });
}

static const char *GYTableView_tableView = "GYTableView_tableView";
- (GYTableBaseView *)tableView {
    return objc_getAssociatedObject(self, GYTableView_tableView);
}

- (void)setTableView:(GYTableBaseView *)tableView {
    objc_setAssociatedObject(self, GYTableView_tableView, tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *GYTableView_autoRefreshHeader = "GYTableView_autoRefreshHeader";
- (BOOL)autoRefreshHeader {
    return [objc_getAssociatedObject(self, GYTableView_autoRefreshHeader) boolValue];
}

- (void)setAutoRefreshHeader:(BOOL)autoRefreshHeader {
    objc_setAssociatedObject(self, GYTableView_autoRefreshHeader, @(autoRefreshHeader), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *GYTableView_useCellIdentifer = "GYTableView_useCellIdentifer";
- (BOOL)useCellIdentifer {
    return [objc_getAssociatedObject(self, GYTableView_useCellIdentifer) boolValue];
}

- (void)setUseCellIdentifer:(BOOL)useCellIdentifer {
    objc_setAssociatedObject(self, GYTableView_useCellIdentifer, @(useCellIdentifer), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *GYTableView_autoRestOffset = "GYTableView_autoRestOffset";
- (BOOL)autoRestOffset {
    return [objc_getAssociatedObject(self, GYTableView_autoRestOffset) boolValue];
}

- (void)setAutoRestOffset:(BOOL)autoRestOffset {
    objc_setAssociatedObject(self, GYTableView_autoRestOffset, @(autoRestOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *GYTableView_isShowHeader = "GYTableView_isShowHeader";
- (BOOL)isShowHeader {
    return [objc_getAssociatedObject(self, GYTableView_isShowHeader) boolValue];
}

- (void)setIsShowHeader:(BOOL)isShowHeader {
    objc_setAssociatedObject(self, GYTableView_isShowHeader, @(isShowHeader), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *GYTableView_isShowFooter = "GYTableView_isShowFooter";
- (BOOL)isShowFooter {
    return [objc_getAssociatedObject(self, GYTableView_isShowFooter) boolValue];
}

- (void)setIsShowFooter:(BOOL)isShowFooter {
    objc_setAssociatedObject(self, GYTableView_isShowFooter, @(isShowFooter), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath {
    self.tableView.selectedIndexPath = selectedIndexPath;
}

- (NSIndexPath *)selectedIndexPath {
    return nil;
}

- (BOOL)useGYTableView {
    return false;
}

- (void)p_loadView{
    [self p_loadView];
    if (self.useGYTableView) {
        self.autoRefreshHeader = YES;
        self.useCellIdentifer = YES;
        //    self.autoRestOffset = YES;
        self.isShowHeader = YES;
        
        [self p_initTableView];
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
#else
        self.automaticallyAdjustsScrollViewInsets = NO;//YES表示自动测量导航栏高度占用的Insets偏移
#endif
    }
}

- (void)p_initTableView{
    if (!self.tableView) {
        //        BOOL translucent = (self.tabBarController != NULL && self.tabBarController.navigationController != NULL && !self.tabBarController.navigationController.navigationBar.translucent);
        self.tableView = [[GYTableBaseView alloc]initWithFrameAndParams:self.view.frame showHeader:self.isShowHeader showFooter:self.isShowFooter useCellIdentifer:self.useCellIdentifer delegate:self];
        //        self.tableView.gy_delegate = self;
//        self.tableView.backgroundColor = [UIColor brownColor];
        [[self getTableViewParent] addSubview:self.tableView];
        MJRefreshHeader *header = [self getRefreshHeader];
        if (header) {
            self.tableView.header = header;
        }
        MJRefreshFooter *footer = [self getRefreshFooter];
        if (footer) {
            self.tableView.footer = footer;
        }
    }
}

- (void)p_viewWillAppear:(BOOL)animated {
    [self p_viewWillAppear:animated];
    if (self.useGYTableView) {
        if(self.autoRestOffset){// && self.contentOffsetRest
            CGPoint contentOffset = self.tableView.contentOffset;
            contentOffset.y = 0;//滚轮位置恢复
            self.tableView.contentOffset = contentOffset;
        }
    }
}

- (void)p_viewDidLoad {
    [self p_viewDidLoad];
    if (self.useGYTableView) {
        self.tableView.frame = [self getTableViewFrame];
        if (self.autoRefreshHeader) {
            [self.tableView headerBeginRefresh];
        }
    }
}

#pragma mark 坑爹!!! 必须时时跟随主view的frame
- (void)p_viewDidLayoutSubviews {
    if (self.useGYTableView) {
        if (self.tableView.translatesAutoresizingMaskIntoConstraints){//没开启约束
            self.tableView.frame = [self getTableViewFrame];
        }
    }
    [self p_viewDidLayoutSubviews];
}

- (UIView *)getTableViewParent {
    return self.view;
}

- (CGRect)getTableViewFrame {
    return self.view.bounds;
}

- (MJRefreshHeader *)getRefreshHeader {
    return nil;
}

- (MJRefreshFooter *)getRefreshFooter {
    return nil;
}

+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)altSel
{
    Method origMethod = class_getInstanceMethod(self, origSel);
    if (!origSel) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(origSel), [self class]);
        return NO;
    }
    
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!altMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(altSel), [self class]);
        return NO;
    }
    
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel,
                    class_getMethodImplementation(self, altSel),
                    method_getTypeEncoding(altMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSel), class_getInstanceMethod(self, altSel));
    
    return YES;
}



@end
