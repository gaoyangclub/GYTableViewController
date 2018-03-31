
//
//  GapTableViewController.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/26.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "GapTableViewController.h"
#import "PraiseModel.h"
#import "GapPraiseGroupCell.h"
#import "StoreModel.h"
#import "GapStoreViewCell.h"
#import "GapStoreHeaderCell.h"

@interface GapTableViewController ()

@property(nonatomic,retain)PraiseModel* praiseModels;
@property(nonatomic,retain)NSArray<StoreModel*>* storeModels;

@end

@implementation GapTableViewController

//----------  start ----------
/** 以下作为前端mock的数据，模拟从后台返回的数据结构，真实操作为触发刷新后请求后台获取 **/

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

-(NSArray<StoreModel *> *)storeModels{
    if (!_storeModels) {
        _storeModels = @[
                         [StoreModel initWithParams:@"金草帽炭火烤肉（望京店)" iconName:@"http://p0.meituan.net/600.600/deal/c8cc7a1c865e0b65504c5cafda09020f48188.jpg@1275w_1275h_1e_1c" hot:@"4.1分" des:@"周一至周日 全天" discount:@"9折"],
                         [StoreModel initWithParams:@"福口居（北太平庄店）" iconName:@"https://img.meituan.net/600.600/msmerchant/3ff5b78217da04bd79839e2b9a19ca02683868.jpg@1275w_1275h_1e_1c" hot:@"5分" des:@"人均￥63" discount:@"6折"],
                         [StoreModel initWithParams:@"比格比萨（西单明珠餐厅）" iconName:@"http://p0.meituan.net/600.600/mogu/92d839a7e0ef51b6dec3d1e2ba997bb5267281.jpg@1275w_1275h_1e_1c" hot:@"3.7分" des:@"西城区明珠商场8层" discount:@"5折"],
                         [StoreModel initWithParams:@"韩时烤肉（枫蓝国际购物中心店）" iconName:@"https://img.meituan.net/600.600/msmerchant/a5bd62d75978e6434d87735872c1b1b3287453.jpg@1275w_1275h_1e_1c" hot:@"4.5分" des:@"人均￥69" discount:@"8折"],
                         [StoreModel initWithParams:@"狗不理包子（前门店）" iconName:@"http://p0.meituan.net/600.600/deal/201211/09/_1109143551.jpg@1275w_1275h_1e_1c" hot:@"3.2分" des:@"西城区前门大栅栏街29-31号" discount:@"7折"],
                         [StoreModel initWithParams:@"虾吃虾涮（长楹天街店）" iconName:@"http://p0.meituan.net/600.600/deal/925a2357b79e829f92819a9b2e421c84294677.jpg@1275w_1275h_1e_1c" hot:@"4.5分" des:@"人均￥65" discount:@"5折"],
                         [StoreModel initWithParams:@"神话烤鱼香锅川菜（五道口店）" iconName:@"http://p0.meituan.net/600.600/mogu/71b47ffe74bf1c30e684ea61fec6c280206798.jpg@1275w_1275h_1e_1c" hot:@"4.1分" des:@"海淀区五道口华联商场往南300米" discount:@"9折"],
                         ];
    }
    return _storeModels;
}

//----------  end ----------

-(void)headerRefresh:(GYTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
            [svo addCellVo:[CellVo initWithParams:150 cellClass:GapPraiseGroupCell.class cellData:self.praiseModels]];
        }]];
        
        [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
            [svo addCellVo:[CellVo initWithParams:70 cellClass:GapStoreHeaderCell.class cellData:nil]];
            [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:120 cellClass:GapStoreViewCell.class sourceArray:self.storeModels]];
        }]];
        
        [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
            [svo addCellVo:[CellVo initWithParams:150 cellClass:GapPraiseGroupCell.class cellData:self.praiseModels]];
        }]];
        
        [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
            [svo addCellVo:[CellVo initWithParams:70 cellClass:GapStoreHeaderCell.class cellData:nil]];
            [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:120 cellClass:GapStoreViewCell.class sourceArray:self.storeModels]];
        }]];
        
        endRefreshHandler(YES);
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.sectionGap = 6;//设置每一节区域之间间距
    self.tableView.cellGap = 3;//设置每个Cell之间间距(包含每一节区域)
    
    self.view.backgroundColor = COLOR_BACKGROUND;
}



@end
