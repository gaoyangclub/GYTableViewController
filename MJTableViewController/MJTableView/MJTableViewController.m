
//
//  MJTableViewController.m
//  MJRefreshTest
//
//  Created by admin on 16/10/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MJTableViewController.h"

@interface MJTableViewController ()//<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MJTableViewController

-(void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath{
    self.tableView.selectedIndexPath = selectedIndexPath;
}

-(void)loadView{
    [super loadView];
    self.autoRefreshHeader = YES;
//    self.contentOffsetRest = YES;
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
        
        self.tableView = [[MJTableBaseView alloc]initWithFrameAndParams:self.view.frame showHeader:[self getShowHeader] showFooter:[self getShowFooter] useCellIdentifer:[self getUseCellIdentifer]
                                                         topEdgeDiverge:
//                          (self.navigationController != NULL && !self.navigationController.navigationBar.translucent)
                          NO
                          ];
//        self.tableView.alpha = 0.3;
        self.tableView.refreshDelegate = self;
        [self.view addSubview:self.tableView];
        MJRefreshHeader* header = [self getHeader];
        if (header) {
            self.tableView.header = header;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([self getNeedRestOffset]){// && self.contentOffsetRest
        CGPoint contentOffset = self.tableView.contentOffset;
        contentOffset.y = 0;//滚轮位置恢复
        self.tableView.contentOffset = contentOffset;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = [self getTableViewFrame];
//    self.tableView.backgroundColor = [UIColor brownColor];
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
//    return CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, CGRectGetWidth(self.view.frame), 603 - 40);
    return self.view.bounds;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)getShowHeader {
    return YES;
}

-(BOOL)getShowFooter {
    return NO;
}

-(BOOL)getUseCellIdentifer {
    return YES;
}

-(BOOL)getNeedRestOffset{
    return NO;
}

-(MJRefreshHeader*)getHeader {
    return NULL;
}

@end
