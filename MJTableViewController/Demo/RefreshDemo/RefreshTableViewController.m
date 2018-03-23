//
//  RefreshTableViewController.m
//  MJTableViewController
//
//  Created by admin on 2018/3/23.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "RefreshTableViewController.h"
#import "RefreshBannerViewCell.h"

@interface RefreshTableViewController ()

@property(nonatomic,retain)NSArray<NSString*>* bannerUrlGroup;

@end

@implementation RefreshTableViewController

-(NSArray<NSString *> *)bannerUrlGroup{
    if (!_bannerUrlGroup) {
        _bannerUrlGroup = @[
                            @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                            @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                            @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                            ];
    }
    return _bannerUrlGroup;
}

-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
            [svo addCellVo:[CellVo initWithParams:230 cellClass:RefreshBannerViewCell.class cellData:self.bannerUrlGroup isUnique:YES]];
        }]];
        endRefreshHandler(YES);
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
