//
//  AutoHeightTableViewController.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/28.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "AutoHeightTableViewController.h"
#import "AutoHeightWeiboCell.h"
#import "Mock.h"

@interface AutoHeightTableViewController ()

@end

@implementation AutoHeightTableViewController

//----------  end ----------
#pragma mark 使用该控件
- (BOOL)gy_useTableView {
    return YES;
}

#pragma mark delegate触发下拉刷新(交互或代码)
- (void)headerRefresh:(GYTableBaseView *)tableView {
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        [tableView addSectionNode:[SectionNode initWithParams:^(SectionNode *sNode) {
            [sNode addCellNodeByList:[CellNode dividingCellNodeBySourceArray:CELL_AUTO_HEIGHT cellClass:AutoHeightWeiboCell.class sourceArray:Mock.weiboModels]];
        }]];
        [tableView headerEndRefresh:YES];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = TVStyle.colorBackground;
}

@end
