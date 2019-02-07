//
//  MainViewController.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/25.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "MainViewController.h"

#import "RefreshTableViewController.h"
#import "FrameTableViewController.h"
#import "GapTableViewController.h"
#import "RelateTableViewController.h"
#import "AutoHeightTableViewController.h"
#import "CreateTableViewController.h"

//#import "GYTableViewCell.h"

@interface ControllerNode:NSObject

@property (nonatomic,copy) NSString *title;

@property (nonatomic,strong) Class controllerClass;

+ (instancetype)initWithTitle:(NSString *)title andClass:(Class)controllerClass;

@end

@implementation ControllerNode

+ (instancetype)initWithTitle:(NSString *)title andClass:(Class)controllerClass {
    ControllerNode *instance;
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
            instance.title = title;
            instance.controllerClass = controllerClass;
        }
    }
    return instance;
}

@end

@interface ControllerDemoViewCell : GYTableViewCell

@end
@implementation ControllerDemoViewCell

- (void)showSubviews {
    self.textLabel.text = ((ControllerNode *)[self getCellData]).title;
}

- (BOOL)showSelectionStyle {
    return YES;
}

@end


@interface MainViewController ()

@property (nonatomic, strong) NSArray<ControllerNode *> *controllers;

@end

@implementation MainViewController

- (NSArray<ControllerNode *> *)controllers {
    if (!_controllers) {
        _controllers = @[
                         [ControllerNode initWithTitle:@"下拉刷新上拉加载示例" andClass:RefreshTableViewController.class],
                         [ControllerNode initWithTitle:@"Table位置、自定义刷新、点击跳转示例" andClass:FrameTableViewController.class],
                         [ControllerNode initWithTitle:@"Section或Cell间距示例" andClass:GapTableViewController.class],
                         [ControllerNode initWithTitle:@"Cell上下关系和选中高亮示例" andClass:RelateTableViewController.class],
                         [ControllerNode initWithTitle:@"Cell自动调整高度示例" andClass:AutoHeightTableViewController.class],
                         [ControllerNode initWithTitle:@"自定义创建TableView示例" andClass:CreateTableViewController.class],
                         ];
    }
    return _controllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView addSectionNode:[SectionNode initWithParams:^(SectionNode *sNode) {
                    [sNode addCellNodeByList:[CellNode dividingCellNodeBySourceArray:50 cellClass:ControllerDemoViewCell.class sourceArray:self.controllers]];
                }]];
    [self.tableView gy_reloadData];
}

- (BOOL)gy_useTableView {
    return YES;
}

- (BOOL)gy_useRefreshHeader {
    return NO;
}

- (void)didSelectRow:(GYTableBaseView *)tableView indexPath:(NSIndexPath *)indexPath {
    CellNode *cNode = [tableView getCellNodeByIndexPath:indexPath];
    ControllerNode *controllerNode = cNode.cellData;
    UIViewController *viewController = [[controllerNode.controllerClass alloc]init];
    viewController.title = controllerNode.title;
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
