//
//  RefreshFundViewCell.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/24.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "RefreshFundViewCell.h"
#import "FundModel.h"

@interface RefreshFundViewCell()

@property (nonatomic, strong) UILabel *iconView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *desLabel;

@property (nonatomic, strong) UILabel *rateLabel;

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation RefreshFundViewCell

#pragma mark 根据外部传入数据开始布局
- (void)showSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    
    FundModel *fundModel = [self getCellData];
    
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

#pragma mark 懒加载添加视图
- (UILabel *)iconView {
    if (!_iconView) {
        _iconView = [UICreationUtils createLabel:TVStyle.iconFontName size:30 color:TVStyle.colorPrimaryFund];
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createLabel:TVStyle.sizeTextLarge color:TVStyle.colorTextPrimary];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [UICreationUtils createLabel:TVStyle.sizeTextPrimary color:TVStyle.colorTextSecondary];
        [self.contentView addSubview:_desLabel];
    }
    return _desLabel;
}

- (UILabel *)rateLabel {
    if (!_rateLabel) {
        _rateLabel = [UICreationUtils createLabel:TVStyle.sizeTextPrimary color:TVStyle.colorTextSecondary];
        [self.contentView addSubview:_rateLabel];
    }
    return _rateLabel;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = TVStyle.colorLine;
        _bottomLine.height = TVStyle.lineWidth;
        [self.contentView addSubview:_bottomLine];
    }
    return _bottomLine;
}

@end
