//
//  GYTableViewCell.m
//  GYTableViewController
//
//  Created by 高扬 on 2016/10/14.
//  Copyright © 2016年 高扬. All rights reserved.
//

#import "GYTableViewCell.h"

@implementation GYTableViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        self.needRefresh = YES;
    }
    return self;
}

- (void)setTableView:(GYTableBaseView *)tableView {
    _tableView = tableView;
    [self setNeedsLayout];
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    [self setNeedsLayout];
}

- (void)setCellNode:(CellNode *)cellNode {
    _cellNode = cellNode;
    if (cellNode.isAutoHeight) {
        cellNode.isAutoHeight = NO;
        CGFloat cellHeight = [self getCellHeight:CGRectGetWidth(self.tableView.bounds)];
        if (cellHeight >= 0) {
            cellNode.cellHeight = cellHeight;
        }
    }
    self.contentView.hidden = cellNode.cellHeight <= 0;//无高度直接隐藏
    [self setNeedsLayout];
}

//- (void)setData:(NSObject *)data{
//    _data = data;
//    [self setNeedsLayout];
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.needRefresh && !self.contentView.hidden) {
        [self showSubviews];
        self.isSubviewShow = YES;
    }
}

- (void)showSubviews {
	
}

- (BOOL)showSelectionStyle {
    return NO;
}

- (CGFloat)getCellHeight:(CGFloat)cellWidth {//坑爹 自动衡量的情况下宽度是不准的 需要获取父容器tableView的宽度衡量
    return 0;
}

- (id)getCellData {
    return self.cellNode.cellData;
}

- (id)checkCellDataClass:(Class)targetClass {
    return [self checkCellDataClass:self.cellNode.cellData targetClass:targetClass];
}

- (id)checkCellDataClass:(id)cellData targetClass:(Class)targetClass {
    NSString *des = [NSString stringWithFormat:@"%@实例数据为空,请检查CellNode中是否设置cellData",NSStringFromClass(self.class)];
    NSAssert(cellData != nil,des);
    
    des = [NSString stringWithFormat:@"传入%@实例数据类型是%@,需要类型是%@,请检查CellNode中设置的cellData类型是否正确!",NSStringFromClass(self.class),NSStringFromClass([cellData class]),NSStringFromClass(targetClass)];
    NSAssert([cellData isKindOfClass:targetClass],des);
    
    return cellData;
}

- (NSArray *)checkCellArrayDataClass:(Class)arrayMemberClass {
    NSString *des = [NSString stringWithFormat:@"%@实例数据为空,请检查CellNode中是否设置cellData",NSStringFromClass(self.class)];
    NSAssert(self.cellNode.cellData != nil,des);
    
    des = [NSString stringWithFormat:@"%@实例传入的数据类型是%@，需要类型是NSArray",NSStringFromClass(self.class),NSStringFromClass([self.cellNode.cellData class])];
    NSAssert([self.cellNode.cellData isKindOfClass:NSArray.class],des);
    
//    des = [NSString stringWithFormat:@"%@实例传入的数据类型是NSArray,但数组元素个数count为0",NSStringFromClass(self.class)];
//    NSAssert(((NSArray*)self.CellNode.cellData).count > 0,des);
    
    NSArray *cellData = self.cellNode.cellData;
    if(cellData.count > 0){
        [self checkCellDataClass:cellData.firstObject targetClass:arrayMemberClass];
    }
    return cellData;
}

@end
