//
//  FrameTableViewController.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/25.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "FrameTableViewController.h"
#import "FrameDishesViewCell.h"
#import "WebViewController.h"
#import "DiyRotateRefreshHeader.h"
#import "Mock.h"
//#import "Masonry.h"

@interface FrameTableViewController ()

@property (nonatomic, strong) UIView *noticeBack;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UILabel *noticeIcon;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation FrameTableViewController

#pragma mark 使用该控件
- (BOOL)gy_useTableView {
    return YES;
}
#pragma mark 设置tableView位置信息
//如存在和容器底部对齐的元素，请在此方法对齐底部位置(默认占满controller边界)；autoLayerout无需重写此方法，自行设置tableView和其他元素布局关系
- (CGRect)gy_getTableViewFrame {
    self.noticeBack.frame = CGRectMake(0, 0, self.view.width, 30);
    
    self.submitButton.maxY = self.view.height;
    
    //返回设置好的tableView位置frame 高度=总高度-公告区高-底部按钮高
    return CGRectMake(0, self.noticeBack.height, self.view.width, self.view.height - self.noticeBack.height - self.submitButton.height);
}

#pragma mark 自定义上拉加载控件
- (MJRefreshHeader *)gy_getRefreshHeader {
    return [[DiyRotateRefreshHeader alloc]init];
}

#pragma mark delegate触发下拉刷新(交互或代码)
- (void)headerRefresh:(GYTableBaseView *)tableView {
    int64_t delay = 0.5 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
        [tableView addSectionNode:[SectionNode initWithParams:^(SectionNode *sNode) {
            [sNode addCellNodeByList:[CellNode dividingCellNodeBySourceArray:80 cellClass:FrameDishesViewCell.class sourceArray:Mock.dishesModels]];
        }]];
        [tableView headerEndRefresh:YES];
    });
}

#pragma mark delegate侦听选中的Cell并跳转页面
- (void)didSelectRow:(GYTableBaseView *)tableView indexPath:(NSIndexPath *)indexPath {
    CellNode *cNode = [tableView getCellNodeByIndexPath:indexPath];
    DishesModel *dishesModel = cNode.cellData;
    WebViewController* webViewController = [[WebViewController alloc]init];
    webViewController.linkUrl = dishesModel.linkUrl;
    webViewController.navigationTitle = dishesModel.title;
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark 子视图布局 父视图的位置最好在getTableViewFrame方法中执行
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = TVStyle.colorBackground;
    
    CGFloat const leftMargin = 10;
    
    self.noticeLabel.centerY = self.noticeIcon.centerY = self.noticeBack.height / 2.;
    self.noticeIcon.x = leftMargin;
    self.noticeLabel.x = self.noticeIcon.maxX + leftMargin;
    
    self.submitButton.x = 0;
    self.submitButton.width = self.view.width;
    self.submitButton.height = 50;
}

//调用autoLayerout工具Masonry测试 完全可行 不需要实现gy_getTableViewFrame方法 在viewDidLoad中替换最后7行代码
//    [self.noticeBack mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@30);
//        make.left.right.top.equalTo(self.view);
//    }];
//    [self.noticeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@(leftMargin));
//        make.centerY.equalTo(self.noticeBack);
//    }];
//    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.noticeIcon.mas_right).offset(leftMargin);
//        make.centerY.equalTo(self.noticeBack);
//    }];
//    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@50);
//        make.left.right.bottom.equalTo(self.view);
//    }];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.noticeBack.mas_bottom);
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.submitButton.mas_top);
//    }];

#pragma mark 懒加载添加视图
- (UIView *)noticeBack {
    if (!_noticeBack) {
        _noticeBack = [[UIView alloc]init];
        _noticeBack.backgroundColor = TVStyle.colorNoticeBack;
        [self.view addSubview:_noticeBack];
    }
    return _noticeBack;
}

- (UILabel *)noticeIcon {
    if (!_noticeIcon) {
        _noticeIcon = [UICreationUtils createLabel:TVStyle.iconFontName size:16 color:[UIColor whiteColor] text:TVStyle.iconGongGao sizeToFit:YES superView:self.noticeBack];
    }
    return _noticeIcon;
}

- (UILabel *)noticeLabel {
    if (!_noticeLabel) {
        _noticeLabel = [UICreationUtils createLabel:TVStyle.sizeTextSecondary color:[UIColor whiteColor] text:@"春季数码产品新款上市，全场3折，预购从速" sizeToFit:YES superView:self.noticeBack];
    }
    return _noticeLabel;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _submitButton.backgroundColor = TVStyle.colorPrimaryDishes;
        [_submitButton setTitle:@"结   算" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:20];
        
        [self.view addSubview:_submitButton];
        
        //        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

@end
