//
//  RelateExpressViewCell.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/27.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "RelateExpressViewCell.h"
#import "ExpressModel.h"

#define LEFT_AREA_WIDTH 100
#define NORMAL_ROUTE_RADIUS 5
#define FIRST_ROUTE_RADIUS 7

@interface RelateExpressViewCell()

@property(nonatomic,retain) UIView* routeLine;//竖直线
@property(nonatomic,retain) UIView* roundNode;//圆点
@property(nonatomic,retain) UILabel* titleLabel;
@property(nonatomic,retain) UILabel* yearLabel;
@property(nonatomic,retain) UILabel* timeLabel;

@end

@implementation RelateExpressViewCell

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createLabel:SIZE_TEXT_PRIMARY color:COLOR_TEXT_PRIMARY];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)yearLabel{
    if (!_yearLabel) {
        _yearLabel = [UICreationUtils createLabel:SIZE_TEXT_SECONDARY color:COLOR_TEXT_PRIMARY];
        [self.contentView addSubview:_yearLabel];
    }
    return _yearLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UICreationUtils createLabel:SIZE_TEXT_PRIMARY color:COLOR_TEXT_PRIMARY];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

-(UIView *)routeLine{
    if (!_routeLine) {
        _routeLine = [[UIView alloc]init];
        _routeLine.width = 2;
        _routeLine.backgroundColor = COLOR_LINE;
        [self.contentView addSubview:_routeLine];
    }
    return _routeLine;
}

-(UIView *)roundNode{
    if (!_roundNode) {
        _roundNode = [[UIView alloc]init];
        [self.contentView addSubview:_roundNode];
    }
    return _roundNode;
}

-(void)showSubviews{
    self.backgroundColor = [UIColor whiteColor];
    
    ExpressModel* expressModel = GET_CELL_DATA(ExpressModel.class);
    
    self.titleLabel.text = expressModel.title;
    [self.titleLabel sizeToFit];
    
    self.yearLabel.text = expressModel.year;
    [self.yearLabel sizeToFit];
    self.timeLabel.text = expressModel.time;
    [self.timeLabel sizeToFit];
    
    CGFloat const gap = 3;
    CGFloat const baseY = (self.contentView.height - self.yearLabel.height - gap - self.timeLabel.height) / 2;
    
    self.yearLabel.y = baseY;
    self.timeLabel.y = self.yearLabel.maxY + gap;
    self.yearLabel.centerX = self.timeLabel.centerX = LEFT_AREA_WIDTH / 2.;
    
    self.routeLine.x = LEFT_AREA_WIDTH;
    
    self.titleLabel.x = self.routeLine.maxX + 20;
    self.titleLabel.centerY = self.contentView.height / 2.;
    
    [self checkCellRelate];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self checkCellRelate];
}

//如要显示选中后一直按下效果 请使用setSelected
//-(BOOL)showSelectionStyle{
//    return YES;
//}

-(void)checkCellRelate{
    self.titleLabel.textColor = self.yearLabel.textColor = self.timeLabel.textColor = self.selected ? COLOR_PRIMARY_EXPRESS : COLOR_TEXT_PRIMARY;
    UIColor* nodeColor;
    if (self.selected) {
        nodeColor = COLOR_PRIMARY_EXPRESS;
    }else{
        nodeColor = COLOR_LINE;
    }
    if (self.isFirst) {
        [self drawFirstStyle:nodeColor];
    }else if(self.isLast){
        [self drawLastStyle:nodeColor];
    }else{
        [self drawNormalStyle:nodeColor];
    }
}

-(void)drawFirstStyle:(UIColor*)color{
    self.routeLine.height = self.contentView.height / 2.;
    self.routeLine.y = self.contentView.height / 2.;
    self.roundNode.size = CGSizeMake(FIRST_ROUTE_RADIUS * 2, FIRST_ROUTE_RADIUS * 2);
    self.roundNode.layer.borderColor = color.CGColor;
    self.roundNode.layer.borderWidth = 2;
    self.roundNode.layer.cornerRadius = FIRST_ROUTE_RADIUS;
    self.roundNode.layer.masksToBounds = YES;
    self.roundNode.centerX = self.routeLine.centerX;
    self.roundNode.centerY = self.contentView.height / 2.;
    self.roundNode.backgroundColor = [UIColor whiteColor];
}

-(void)drawLastStyle:(UIColor*)color{
    self.routeLine.height = self.contentView.height / 2.;
    self.routeLine.y = 0;
    self.roundNode.size = CGSizeMake(FIRST_ROUTE_RADIUS * 2, FIRST_ROUTE_RADIUS * 2);
    self.roundNode.layer.borderColor = color.CGColor;
    self.roundNode.layer.borderWidth = 2;
    self.roundNode.layer.cornerRadius = FIRST_ROUTE_RADIUS;
    self.roundNode.layer.masksToBounds = YES;
    self.roundNode.centerX = self.routeLine.centerX;
    self.roundNode.centerY = self.contentView.height / 2.;
    self.roundNode.backgroundColor = [UIColor whiteColor];
}

-(void)drawNormalStyle:(UIColor*)color{
    self.routeLine.height = self.contentView.height;
    self.routeLine.y = 0;
    self.roundNode.size = CGSizeMake(NORMAL_ROUTE_RADIUS * 2, NORMAL_ROUTE_RADIUS * 2);
    self.roundNode.layer.borderColor = [UIColor clearColor].CGColor;
    self.roundNode.layer.borderWidth = 0;
    self.roundNode.layer.cornerRadius = NORMAL_ROUTE_RADIUS;
    self.roundNode.layer.masksToBounds = YES;
    self.roundNode.centerX = self.routeLine.centerX;
    self.roundNode.centerY = self.contentView.height / 2.;
    self.roundNode.backgroundColor = color;
}






@end
