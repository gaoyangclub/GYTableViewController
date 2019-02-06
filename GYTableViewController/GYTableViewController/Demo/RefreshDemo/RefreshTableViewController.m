//
//  RefreshTableViewController.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/23.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "RefreshTableViewController.h"
#import "RefreshBannerViewCell.h"
#import "RefreshHotViewCell.h"
#import "RefreshFundViewCell.h"
#import "RefreshFundViewSection.h"
#import "Mock.h"

@interface RefreshTableViewController ()

@end

@implementation RefreshTableViewController

#pragma mark 使用该控件
- (BOOL)gy_useTableView {
    return YES;
}

#pragma mark 显示上拉加载控件
- (BOOL)gy_useLoadMoreFooter {
    return YES;
}

#pragma mark delegate触发下拉刷新(交互或代码)
- (void)headerRefresh:(GYTableBaseView *)tableView {
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        [tableView addSectionNode:[SectionNode initWithParams:^(SectionNode *sNode) {
//            [sNode addCellNode:[CellNode initWithParams:500 cellClass:BlankCell.class cellData:nil isUnique:YES]];
            //添加一个高度为230，类型为BannerViewCell，展示banner图片列表的Cell
            [sNode addCellNode:[CellNode initWithParams:230 cellClass:RefreshBannerViewCell.class cellData:Mock.bannerUrlGroup isUnique:YES]];
            
            //添加一个高度为90，类型为RefreshHotViewCell，展示标签按钮区域的Cell
            [sNode addCellNode:[CellNode initWithParams:90 cellClass:RefreshHotViewCell.class cellData:Mock.hotModels isUnique:YES]];
        }]];
        //设置页眉
        [tableView addSectionNode:[SectionNode initWithParams:36 sectionHeaderClass:RefreshFundViewSection.class sectionHeaderData:@"精品专区" nextBlock:^(SectionNode *sNode) {
            //添加多个高度为80，类型为RefreshFundViewCell，展示基金信息的Cell
            [sNode addCellNodeByList:[CellNode dividingCellNodeBySourceArray:80 cellClass:RefreshFundViewCell.class sourceArray:Mock.fundModels]];
        }]];
        [tableView headerEndRefresh:YES];
    });
}

#pragma mark delegate触发上拉加载(交互或代码)
- (void)footerLoadMore:(GYTableBaseView *)tableView lastSectionNode:(SectionNode *)lastSectionNode {
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay)), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        if ([tableView getTotalCellNodeCount] > 30) {//总共超出30条数据不添加数据
            [tableView footerEndLoadMore:NO];//直接结束上拉加载刷新，并显示"已经全部加载完毕"
            return;
        }
        //根据业务需求的不同，可以继续添加到上一节sectionNode，也可以添加到新的一节sectionNode中
        if ([lastSectionNode getCellNodeCount] < 15) {//上一节少于15条继续添加到上一节sectionNode
            [lastSectionNode addCellNodeByList:[CellNode dividingCellNodeBySourceArray:80 cellClass:RefreshFundViewCell.class sourceArray:Mock.fundNewModels]];
        } else {//上一节超了 添加到新的一节sectionNode
            [tableView addSectionNode:[SectionNode initWithParams:36 sectionHeaderClass:RefreshFundViewSection.class sectionHeaderData:@"推荐专区" nextBlock:^(SectionNode *sNode) {
                [sNode addCellNodeByList:[CellNode dividingCellNodeBySourceArray:80 cellClass:RefreshFundViewCell.class sourceArray:Mock.fundNewModels]];
            }]];
        }
        [tableView footerEndLoadMore:YES];//不要忘了结束上拉加载刷新
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = TVStyle.colorBackground;
}

@end
