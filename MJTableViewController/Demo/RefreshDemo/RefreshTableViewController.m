//
//  RefreshTableViewController.m
//  MJTableViewController
//
//  Created by admin on 2018/3/23.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "RefreshTableViewController.h"
#import "RefreshBannerViewCell.h"
#import "RefreshHotViewCell.h"
#import "HotModel.h"
#import "FundModel.h"
#import "RefreshFundViewCell.h"
#import "RefreshFundViewSection.h"

@interface RefreshTableViewController ()

@property(nonatomic,retain)NSArray<NSString*>* bannerUrlGroup;
@property(nonatomic,retain)NSArray<HotModel*>* hotModels;
@property(nonatomic,retain)NSArray<FundModel*>* fundModels;

@property(nonatomic,retain)NSArray<FundModel*>* fundNewModels;

@end

@implementation RefreshTableViewController

//----------  start ----------
/** 以下作为前端mock的数据，模拟从后台返回的数据结构，真实操作为触发刷新后请求后台获取 **/

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

-(NSArray<HotModel *> *)hotModels{
    if (!_hotModels) {
        _hotModels = @[
                      [HotModel initWithParams:@"大盘走势" iconName:@"fundHot01"],
                      [HotModel initWithParams:@"投资咨询" iconName:@"fundHot02"],
                      [HotModel initWithParams:@"收益排行" iconName:@"fundHot03"],
                      [HotModel initWithParams:@"我的关注" iconName:@"fundHot04"]
                      ];
    }
    return _hotModels;
}

-(NSArray<FundModel *> *)fundModels{
    if (!_fundModels) {
        _fundModels = @[
                        [FundModel initWithParams:@"开放式" iconName:ICON_KAI_FANG des:@"国泰医药行业指数分级" rate:@"100%"],
                        [FundModel initWithParams:@"股票式" iconName:ICON_GU_PIAO des:@"光大国企改革主题股票" rate:@"100%"],
                        [FundModel initWithParams:@"债券型" iconName:ICON_ZHAI_QUAN des:@"华泰铂锐稳本增利债券A" rate:@"100%"],
                        [FundModel initWithParams:@"混合型" iconName:ICON_HUN_HE des:@"中海医药精选灵活配置A" rate:@"100%"],
                        [FundModel initWithParams:@"货币基金" iconName:ICON_HUN_HE des:@"华商现金增利货币A" rate:@"100%"],
                        [FundModel initWithParams:@"短期理财" iconName:ICON_DUAN_QI des:@"融通七天债A" rate:@"100%"],
                        [FundModel initWithParams:@"指数型" iconName:ICON_ZHI_SHU des:@"易方达银行指数分级" rate:@"100%"],
                        [FundModel initWithParams:@"保本型" iconName:ICON_BAO_BEN des:@"长城保本混合" rate:@"100%"],
                        [FundModel initWithParams:@"创新型" iconName:ICON_CHUANG_XIN des:@"华夏医疗健康混合A" rate:@"100%"],
                        ];
    }
    return _fundModels;
}

-(NSArray<FundModel *> *)fundNewModels{
    if (!_fundNewModels) {
        _fundNewModels = @[
                           [FundModel initWithParams:@"QDII" iconName:ICON_ZHU_ZHUANG des:@"易方达恒生ETF链接" rate:@"100%"],
                           [FundModel initWithParams:@"QDII" iconName:ICON_ZHU_ZHUANG des:@"易方达恒生ETF链接" rate:@"100%"],
                           [FundModel initWithParams:@"QDII" iconName:ICON_ZHU_ZHUANG des:@"易方达恒生ETF链接" rate:@"100%"],
                           [FundModel initWithParams:@"QDII" iconName:ICON_ZHU_ZHUANG des:@"易方达恒生ETF链接" rate:@"100%"],
                           ];
    }
    return _fundNewModels;
}

//----------  end  ----------

-(void)headerRefresh:(MJTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
            [svo addCellVo:[CellVo initWithParams:230 cellClass:RefreshBannerViewCell.class cellData:self.bannerUrlGroup isUnique:YES]];
            
            [svo addCellVo:[CellVo initWithParams:90 cellClass:RefreshHotViewCell.class cellData:self.hotModels isUnique:YES]];
        }]];
        [tableView addSectionVo:[SectionVo initWithParams:36 sectionHeaderClass:RefreshFundViewSection.class sectionHeaderData:@"精品专区" nextBlock:^(SectionVo *svo) {
            [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:80 cellClass:RefreshFundViewCell.class sourceArray:self.fundModels]];
        }]];
        endRefreshHandler(YES);
    });
}

-(BOOL)isShowFooter{
    return YES;
}

-(void)footerLoadMore:(MJTableBaseView *)tableView endLoadMoreHandler:(FooterLoadMoreHandler)endLoadMoreHandler lastSectionVo:(SectionVo *)lastSectionVo{
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        if([tableView getTotalCellVoCount] > 30){//总共超出30条数据不添加数据
            endLoadMoreHandler(NO);//直接结束上拉加载刷新，并显示"已经全部加载完毕"
            return;
        }
        //根据业务需求的不同，可以继续添加到上一节sectionVo，也可以添加到新的一节sectionVo中
        if([lastSectionVo getCellVoCount] < 15){//上一节少于15条继续添加到上一节
            [lastSectionVo addCellVoByList:[CellVo dividingCellVoBySourceArray:80 cellClass:RefreshFundViewCell.class sourceArray:self.fundNewModels]];//将新增的CellVo实例继续添加到上一节SectionVo实例中
        }else{//上一节超了 添加到下一节中
            [tableView addSectionVo:[SectionVo initWithParams:36 sectionHeaderClass:RefreshFundViewSection.class sectionHeaderData:@"推荐专区" nextBlock:^(SectionVo *svo) {
                [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:80 cellClass:RefreshFundViewCell.class sourceArray:self.fundNewModels]];
            }]];
        }
        endLoadMoreHandler(YES);//不要忘了结束上拉加载刷新
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
