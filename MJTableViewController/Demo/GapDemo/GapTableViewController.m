
//
//  GapTableViewController.m
//  MJTableViewController
//
//  Created by admin on 2018/3/26.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "GapTableViewController.h"
#import "PraiseModel.h"
#import "GapPraiseGroupCell.h"

@interface GapTableViewController ()

@property(nonatomic,retain)PraiseModel* praiseModels;

@end

@implementation GapTableViewController

-(PraiseModel *)praiseModels{
    if (!_praiseModels) {
        _praiseModels = [PraiseModel initWithParams:@"附近生活圈" hotModels:@[
                                                                         [HotModel initWithParams:@"老张牛肉面" iconName:@"https://img.meituan.net/msmerchant/6208ee8e69966ac794b0478c3f370e7f535324.jpg%40340w_255h_1e_1c_1l%7Cwatermark%3D1%26%26r%3D1%26p%3D9%26x%3D2%26y%3D2%26relative%3D1%26o%3D20"],
                                                                         [HotModel initWithParams:@"大雄家烧味" iconName:@"http://p1.meituan.net/mogu/c42e4c0fc12f25be4e35285951726a05245231.jpg%40340w_255h_1e_1c_1l%7Cwatermark%3D1%26%26r%3D1%26p%3D9%26x%3D2%26y%3D2%26relative%3D1%26o%3D20"],
                                                                         [HotModel initWithParams:@"谢大牛馆" iconName:@"https://img.meituan.net/msmerchant/c4d8a1cb9685fbbb22e121c7e637dcdc830432.jpg%40340w_255h_1e_1c_1l%7Cwatermark%3D1%26%26r%3D1%26p%3D9%26x%3D2%26y%3D2%26relative%3D1%26o%3D20"],
                                                                         ]];
    }
    return _praiseModels;
}

-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
            [svo addCellVo:[CellVo initWithParams:150 cellClass:GapPraiseGroupCell.class cellData:self.praiseModels]];
            [svo addCellVo:[CellVo initWithParams:150 cellClass:GapPraiseGroupCell.class cellData:self.praiseModels]];
            [svo addCellVo:[CellVo initWithParams:150 cellClass:GapPraiseGroupCell.class cellData:self.praiseModels]];
        }]];
        endRefreshHandler(YES);
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.sectionGap = 10;
    self.tableView.cellGap = 5;
    
    self.view.backgroundColor = COLOR_BACKGROUND;
}



@end
