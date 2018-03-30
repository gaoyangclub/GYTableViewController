//
//  GapStoreViewCell.m
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/27.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "GapStoreViewCell.h"
#import "StoreModel.h"
#import "UIImageView+WebCache.h"

@interface GapStoreViewCell()

@property(nonatomic,retain)UIImageView* iconView;

@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)UILabel* hotLabel;//人气热度

@property(nonatomic,retain)UILabel* desLabel;

@property(nonatomic,retain)UIButton* discountButton;

@end

@implementation GapStoreViewCell

-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createLabel:SIZE_TEXT_PRIMARY color:COLOR_TEXT_PRIMARY];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)hotLabel{
    if (!_hotLabel) {
        _hotLabel = [UICreationUtils createLabel:SIZE_TEXT_SECONDARY color:COLOR_PRIMARY_STORE];
        [self.contentView addSubview:_hotLabel];
    }
    return _hotLabel;
}

-(UILabel *)desLabel{
    if (!_desLabel) {
        _desLabel = [UICreationUtils createLabel:SIZE_TEXT_SECONDARY color:COLOR_TEXT_SECONDARY];
        [self.contentView addSubview:_desLabel];
    }
    return _desLabel;
}

-(UIButton *)discountButton{
    if (!_discountButton) {
        _discountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _discountButton.titleLabel.font = [UIFont systemFontOfSize:SIZE_TEXT_SECONDARY];
        [_discountButton setTitleColor:COLOR_PRIMARY_STORE forState:UIControlStateNormal];
        
        _discountButton.layer.cornerRadius = 5;
        _discountButton.layer.masksToBounds = YES;
        
        _discountButton.layer.borderColor = COLOR_PRIMARY_STORE.CGColor;
        _discountButton.layer.borderWidth = LINE_WIDTH;
        
        _discountButton.size = CGSizeMake(30, 15);
        
        [self.contentView addSubview:_discountButton];
    }
    return _discountButton;
}

-(void)showSubviews{
    self.backgroundColor = [UIColor whiteColor];
    
    StoreModel* storeModel = GET_CELL_DATA(StoreModel.class);
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



@end
