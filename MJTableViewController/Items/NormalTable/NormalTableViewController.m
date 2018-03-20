//
//  NormalTableViewController.m
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/18.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "NormalTableViewController.h"
#import "BannerViewCell.h"
#import "HotAreaViewCell.h"
#import "ProductViewCell.h"
#import "ProductViewSection.h"

@interface NormalTableViewController ()

@end

@implementation NormalTableViewController

-(BOOL)getShowFooter{
    return NO;
}

//-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
//    //下拉刷新后开始请求后台提供数据，请求到数据后根据解析的内容展开cell实例和位置等操作 代码结构如下
//    //request{
//        tableView{
//            sectionVo{
//                cellVo,
//                cellVo,
//                ...
//            }
//            sectionVo{
//                cellVo,
//                ...
//            }
//            ...
//        }
//        endRefreshHandler();//界面搭建完毕后停止刷新
//    //}
//}

-(BOOL)autoRefreshHeader{
    return NO;
}

-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
        //添加一个高度为230，类型为BannerViewCell，展示"banner.jpg"图片的Cell
        [svo addCellVo:[CellVo initWithParams:230 cellClass:BannerViewCell.class cellData:@"banner.jpg"]];
    }]];
    endRefreshHandler(YES);//不要忘了结束刷新，否则刷新动画会停留原地
}

//-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
//    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
//        [svo addCellVo:[CellVo initWithParams:230 cellClass:BannerViewCell.class cellData:@"banner.jpg" isUnique:YES]];
//        [svo addCellVo:[CellVo initWithParams:100 cellClass:HotAreaViewCell.class cellData:@[@"fundHot02",@"fundHot08",@"fundHot05",@"fundHot10"] isUnique:YES]];
//
////        [svo addCellVo:[CellVo initWithParams:50 cellClass:ProductViewCell.class cellData:@"老李同志"]];
////        [svo addCellVo:[CellVo initWithParams:50 cellClass:ProductViewCell.class cellData:@"老刘同志"]];
////        [svo addCellVo:[CellVo initWithParams:50 cellClass:ProductViewCell.class cellData:@"老郑同志"]];
//    }]];
//
//    [tableView addSectionVo:[SectionVo initWithParams:40 sectionClass:ProductViewSection.class sectionData:@"推荐客户" nextBlock:^(SectionVo *svo) {
//        [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:50 cellClass:ProductViewCell.class
//                                                     sourceArray:@[
//                                                                   @"老李同志",
//                                                                   @"老刘同志",
//                                                                   @"老郑同志",
//                                                                   @"老陈同志",
//                                                                   @"老王同志",
//                                                                   @"老金同志",
//                                                                   @"老陆同志",
//                                                                   @"老周同志",
//                                                                   @"老包同志"
//                                                                   ]]];
//    }]];
//    [tableView addSectionVo:[SectionVo initWithParams:40 sectionClass:ProductViewSection.class sectionData:@"潜力客户" nextBlock:^(SectionVo *svo) {
//        [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:50 cellClass:ProductViewCell.class
//                                                     sourceArray:@[
//                                                                   @"老铁同志",
//                                                                   @"老铁同志",
//                                                                   @"老铁同志",
//                                                                   @"老铁同志",
//                                                                   @"老铁同志",
//                                                                   @"老铁同志",
//                                                                   @"老铁同志",
//                                                                   @"老铁同志",
//                                                                   @"老铁同志"
//                                                                   ]]];
//    }]];
//
//
//    endRefreshHandler(YES);
//}

- (void)viewDidLoad {
    self.title = @"常用刷新控制器示例";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
