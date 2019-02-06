//
//  RelateTableViewController.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/27.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "RelateTableViewController.h"
#import "RelateExpressViewCell.h"
#import "Mock.h"

@interface RelateTableViewController ()

@property (nonatomic, strong) UIView *operateArea;

@property (nonatomic, strong) UILabel *labelClickHighlight;
@property (nonatomic, strong) UISwitch *switchClickHighlight;
@property (nonatomic, strong) UILabel *labelClickMoveToCenter;
@property (nonatomic, strong) UISwitch *switchClickMoveToCenter;
@property (nonatomic, strong) UILabel *labelSteperSelectedIndex;
@property (nonatomic, strong) UIStepper *steperSelectedIndex;

@end

@implementation RelateTableViewController

#pragma mark 使用该控件
- (BOOL)gy_useTableView {
    return YES;
}

#pragma mark 设置tableView位置信息
- (CGRect)gy_getTableViewFrame {
    self.operateArea.frame = CGRectMake(0, 0, self.view.width, 70);
    CGFloat const gap = 5;
    return CGRectMake(0, self.operateArea.height + gap, self.view.width, self.view.height - self.operateArea.height - gap);
}

#pragma mark delegate下拉刷新后根据选择控件选中情况设置selectedIndexPath，clickCellHighlight，clickCellMoveToCenter等属性
- (void)headerRefresh:(GYTableBaseView *)tableView {
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        [tableView addSectionNode:[SectionNode initWithParams:^(SectionNode *sNode) {
            [sNode addCellNodeByList:[CellNode dividingCellNodeBySourceArray:50 cellClass:RelateExpressViewCell.class sourceArray:Mock.expressModels]];
        }]];
        tableView.selectedIndexPath = [NSIndexPath indexPathForRow:self.steperSelectedIndex.value - 1 inSection:0];
        tableView.clickCellHighlight = self.switchClickHighlight.on;
        tableView.clickCellMoveToCenter = self.switchClickMoveToCenter.on;
        [tableView headerEndRefresh:YES];
    });
}

#pragma mark delegate监听选中某个Cell
- (void)didSelectRow:(GYTableBaseView *)tableView indexPath:(NSIndexPath *)indexPath {
    if(self.switchClickHighlight.on){
        self.steperSelectedIndex.value = indexPath.row + 1;
    }
}

#pragma mark 视图布局 父视图的位置最好在getTableViewFrame方法中执行
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TVStyle.colorBackground;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
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

- (void)p_moveToCenterChanged {
    self.tableView.clickCellMoveToCenter = self.switchClickMoveToCenter.on;
}

- (void)p_steperChanged {
    self.tableView.selectedIndexPath = [NSIndexPath indexPathForRow:self.steperSelectedIndex.value - 1 inSection:0];
    if(self.switchClickMoveToCenter.on){
        [self.tableView moveSelectedIndexPathToCenter];
    }
}

- (void)p_highlightChanged {
    self.tableView.clickCellHighlight = self.switchClickHighlight.on;
}

#pragma mark 懒加载添加交互控件和点击后处理
- (UIView *)operateArea {
    if (!_operateArea) {
        _operateArea = [[UIView alloc]init];
        _operateArea.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_operateArea];
    }
    return _operateArea;
}

- (UILabel *)labelSteperSelectedIndex {
    if (!_labelSteperSelectedIndex) {
        _labelSteperSelectedIndex = [UICreationUtils createLabel:TVStyle.sizeTextPrimary color:TVStyle.colorTextPrimary text:@"选中索引位置调整" sizeToFit:YES superView:self.operateArea];
    }
    return _labelSteperSelectedIndex;
}

- (UIStepper *)steperSelectedIndex {
    if (!_steperSelectedIndex) {
        _steperSelectedIndex = [[UIStepper alloc]init];
        _steperSelectedIndex.minimumValue = 1;
        _steperSelectedIndex.maximumValue = Mock.expressModels.count;
        _steperSelectedIndex.stepValue = 1;
        _steperSelectedIndex.value = 1;
        [self.operateArea addSubview:_steperSelectedIndex];
        [_steperSelectedIndex addTarget:self action:@selector(p_steperChanged) forControlEvents:UIControlEventValueChanged];
    }
    return _steperSelectedIndex;
}

- (UILabel *)labelClickHighlight {
    if (!_labelClickHighlight) {
        _labelClickHighlight = [UICreationUtils createLabel:TVStyle.sizeTextPrimary color:TVStyle.colorTextPrimary text:@"点击选中Cell高亮" sizeToFit:YES superView:self.operateArea];
    }
    return _labelClickHighlight;
}

- (UISwitch *)switchClickHighlight {
    if (!_switchClickHighlight) {
        _switchClickHighlight = [[UISwitch alloc]init];
        [_switchClickHighlight addTarget:self action:@selector(p_highlightChanged) forControlEvents:UIControlEventValueChanged];
        [self.operateArea addSubview:_switchClickHighlight];
    }
    return _switchClickHighlight;
}

- (UILabel *)labelClickMoveToCenter {
    if (!_labelClickMoveToCenter) {
        _labelClickMoveToCenter = [UICreationUtils createLabel:TVStyle.sizeTextPrimary color:TVStyle.colorTextPrimary text:@"选中Cell自动居中" sizeToFit:YES superView:self.operateArea];
    }
    return _labelClickMoveToCenter;
}

- (UISwitch *)switchClickMoveToCenter {
    if (!_switchClickMoveToCenter) {
        _switchClickMoveToCenter = [[UISwitch alloc]init];
        [_switchClickMoveToCenter addTarget:self action:@selector(p_moveToCenterChanged) forControlEvents:UIControlEventValueChanged];
        [self.operateArea addSubview:_switchClickMoveToCenter];
    }
    return _switchClickMoveToCenter;
}

@end
