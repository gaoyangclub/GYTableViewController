//
//  MJTableViewCell.m
//  MJRefreshTest
//
//  Created by admin on 16/10/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MJTableViewCell.h"

@implementation MJTableViewCell

//- (void)awakeFromNib {
//    // Initialization code
//}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.needRefresh = YES;
    }
    return self;
}

-(void)setTableView:(MJTableBaseView *)tableView{
    _tableView = tableView;
    [self setNeedsLayout];
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    [self setNeedsLayout];
}

-(void)setCellVo:(CellVo *)cellVo{
    _cellVo = cellVo;
    if (cellVo.isAutoHeight) {
        cellVo.isAutoHeight = NO;
        CGFloat cellHeight = [self getCellHeight:CGRectGetWidth(self.tableView.bounds)];
        if (cellHeight > 0) {
            cellVo.cellHeight = cellHeight;
        }else{
            [self setNeedsLayout];
        }
    }else{
        [self setNeedsLayout];
    }
}

-(void)setData:(NSObject *)data{
    _data = data;
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.needRefresh) {
        [self showSubviews];
        self.isSubviewShow = YES;
    }
}

-(void)showSubviews {
	
}

-(BOOL)showSelectionStyle{
    return NO;
}

-(CGFloat)getCellHeight:(CGFloat)cellWidth{//坑爹 自动衡量的情况下宽度是不准的 需要获取父容器tableView的宽度衡量
    return 0;
}

@end
