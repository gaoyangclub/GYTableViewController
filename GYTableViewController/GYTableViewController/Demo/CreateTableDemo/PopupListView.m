//
//  PopupListView.m
//  GYTableViewController
//
//  Created by gaoyang on 2019/2/7.
//  Copyright © 2019年 高扬. All rights reserved.
//

#import "PopupListView.h"
#import "GYTableBaseView.h"
#import "PopupListViewCell.h"

@interface PopupListView()<GYTableBaseViewDelegate>

@property (nonatomic, strong) GYTableBaseView *tableView;

@end

@implementation PopupListView

#pragma mark - 在每次弹窗中都会执行viewWillAppear调整视图数据
- (void)viewWillAppear {
    
    //首次创建tableView，无上拉加载和下拉刷新控件的干净实例，并设置delegate
    if (!self.tableView) {
        self.tableView = [GYTableBaseView table:self];//创建并设置delegate
        //设置TableView底部Cell细线样式
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        //设置需要pop的容器
        self.contentArea = self.tableView;
    } else {
        [self.tableView clearAllSectionNode];//上一次的数据全部清除，dataArray的内容可能已经改变
    }
    
    [self.tableView addSectionNode:[SectionNode initWithParams:^(SectionNode *sNode) {
        [sNode addCellNodeByList:[CellNode dividingCellNodeBySourceArray:50 cellClass:PopupListViewCell.class sourceArray:self.dataArray]];
    }]];
    [self.tableView gy_reloadData];//不要忘了刷新Table
}

#pragma mark - delegate选中后关闭弹窗
- (void)didSelectRow:(GYTableBaseView *)tableView indexPath:(NSIndexPath *)indexPath {
    [self dismiss];
}

@end
