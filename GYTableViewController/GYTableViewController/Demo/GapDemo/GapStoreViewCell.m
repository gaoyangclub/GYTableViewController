//
//  GapStoreViewCell.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/27.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "GapStoreViewCell.h"
#import "StoreModel.h"
#import "UIImageView+WebCache.h"

@interface GapStoreViewCell()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *hotLabel;//人气热度

@property (nonatomic, strong) UILabel *desLabel;

@property (nonatomic, strong) UIButton *discountButton;

@end

@implementation GapStoreViewCell

#pragma mark 根据外部传入数据开始布局
- (void)showSubviews {
    self.backgroundColor = [UIColor whiteColor];
    
    StoreModel *storeModel = [self getCellData];
    CGFloat const padding = 20;
    CGFloat const iconHeight = self.contentView.height - padding * 2;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:storeModel.iconName]];
    self.iconView.size = CGSizeMake(iconHeight, iconHeight);
    self.iconView.centerY = self.contentView.height / 2.;
    self.iconView.x = padding;
    
    self.titleLabel.text = storeModel.title;
    [self.titleLabel sizeToFit];
    
    self.hotLabel.text = [NSString stringWithFormat:@"月均人气 %@",storeModel.hot];
    [self.hotLabel sizeToFit];
    
    self.desLabel.text = storeModel.des;
    [self.desLabel sizeToFit];
    
    [self.discountButton setTitle:storeModel.discount forState:UIControlStateNormal];
    
    self.titleLabel.x = self.hotLabel.x = self.desLabel.x = self.discountButton.x = self.iconView.maxX + padding;
    
    CGFloat const gap = 5;
    
    self.titleLabel.y = self.iconView.y;
    self.hotLabel.y = self.titleLabel.maxY + gap;
    self.desLabel.y = self.hotLabel.maxY + gap;
    self.discountButton.maxY = self.iconView.maxY;
}

#pragma mark 懒加载添加视图
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createLabel:TVStyle.sizeTextPrimary color:TVStyle.colorTextPrimary];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)hotLabel {
    if (!_hotLabel) {
        _hotLabel = [UICreationUtils createLabel:TVStyle.sizeTextSecondary color:TVStyle.colorPrimaryStore];
        [self.contentView addSubview:_hotLabel];
    }
    return _hotLabel;
}

- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [UICreationUtils createLabel:TVStyle.sizeTextSecondary color:TVStyle.colorTextSecondary];
        [self.contentView addSubview:_desLabel];
    }
    return _desLabel;
}

- (UIButton *)discountButton {
    if (!_discountButton) {
        _discountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _discountButton.titleLabel.font = [UIFont systemFontOfSize:TVStyle.sizeTextSecondary];
        [_discountButton setTitleColor:TVStyle.colorPrimaryStore forState:UIControlStateNormal];
        
        _discountButton.layer.cornerRadius = 5;
        _discountButton.layer.masksToBounds = YES;
        
        _discountButton.layer.borderColor = TVStyle.colorPrimaryStore.CGColor;
        _discountButton.layer.borderWidth = TVStyle.lineWidth;
        
        _discountButton.size = CGSizeMake(30, 15);
        
        [self.contentView addSubview:_discountButton];
    }
    return _discountButton;
}

@end
