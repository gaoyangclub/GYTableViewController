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

//-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
//    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
//        //添加一个高度为230，类型为BannerViewCell，展示"banner.jpg"图片的Cell
//        [svo addCellVo:[CellVo initWithParams:230 cellClass:BannerViewCell.class cellData:@"banner.jpg"]];
//    }]];
//    endRefreshHandler(YES);//不要忘了结束刷新，否则刷新动画会停留原地
//}

//-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
//    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
//        //添加一个高度为230，类型为BannerViewCell，展示"banner.jpg"图片的Cell
//        [svo addCellVo:[CellVo initWithParams:230 cellClass:BannerViewCell.class cellData:@"banner.jpg"]];
//        
//    }]];
//    //注意banner和用户列表属于不同区域，应存放到各自section中添加，管理section视图会比较方便
//    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
//        //添加三个高度为50，类型为ProductViewCell，展示用户信息的Cell
//        [svo addCellVo:[CellVo initWithParams:50 cellClass:ProductViewCell.class cellData:@"老李同志"]];
//        [svo addCellVo:[CellVo initWithParams:50 cellClass:ProductViewCell.class cellData:@"老刘同志"]];
//        [svo addCellVo:[CellVo initWithParams:50 cellClass:ProductViewCell.class cellData:@"老郑同志"]];
//    }]];
//    endRefreshHandler(YES);//不要忘了结束刷新，否则刷新动画会停留原地
//}

//-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
//    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
//        //添加一个高度为230，类型为BannerViewCell，展示"banner.jpg"图片的Cell
//        [svo addCellVo:[CellVo initWithParams:230 cellClass:BannerViewCell.class cellData:@"banner.jpg"]];
//    }]];
//    //注意banner和用户列表属于不同区域，应存放到各自section中添加，管理section视图会比较方便
//    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
//        NSArray* sourceArray = @[@"老李同志",@"老刘同志",@"老郑同志"];//数据源数组，表示从后台获取的原始数组
//        //按照数组结构的数据遍历后批量创建cell实例，数据分别传递给创建的cell实例
//        [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:50 cellClass:ProductViewCell.class sourceArray:sourceArray]];
//    }]];
//    endRefreshHandler(YES);//不要忘了结束刷新，否则刷新动画会停留原地
//}


//-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
//    [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
//        [svo addCellVo:[CellVo initWithParams:230 cellClass:BannerViewCell.class cellData:@"banner.jpg" isUnique:YES]];
//        [svo addCellVo:[CellVo initWithParams:100 cellClass:HotAreaViewCell.class cellData:@[@"fundHot02",@"fundHot08",@"fundHot05",@"fundHot10"] isUnique:YES]];
//    }]];
//    endRefreshHandler(YES);
//}

//-(BOOL)autoRefreshHeader{
//    return NO;
//}

-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
            [svo addCellVo:[CellVo initWithParams:230 cellClass:BannerViewCell.class cellData:@"banner.jpg" isUnique:YES]];
            [svo addCellVo:[CellVo initWithParams:100 cellClass:HotAreaViewCell.class cellData:@[@"fundHot02",@"fundHot08",@"fundHot05",@"fundHot10"] isUnique:YES]];
        }]];
        NSArray* sourceArray1 = @[@"老李同志", @"老刘同志", @"老郑同志", @"老陈同志", @"老王同志", @"老金同志", @"老陆同志", @"老周同志", @"老包同志"];//数据源数组，表示从后台获取的原始数组
        //SectionVo在创建的时候设置section高度为40、section类型为ProductViewSection、sectionData为标题文本，列表上将显示这一节视图
        [tableView addSectionVo:[SectionVo initWithParams:40 sectionClass:ProductViewSection.class sectionData:@"推荐客户" nextBlock:^(SectionVo *svo) {
            [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:50 cellClass:ProductViewCell.class sourceArray:sourceArray1]];
        }]];
        NSArray* sourceArray2 = @[@"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志"];
        //SectionVo在创建的时候设置section高度为40、section类型为ProductViewSection、sectionData为标题文本，列表上将显示这一节视图
        [tableView addSectionVo:[SectionVo initWithParams:40 sectionClass:ProductViewSection.class sectionData:@"潜力客户" nextBlock:^(SectionVo *svo) {
            [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:50 cellClass:ProductViewCell.class
                                                         sourceArray:sourceArray2]];
        }]];
        endRefreshHandler(YES);//不要忘了结束上拉加载刷新
    });
}

//显示上拉加载
-(BOOL)isShowFooter{
    return YES;
}
////endLoadMoreHandler:结束刷新回调block,lastSectionVo:上一节sectionVo数据，即当前列表页最后一节
//-(void)footerLoadMore:(MJTableBaseView *)tableView endLoadMoreHandler:(FooterLoadMoreHandler)endLoadMoreHandler lastSectionVo:(SectionVo *)lastSectionVo{
//    NSArray* sourceArray2 = @[@"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志"];
//    //继续添加到上一节
//    [lastSectionVo addCellVoByList:[CellVo dividingCellVoBySourceArray:50 cellClass:ProductViewCell.class
//                                                           sourceArray:sourceArray2]];//将新增的CellVo实例继续添加到上一节SectionVo实例中
//    endLoadMoreHandler(YES);
//}

-(void)footerLoadMore:(MJTableBaseView *)tableView endLoadMoreHandler:(FooterLoadMoreHandler)endLoadMoreHandler lastSectionVo:(SectionVo *)lastSectionVo{
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        if([tableView getTotalCellVoCount] > 30){//总共超出30条数据不添加数据
            endLoadMoreHandler(NO);//直接结束上拉加载刷新，并显示"已经全部加载完毕"
            return;
        }
        NSArray* sourceArray2 = @[@"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志", @"老铁同志"];
        //根据业务需求的不同，可以继续添加到上一节sectionVo，也可以添加到新的一节sectionVo中
        if([lastSectionVo getCellVoCount] < 10){//上一节少于10条继续添加到上一节
            [lastSectionVo addCellVoByList:[CellVo dividingCellVoBySourceArray:50 cellClass:ProductViewCell.class
                                                                   sourceArray:sourceArray2]];//将新增的CellVo实例继续添加到上一节SectionVo实例中
        }else{//上一节超了 添加到下一节中
            [tableView addSectionVo:[SectionVo initWithParams:40 sectionClass:ProductViewSection.class sectionData:@"潜力客户新" nextBlock:^(SectionVo *svo) {
                [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:50 cellClass:ProductViewCell.class
                                                             sourceArray:sourceArray2]];
            }]];
        }
        endLoadMoreHandler(YES);//不要忘了结束上拉加载刷新
    });
}

- (void)viewDidLoad {
    self.title = @"常用刷新控制器示例";
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
