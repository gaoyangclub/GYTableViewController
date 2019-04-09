//
//  AutoHeightWeiboCell.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/28.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "AutoHeightWeiboCell.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"

#define TOPIC_AREA_HEIGHT 50
#define IMAGE_AREA_HEIGHT 100
#define LEFT_PADDING 60
#define RIGHT_PADDING 10
#define BOTTOM_PADDING 10

@interface AutoHeightWeiboCell()

@property (nonatomic,strong) UIImageView *iconView;

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,strong) UIImageView *photoView;

@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation AutoHeightWeiboCell

#pragma mark 获取动态高度,高度被缓存不会二次计算
- (CGFloat)getCellHeight:(CGFloat)cellWidth {
//    if (self.indexPath.row == 2 || self.indexPath.row == 3 || self.indexPath.row == 5 || self.indexPath.row == 6 || self.indexPath.row == 8 || self.indexPath.row == 11) {
//        return 0;
//    }
    WeiboModel *weiboModel = [self getCellData];//获取Model
    NSString *content = weiboModel.content;//获取动态内容字符串
    CGRect contentSize = [content boundingRectWithSize:CGSizeMake(cellWidth - LEFT_PADDING - RIGHT_PADDING, FLT_MAX)
                             options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:TVStyle.sizeTextSecondary]}
                             context:nil];//计算给定范围内最佳尺寸
    return TOPIC_AREA_HEIGHT + contentSize.size.height + IMAGE_AREA_HEIGHT + BOTTOM_PADDING * 2;//返回计算后的最终高度
}

#pragma mark 根据外部传入数据开始布局
- (void)showSubviews {
    self.backgroundColor = [UIColor whiteColor];
    
    WeiboModel *weiboModel = [self getCellData];
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:weiboModel.iconName]];
    self.iconView.centerX = LEFT_PADDING / 2.;
    self.iconView.centerY = TOPIC_AREA_HEIGHT / 2;
    
    self.nameLabel.text = weiboModel.name;
    [self.nameLabel sizeToFit];
    self.titleLabel.text = weiboModel.title;
    [self.titleLabel sizeToFit];
    CGFloat const gap = 5;
    CGFloat const baseY = (TOPIC_AREA_HEIGHT - self.nameLabel.height - gap - self.titleLabel.height) / 2;
    self.nameLabel.y = baseY;
    self.titleLabel.y = self.nameLabel.maxY + gap;
    
    self.nameLabel.x = self.titleLabel.x = LEFT_PADDING;
    
    self.contentLabel.text = weiboModel.content;
    self.contentLabel.size = [self.contentLabel sizeThatFits:CGSizeMake(self.contentView.width - LEFT_PADDING - RIGHT_PADDING, FLT_MAX)];
    self.contentLabel.x = LEFT_PADDING;
    self.contentLabel.y = TOPIC_AREA_HEIGHT;
    
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:weiboModel.imageUrl]];
    self.photoView.frame = CGRectMake(LEFT_PADDING, self.contentLabel.maxY + BOTTOM_PADDING, self.contentLabel.width, IMAGE_AREA_HEIGHT);
    
    self.bottomLine.x = 0;
    self.bottomLine.maxY = self.contentView.height;
    self.bottomLine.width = self.contentView.width;
}

#pragma mark 懒加载添加视图
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        CGFloat const iconWidth = LEFT_PADDING - 20;
        _iconView.size = CGSizeMake(iconWidth, iconWidth);
        _iconView.layer.cornerRadius = iconWidth / 2.;
        _iconView.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc]init];
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.layer.masksToBounds = YES;
        [self.contentView addSubview:_photoView];
    }
    return _photoView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createLabel:TVStyle.sizeTextSecondary color:TVStyle.colorTextSecondary];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UICreationUtils createLabel:TVStyle.sizeTextPrimary color:TVStyle.colorTextPrimary];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UICreationUtils createLabel:TVStyle.sizeTextSecondary color:TVStyle.colorTextPrimary];
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
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
