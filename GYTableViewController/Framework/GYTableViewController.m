
//
//  GYTableViewController.m
//  GYTableViewController
//
//  Created by 高扬 on 16/10/17.
//  Copyright © 2016年 高扬. All rights reserved.
//

#import "GYTableViewController.h"

@interface GYTableViewController ()

@end

@implementation GYTableViewController

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 0;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return nil;
//}

-(void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath{
    self.tableView.selectedIndexPath = selectedIndexPath;
}

-(void)loadView{
    [super loadView];
    self.autoRefreshHeader = YES;
    self.useCellIdentifer = YES;
//    self.autoRestOffset = YES;
    self.isShowHeader = YES;
    
//    self.automaticallyAdjustsScrollViewInsets = NO;//YES表示自动测量导航栏高度占用的Insets偏移
//    self.navigationController.navigationBar.translucent = NO;//    Bar的高斯模糊效果，默认为YES
//    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
//    [self.navigationController.navigationBar setTranslucent:NO];
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self initTableView];
}

-(void)initTableView{
    if (!self.tableView) {
        
//        BOOL translucent = (self.tabBarController != NULL && self.tabBarController.navigationController != NULL && !self.tabBarController.navigationController.navigationBar.translucent);
        
        self.tableView = [[GYTableBaseView alloc]initWithFrameAndParams:self.view.frame showHeader:self.isShowHeader showFooter:self.isShowFooter useCellIdentifer:self.useCellIdentifer
                                                         topEdgeDiverge:
//                          (self.navigationController != NULL && !self.navigationController.navigationBar.translucent)
                          NO
                          ];
//        self.tableView.alpha = 0.3;
        self.tableView.refreshDelegate = self;
        [self.view addSubview:self.tableView];
        MJRefreshHeader* header = [self getRefreshHeader];
        if (header) {
            self.tableView.header = header;
        }
//        MJRefreshFooter* footer = [self getRefreshFooter];
//        if (footer) {
//            self.tableView.mj_footer = footer;
//        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.autoRestOffset){// && self.contentOffsetRest
        CGPoint contentOffset = self.tableView.contentOffset;
        contentOffset.y = 0;//滚轮位置恢复
        self.tableView.contentOffset = contentOffset;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = [self getTableViewFrame];
    if (self.autoRefreshHeader) {
        [self.tableView headerBeginRefresh];
    }
}
#pragma 坑爹!!! 必须时时跟随主view的frame
-(void)viewDidLayoutSubviews{
    self.tableView.frame = [self getTableViewFrame];
    [super viewDidLayoutSubviews];
}

-(CGRect)getTableViewFrame {
    return self.view.bounds;
}

-(MJRefreshHeader *)getRefreshHeader{
    return nil;
}

-(MJRefreshFooter *)getRefreshFooter{
    return nil;
}

@end
