//
//  GYTableViewSection.h
//  GYTableViewController
//
//  Created by 高扬 on 16/10/17.
//  Copyright © 2016年 高扬. All rights reserved.
//

/*
 *********************************************************************************
 *
 * GYTableViewController交流QQ群：296406818 🎉🎉🎉
 *
 * 使用GY列表框架出现bug，内存问题，或是想新增功能，请您前往github仓库提供issues，我们会尽快修复
 * GitHub: https://github.com/gaoyangclub/GYTableViewController
 * 用法示例：https://github.com/gaoyangclub/GYTableViewController/blob/master/README.md
 *
 *********************************************************************************
 */

#import <UIKit/UIKit.h>

@interface GYTableViewSection : UIControl

/** tableView所有section总数  **/
@property (nonatomic,assign) NSInteger sectionCount;
/** 当前section索引位置  **/
@property (nonatomic,assign) NSInteger sectionIndex;
/** 外部传入的数据 用来布局或交互等（sectionVo.sectionData） **/
@property (nonatomic,strong) id data;
/** 是否在整个tableView的首位 **/
@property (nonatomic,assign) BOOL isFirst;
/** 是否在整个tableView的末位 **/
@property (nonatomic,assign) BOOL isLast;

@end
