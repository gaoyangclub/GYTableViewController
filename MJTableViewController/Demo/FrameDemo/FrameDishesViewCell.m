//
//  FrameDishesViewCell.m
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/25.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "FrameDishesViewCell.h"
#import "DishesModel.h"
#import "UIImageView+WebCache.h"

@interface FrameDishesViewCell()

@property(nonatomic,retain)UIImageView* iconView;

@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)UILabel* desLabel;

@property(nonatomic,retain)UILabel* priceLabel;

@property(nonatomic,retain)UIView* bottomLine;

@end

@implementation FrameDishesViewCell

-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createLabel:SIZE_TEXT_LARGE color:COLOR_TEXT_PRIMARY];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)desLabel{
    if (!_desLabel) {
        _desLabel = [UICreationUtils createLabel:SIZE_TEXT_PRIMARY color:COLOR_TEXT_SECONDARY];
        [self.contentView addSubview:_desLabel];
    }
    return _desLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UICreationUtils createLabel:SIZE_TEXT_PRIMARY color:COLOR_RIMARY_FUND];
        [self.contentView addSubview:_priceLabel];
    }
    return _priceLabel;
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = COLOR_LINE;
        _bottomLine.height = LINE_WIDTH;
        [self.contentView addSubview:_bottomLine];
    }
    return _bottomLine;
}

-(void)showSubviews{
    self.backgroundColor = [UIColor whiteColor];
    
    DishesModel* dishesModel = self.data;
    CGFloat const padding = 10;
    CGFloat const iconHeight = self.contentView.height - padding * 2;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:dishesModel.iconName]];
    self.iconView.size = CGSizeMake(iconHeight, iconHeight);
//    self.iconView.backgroundColor = [UIColor orangeColor];
    self.iconView.centerY = self.contentView.height / 2.;
    self.iconView.x = 20;
    
    self.titleLabel.text = dishesModel.title;
    [self.titleLabel sizeToFit];
    self.desLabel.text = dishesModel.des;
    [self.desLabel sizeToFit];
    
    self.titleLabel.x = self.desLabel.x = self.iconView.maxX + 20;
    
    CGFloat const vGap = 10;
    CGFloat const baseY = (self.contentView.height - self.titleLabel.height - self.desLabel.height - vGap) / 2.;
    self.titleLabel.y = baseY;
    self.desLabel.y = self.titleLabel.maxY + vGap;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",dishesModel.price];
    [self.priceLabel sizeToFit];
    self.priceLabel.maxX = self.contentView.width - 30;
    self.priceLabel.centerY = self.titleLabel.centerY;
    
    self.bottomLine.x = 0;
    self.bottomLine.maxY = self.contentView.height;
    self.bottomLine.width = self.contentView.width;
}

-(BOOL)showSelectionStyle{
    return YES;
}

@end
