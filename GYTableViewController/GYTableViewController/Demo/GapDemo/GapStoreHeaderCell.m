//
//  GapStoreHeaderCell.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/27.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "GapStoreHeaderCell.h"

@interface GapStoreHeaderCell()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *desLabel;

@property (nonatomic, strong) UILabel *headerIconView;

@end

@implementation GapStoreHeaderCell

#pragma mark 根据外部传入数据开始布局
- (void)showSubviews {
    self.backgroundColor = [UIColor whiteColor];
    
    self.headerIconView.text = TVStyle.iconDianZan;
    [self.headerIconView sizeToFit];
    
    self.titleLabel.text = @"为你定制";//偷懒了 不从外面传了 重点是"间距间距间距" 重要的事说三遍
    [self.titleLabel sizeToFit];
    
    self.desLabel.text = @"最好的陪伴是和爱的人一起吃饭";//偷懒了 不从外面传了 重点是"间距间距间距" 重要的事说三遍
    [self.desLabel sizeToFit];
    
    CGFloat const gap = 5;
    CGFloat const baseX = (self.width - self.titleLabel.width - gap - self.headerIconView.width) / 2.;
    CGFloat const baseY = (self.height - self.titleLabel.height - gap - self.desLabel.height ) / 2.;
    
    self.headerIconView.x = baseX;
    self.headerIconView.y = baseY;
    
    self.titleLabel.x = self.headerIconView.maxX + gap;
    self.titleLabel.centerY = self.headerIconView.centerY;
    
    self.desLabel.centerX = self.width / 2.;
    self.desLabel.y = self.titleLabel.maxY + gap;
}

#pragma mark 懒加载添加视图
- (UILabel *)headerIconView {
    if (!_headerIconView) {
        _headerIconView = [UICreationUtils createLabel:TVStyle.iconFontName size:20 color:TVStyle.colorPrimaryStore];
        [self.contentView addSubview:_headerIconView];
    }
    return _headerIconView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createLabel:TVStyle.sizeTextPrimary color:TVStyle.colorPrimaryStore];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [UICreationUtils createLabel:TVStyle.sizeTextSecondary color:TVStyle.colorTextSecondary];
        [self.contentView addSubview:_desLabel];
    }
    return _desLabel;
}

@end
