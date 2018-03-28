//
//  AutoHeightWeiboCell.m
//  MJTableViewController
//
//  Created by admin on 2018/3/28.
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

@property(nonatomic,retain)UIImageView* iconView;

@property(nonatomic,retain)UILabel* nameLabel;

@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)UILabel* contentLabel;

@property(nonatomic,retain)UIImageView* photoView;

@property(nonatomic,retain)UIView* bottomLine;

@end

@implementation AutoHeightWeiboCell

-(UIImageView *)iconView{
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

-(UIImageView *)photoView{
    if (!_photoView) {
        _photoView = [[UIImageView alloc]init];
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.layer.masksToBounds = YES;
        [self.contentView addSubview:_photoView];
    }
    return _photoView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createLabel:SIZE_TEXT_SECONDARY color:COLOR_TEXT_SECONDARY];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UICreationUtils createLabel:SIZE_TEXT_PRIMARY color:COLOR_TEXT_PRIMARY];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UICreationUtils createLabel:SIZE_TEXT_SECONDARY color:COLOR_TEXT_PRIMARY];
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
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

-(CGFloat)getCellHeight:(CGFloat)cellWidth{
//    NSLog(@"getCellHeight被调用！");
    
    WeiboModel* weiboModel = self.data;
    NSString* content = weiboModel.content;
    CGRect contentSize = [content boundingRectWithSize:CGSizeMake(cellWidth - LEFT_PADDING - RIGHT_PADDING, FLT_MAX)
                             options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:SIZE_TEXT_SECONDARY]}
                             context:nil];
    return TOPIC_AREA_HEIGHT + contentSize.size.height + IMAGE_AREA_HEIGHT + BOTTOM_PADDING * 2;
}

-(void)showSubviews{
    self.backgroundColor = [UIColor whiteColor];
    
    WeiboModel* weiboModel = self.data;
    
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

@end
