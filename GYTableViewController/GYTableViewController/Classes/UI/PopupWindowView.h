//
//  PopWindowView.h
//  GYTableViewController
//
//  Created by gaoyang on 2018/10/18.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupWindowView : UIView

/**
 顶部居中的标题
 */
@property (nonatomic, copy) NSString *title;

/**
 控件标题栏部分主题颜色
 */
@property (nonatomic, strong) UIColor *tintColor;

/**
 外部传递需要被显示的界面(底部内容区域)
 */
@property (nonatomic, strong) UIView *contentArea;

/**
 底部内容包含的高度
 */
@property (nonatomic, assign) CGFloat contentHeight;


/** 自定义保留字段类似tag **/
@property (nonatomic,copy) NSString *popupName;

/**
 展开
 */
- (void)show;

/**
 关闭
 */
- (void)dismiss;

/**
 视图创建完毕后执行
 */
- (void)viewWillAppear;

@end
