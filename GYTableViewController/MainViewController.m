//
//  MainViewController.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/25.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "RefreshTableViewController.h"
#import "FrameTableViewController.h"
#import "MainViewController.h"
#import "GapTableViewController.h"
#import "RelateTableViewController.h"
#import "AutoHeightTableViewController.h"

@interface ControllerVo:NSObject

@property(nonatomic,copy)NSString* title;

@property(nonatomic,retain)Class controllerClass;

+(instancetype)initWithTitle:(NSString*)title andClass:(Class)controllerClass;

@end

@implementation ControllerVo

+(instancetype)initWithTitle:(NSString *)title andClass:(Class)controllerClass{
    ControllerVo *instance;
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

-(void)showSubviews{
    self.textLabel.text = ((ControllerVo*)GET_CELL_DATA(ControllerVo.class)).title;
}

-(BOOL)showSelectionStyle{
    return YES;
}

@end


@interface MainViewController ()

@property(nonatomic,retain)NSArray<ControllerVo*>* controllers;

@end

@implementation MainViewController

-(NSArray<ControllerVo *> *)controllers{
    if (!_controllers) {
        _controllers = @[
                         [ControllerVo initWithTitle:@"下拉刷新上拉加载示例" andClass:RefreshTableViewController.class],
                         [ControllerVo initWithTitle:@"Table位置、自定义刷新、点击跳转示例" andClass:FrameTableViewController.class],
                         [ControllerVo initWithTitle:@"Section或Cell间距示例" andClass:GapTableViewController.class],
                         [ControllerVo initWithTitle:@"Cell上下关系和选中高亮示例" andClass:RelateTableViewController.class],
                         [ControllerVo initWithTitle:@"Cell自动调整高度示例" andClass:AutoHeightTableViewController.class],
                         ];
    }
    return _controllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
                    [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:50 cellClass:ControllerDemoViewCell.class sourceArray:self.controllers]];
                }]];
    [self.tableView gy_reloadData];
}

-(BOOL)isShowHeader{
    return NO;
}
//
//-(void)headerRefresh:(GYTableBaseView *)tableView endRefreshHandler:(HeaderRefreshHandler)endRefreshHandler{
//    int64_t delay = 0.5 * NSEC_PER_SEC;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//模拟网络请求产生异步加载
//        [tableView addSectionVo:[SectionVo initWithParams:^(SectionVo *svo) {
//            [svo addCellVoByList:[CellVo dividingCellVoBySourceArray:50 cellClass:ControllerDemoViewCell.class sourceArray:self.controllers]];
//        }]];
//        endRefreshHandler(YES);
//    });
//}

-(void)tableView:(GYTableBaseView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CellVo* cvo = [tableView getCellVoByIndexPath:indexPath];
    ControllerVo* controllerVo = cvo.cellData;
    UIViewController* viewController = [[controllerVo.controllerClass alloc]init];
    viewController.title = controllerVo.title;
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
