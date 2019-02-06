
//
//  GapTableViewController.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/26.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "GapTableViewController.h"
#import "GapPraiseGroupCell.h"
#import "GapStoreViewCell.h"
#import "GapStoreHeaderCell.h"
#import "Mock.h"

@interface GapTableViewController ()

@end

@implementation GapTableViewController

#pragma mark 使用该控件
- (BOOL)gy_useTableView {
    return YES;
}

#pragma mark - delegate触发下拉刷新(交互或代码)
- (void)headerRefresh:(GYTableBaseView *)tableView {
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        [tableView addSectionNode:[SectionNode initWithParams:^(SectionNode *sNode) {
            [sNode addCellNode:[CellNode initWithParams:150 cellClass:GapPraiseGroupCell.class cellData:Mock.praiseModel]];
        }]];
        
        [tableView addSectionNode:[SectionNode initWithParams:^(SectionNode *sNode) {
            [sNode addCellNode:[CellNode initWithParams:70 cellClass:GapStoreHeaderCell.class cellData:nil]];
            [sNode addCellNodeByList:[CellNode dividingCellNodeBySourceArray:120 cellClass:GapStoreViewCell.class sourceArray:Mock.storeModels]];
        }]];
        
        [tableView addSectionNode:[SectionNode initWithParams:^(SectionNode *sNode) {
            [sNode addCellNode:[CellNode initWithParams:150 cellClass:GapPraiseGroupCell.class cellData:Mock.praiseModel]];
        }]];
        
        [tableView addSectionNode:[SectionNode initWithParams:^(SectionNode *sNode) {
            [sNode addCellNode:[CellNode initWithParams:70 cellClass:GapStoreHeaderCell.class cellData:nil]];
            [sNode addCellNodeByList:[CellNode dividingCellNodeBySourceArray:120 cellClass:GapStoreViewCell.class sourceArray:Mock.storeModels]];
        }]];
        
        [tableView headerEndRefresh:YES];
    });
}

#pragma mark 设置间距
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.sectionGap = 6;//设置每一节区域之间间距
    self.tableView.cellGap = 3;//设置每个Cell之间间距(包含每一节区域)
    
    self.view.backgroundColor = TVStyle.colorBackground;
}

@end
