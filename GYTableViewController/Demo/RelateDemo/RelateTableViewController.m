//
//  RelateTableViewController.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/27.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "RelateTableViewController.h"
#import "ExpressModel.h"
#import "RelateExpressViewCell.h"

@interface RelateTableViewController ()

@property(nonatomic,retain)NSArray<ExpressModel*>* expressModels;
@property(nonatomic,retain)UIView* operateArea;

@property(nonatomic,retain)UILabel* labelClickHighlight;
@property(nonatomic,retain)UISwitch* switchClickHighlight;
@property(nonatomic,retain)UILabel* labelClickMoveToCenter;
@property(nonatomic,retain)UISwitch* switchClickMoveToCenter;
@property(nonatomic,retain)UILabel* labelSteperSelectedIndex;
@property(nonatomic,retain)UIStepper* steperSelectedIndex;

@end

@implementation RelateTableViewController

#pragma mark 懒加载添加交互控件和点击后处理
-(UIView *)operateArea{
    if (!_operateArea) {
        _operateArea = [[UIView alloc]init];
        _operateArea.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_operateArea];
    }
    return _operateArea;
}

-(UILabel *)labelSteperSelectedIndex{
    if (!_labelSteperSelectedIndex) {
        _labelSteperSelectedIndex = [UICreationUtils createLabel:SIZE_TEXT_PRIMARY color:COLOR_TEXT_PRIMARY text:@"选中索引位置调整" sizeToFit:YES superView:self.operateArea];
    }
    return _labelSteperSelectedIndex;
}

-(UIStepper *)steperSelectedIndex{
    if (!_steperSelectedIndex) {
        _steperSelectedIndex = [[UIStepper alloc]init];
        _steperSelectedIndex.minimumValue = 1;
        _steperSelectedIndex.maximumValue = self.expressModels.count;
        _steperSelectedIndex.stepValue = 1;
        _steperSelectedIndex.value = 1;
        [self.operateArea addSubview:_steperSelectedIndex];
        [_steperSelectedIndex addTarget:self action:@selector(steperChanged) forControlEvents:UIControlEventValueChanged];
    }
    return _steperSelectedIndex;
}

-(void)steperChanged{
    self.tableView.selectedIndexPath = [NSIndexPath indexPathForRow:self.steperSelectedIndex.value - 1 inSection:0];
    if(self.switchClickMoveToCenter.on){
        [self.tableView moveSelectedIndexPathToCenter];
    }
}

-(UILabel *)labelClickHighlight{
    if (!_labelClickHighlight) {
        _labelClickHighlight = [UICreationUtils createLabel:SIZE_TEXT_PRIMARY color:COLOR_TEXT_PRIMARY text:@"点击选中Cell高亮" sizeToFit:YES superView:self.operateArea];
    }
    return _labelClickHighlight;
}

-(UISwitch *)switchClickHighlight{
    if (!_switchClickHighlight) {
        _switchClickHighlight = [[UISwitch alloc]init];
        [_switchClickHighlight addTarget:self action:@selector(highlightChanged) forControlEvents:UIControlEventValueChanged];
        [self.operateArea addSubview:_switchClickHighlight];
    }
    return _switchClickHighlight;
}

-(void)highlightChanged{
    self.tableView.clickCellHighlight = self.switchClickHighlight.on;
}

-(UILabel *)labelClickMoveToCenter{
    if (!_labelClickMoveToCenter) {
        _labelClickMoveToCenter = [UICreationUtils createLabel:SIZE_TEXT_PRIMARY color:COLOR_TEXT_PRIMARY text:@"选中Cell自动居中" sizeToFit:YES superView:self.operateArea];
    }
    return _labelClickMoveToCenter;
}

-(UISwitch *)switchClickMoveToCenter{
    if (!_switchClickMoveToCenter) {
        _switchClickMoveToCenter = [[UISwitch alloc]init];
        [_switchClickMoveToCenter addTarget:self action:@selector(moveToCenterChanged) forControlEvents:UIControlEventValueChanged];
        [self.operateArea addSubview:_switchClickMoveToCenter];
    }
    return _switchClickMoveToCenter;
}

-(void)moveToCenterChanged{
    self.tableView.clickCellMoveToCenter = self.switchClickMoveToCenter.on;
}

//----------  start ----------
/** 以下作为前端mock的数据，模拟从后台返回的数据结构，真实操作为触发刷新后请求后台获取 **/
#pragma mark monk数据
-(NSArray<ExpressModel *> *)expressModels{
    if (!_expressModels) {
        _expressModels = @[
                           [ExpressModel initWithParams:@"货物已完成配送，感谢选择百世快递" year:@"2017-09-13" time:@"11:51"],
                           [ExpressModel initWithParams:@"配送员开始配送，请您准备收货" year:@"2017-09-13" time:@"07:41"],
                           [ExpressModel initWithParams:@"货物已分配，等待配送" year:@"2017-09-13" time:@"07:33"],
                           [ExpressModel initWithParams:@"货物已到达【广州体育站】" year:@"2017-09-13" time:@"06:21"],
                           [ExpressModel initWithParams:@"货物已完成分拣【广州亚-分拣中心】" year:@"2017-09-12" time:@"20:10"],
                           [ExpressModel initWithParams:@"货物已到达【广州亚-分拣中心】" year:@"2017-09-12" time:@"15:58"],
                           [ExpressModel initWithParams:@"货物已交付百世快递" year:@"2017-09-12" time:@"15:43"],
                           [ExpressModel initWithParams:@"货物已到达【广州总-分拣中心】" year:@"2017-09-12" time:@"15:31"],
                           
                           [ExpressModel initWithParams:@"货物已完成配送，感谢选择百世快递" year:@"2017-09-13" time:@"11:51"],
                           [ExpressModel initWithParams:@"配送员开始配送，请您准备收货" year:@"2017-09-13" time:@"07:41"],
                           [ExpressModel initWithParams:@"货物已分配，等待配送" year:@"2017-09-13" time:@"07:33"],
                           [ExpressModel initWithParams:@"货物已到达【广州体育站】" year:@"2017-09-13" time:@"06:21"],
                           [ExpressModel initWithParams:@"货物已完成分拣【广州亚-分拣中心】" year:@"2017-09-12" time:@"20:10"],
                           [ExpressModel initWithParams:@"货物已到达【广州亚-分拣中心】" year:@"2017-09-12" time:@"15:58"],
                           [ExpressModel initWithParams:@"货物已交付百世快递" year:@"2017-09-12" time:@"15:43"],
                           [ExpressModel initWithParams:@"货物已到达【广州总-分拣中心】" year:@"2017-09-12" time:@"15:31"],
                           ];
    }
    return _expressModels;
}

//----------  end ----------

#pragma mark 下拉刷新后根据选择控件选中情况设置selectedIndexPath，clickCellHighlight，clickCellMoveToCenter等属性
-(void)headerRefresh:(GYTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
            [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:50 cellClass:RelateExpressViewCell.class sourceArray:self.expressModels]];
        }]];
        tableView.selectedIndexPath = [NSIndexPath indexPathForRow:self.steperSelectedIndex.value - 1 inSection:0];
        tableView.clickCellHighlight = self.switchClickHighlight.on;
        tableView.clickCellMoveToCenter = self.switchClickMoveToCenter.on;
        endRefreshHandler(YES);
    });
}

#pragma mark 监听选中某个Cell
-(void)tableView:(GYTableBaseView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.switchClickHighlight.on){
        self.steperSelectedIndex.value = indexPath.row + 1;
    }
}

#pragma mark 设置tableView位置信息
-(CGRect)getTableViewFrame{
    self.operateArea.frame = CGRectMake(0, 0, self.view.width, 70);
    CGFloat const gap = 5;
    return CGRectMake(0, self.operateArea.height + gap, self.view.width, self.view.height - self.operateArea.height - gap);
}

#pragma mark 视图布局 父视图的位置最好在getTableViewFrame方法中执行
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BACKGROUND;
    
    CGFloat const toppadding = 30;
    CGFloat const bottompadding = self.operateArea.height - toppadding;
    
    self.steperSelectedIndex.x = 20;
    
    self.switchClickHighlight.centerX = self.operateArea.width / 2.;
    
    self.switchClickMoveToCenter.maxX = self.operateArea.width - 40;
    
    self.steperSelectedIndex.centerY = self.switchClickHighlight.centerY = self.switchClickMoveToCenter.centerY = toppadding + bottompadding / 2.;
    
    self.labelSteperSelectedIndex.centerX = self.steperSelectedIndex.centerX;
    self.labelClickHighlight.centerX = self.switchClickHighlight.centerX;
    self.labelClickMoveToCenter.centerX = self.switchClickMoveToCenter.centerX;
    
    self.labelSteperSelectedIndex.centerY = self.labelClickHighlight.centerY = self.labelClickMoveToCenter.centerY = toppadding / 2.;
    
    
}


@end
