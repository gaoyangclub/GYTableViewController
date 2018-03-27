//
//  GapPraiseGroupCell.m
//  MJTableViewController
//
//  Created by admin on 2018/3/26.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "GapPraiseGroupCell.h"
#import "HotModel.h"
#import "UIImageView+WebCache.h"
#import "PraiseModel.h"

@interface GapPraiseItem : UIControl

@property(nonatomic,retain) UILabel* titleLable;
@property(nonatomic,retain) UIImageView* iconView;//图片
@property(nonatomic,retain) HotModel* hotModel;

@end

@implementation GapPraiseItem

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UICreationUtils createLabel:SIZE_TEXT_SECONDARY color:[UIColor whiteColor]];
        [self addSubview:_titleLable];
    }
    return _titleLable;
}

-(UIImageView *)iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc]init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
//        _iconView.layer.masksToBounds = YES;
        [self addSubview:_iconView];
    }
    return _iconView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.hotModel.iconName]];//网络加载图片
    self.iconView.frame = self.bounds;
    
    self.titleLable.text = self.hotModel.title;
    [self.titleLable sizeToFit];
    
    self.titleLable.centerX = self.width / 2.;
    self.titleLable.maxY = self.height - 5;
}

@end

@interface GapPraiseGroupCell()

@property(nonatomic,retain)UILabel* groupTitleLable;
@property(nonatomic,retain)UILabel* groupIconView;

@end

@implementation GapPraiseGroupCell

-(UILabel *)groupIconView{
    if (!_groupIconView) {
        _groupIconView = [UICreationUtils createLabel:ICON_FONT_NAME size:20 color:COLOR_PRIMARY_PRAISE];
        [self.contentView addSubview:_groupIconView];
    }
    return _groupIconView;
}

-(UILabel *)groupTitleLable{
    if (!_groupTitleLable) {
        _groupTitleLable = [UICreationUtils createLabel:SIZE_TEXT_PRIMARY color:COLOR_PRIMARY_PRAISE];
        [self addSubview:_groupTitleLable];
    }
    return _groupTitleLable;
}

-(void)showSubviews{
    self.backgroundColor = [UIColor whiteColor];
    
    PraiseModel* praiseModel = self.data;
    
    CGFloat const toppadding = 50;
    CGFloat const padding = 15;
    CGFloat const gap = 5;
    
    self.groupIconView.text = ICON_GUAN_ZHU;
    [self.groupIconView sizeToFit];
    
    self.groupTitleLable.text = praiseModel.groupTitle;
    [self.groupTitleLable sizeToFit];
    
    CGFloat const baseX = (self.contentView.width - self.groupIconView.width - gap - self.groupTitleLable.width) / 2.;
    
    self.groupIconView.x = baseX;
    self.groupTitleLable.x = self.groupIconView.maxX + gap;
    self.groupIconView.centerY = self.groupTitleLable.centerY = toppadding / 2.;
    
    
    NSInteger const count = praiseModel.hotModels.count;
    CGFloat const itemWidth = (self.contentView.width - padding * 2 - (count - 1) * gap) / count;
    for (NSInteger i = 0 ; i < count; i++) {
        HotModel* hotModel = praiseModel.hotModels[i];
        GapPraiseItem* item = [[GapPraiseItem alloc]init];
//        item.backgroundColor = [UIColor brownColor];
        [self.contentView addSubview:item];
        item.hotModel = hotModel;
        item.frame = CGRectMake(padding + i * (itemWidth + gap), toppadding, itemWidth, self.height - toppadding - padding);
    }
    
}

@end
