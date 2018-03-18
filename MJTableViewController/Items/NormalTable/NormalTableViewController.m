//
//  NormalTableViewController.m
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/18.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "NormalTableViewController.h"
#import "BannerViewCell.h"
@interface NormalTableViewController ()

@end

@implementation NormalTableViewController

-(BOOL)getShowFooter{
    return NO;
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    [self.tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
        [svo addCellVo:[CellVo initWithParams:230 cellClass:BannerViewCell.class cellData:@"banner.jpg"]];
    }]];
    handler(YES);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
