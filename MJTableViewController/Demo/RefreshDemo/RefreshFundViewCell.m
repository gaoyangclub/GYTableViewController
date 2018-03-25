//
//  RefreshFundViewCell.m
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/24.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "RefreshFundViewCell.h"
#import "FundModel.h"

@interface RefreshFundViewCell()

@property(nonatomic,retain)UILabel* iconView;

@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)UILabel* desLabel;

@property(nonatomic,retain)UILabel* rateLabel;

@property(nonatomic,retain)UIView* bottomLine;

@end

@implementation RefreshFundViewCell

-(UILabel *)iconView{
    if (!_iconView) {
        _iconView = [UICreationUtils createLabel:ICON_FONT_NAME size:30 color:COLOR_RIMARY_FUND];
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

-(UILabel *)rateLabel{
    if (!_rateLabel) {
        _rateLabel = [UICreationUtils createLabel:SIZE_TEXT_PRIMARY color:COLOR_TEXT_SECONDARY];
        [self.contentView addSubview:_rateLabel];
    }
    return _rateLabel;
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
    
    FundModel* fundModel = self.data;
    
    self.iconView.text = fundModel.iconName;
    [self.iconView sizeToFit];
    self.iconView.centerY = self.contentView.height / 2.;
    self.iconView.x = 20;
    
    self.titleLabel.text = fundModel.title;
    [self.titleLabel sizeToFit];
    self.desLabel.text = fundModel.des;
    [self.desLabel sizeToFit];
    
    self.titleLabel.x = self.desLabel.x = self.iconView.maxX + 20;
    
    CGFloat const vGap = 10;
    CGFloat const baseY = (self.contentView.height - self.titleLabel.height - self.desLabel.height - vGap) / 2.;
    self.titleLabel.y = baseY;
    self.desLabel.y = self.titleLabel.maxY + vGap;
    
    self.rateLabel.text = [NSString stringWithFormat:@"季度收益  %@",fundModel.rate];;
    [self.rateLabel sizeToFit];
    self.rateLabel.maxX = self.contentView.width - 30;
    self.rateLabel.centerY = self.desLabel.centerY;
    
    self.bottomLine.x = 0;
    self.bottomLine.maxY = self.contentView.height;
    self.bottomLine.width = self.contentView.width;
}

@end
