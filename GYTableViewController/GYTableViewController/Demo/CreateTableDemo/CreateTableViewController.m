//
//  CreateTableController.m
//  GYTableViewController
//
//  Created by gaoyang on 2019/2/7.
//  Copyright © 2019年 高扬. All rights reserved.
//

#import "CreateTableViewController.h"
#import "PopupListView.h"
#import "Mock.h"

@interface CreateTableViewController ()

@property (nonatomic, strong) PopupListView *popupListView;

@property (nonatomic, strong) UIButton *startButton;

@end

@implementation CreateTableViewController

#pragma mark 主角是PopupListView中创建的自定义TableView实例
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.startButton.frame = CGRectMake(0, 0, self.view.width, 50);
    
    [self.popupListView show];
}

- (void)p_tapStartButton {
    [self.popupListView show];
}

#pragma mark 懒加载添加视图
- (PopupListView *)popupListView {
    if (!_popupListView) {
        _popupListView = [[PopupListView alloc] init];
        _popupListView.title = @"世界上最牛B的语言";
        _popupListView.dataArray = Mock.popupOptions;
    }
    return _popupListView;
}


- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _startButton.backgroundColor = TVStyle.colorPrimaryDishes;
        [_startButton setTitle:@"弹  出" forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _startButton.titleLabel.font = [UIFont systemFontOfSize:20];
        
        [self.view addSubview:_startButton];
        
        [_startButton addTarget:self action:@selector(p_tapStartButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

@end
