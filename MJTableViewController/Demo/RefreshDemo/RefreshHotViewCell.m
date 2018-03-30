//
//  RefreshHotViewCell.m
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/24.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "RefreshHotViewCell.h"
#import "HotModel.h"

@interface HomeFastItem : UIControl

@property(nonatomic,retain) UILabel* titleLable;
@property(nonatomic,retain) UIImageView* iconView;//图片文本
@property(nonatomic,retain) HotModel* hotModel;
//@property(nonatomic,copy) NSString* title;
//@property(nonatomic,copy) NSString* iconName;
//@property(nonatomic,retain) UIColor* iconColor;



@end

@implementation HomeFastItem

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [UICreationUtils createLabel:SIZE_TEXT_PRIMARY color:COLOR_TEXT_PRIMARY];
        [self addSubview:_titleLable];
    }
    return _titleLable;
}

-(UIImageView *)iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc]init];
        [self addSubview:_iconView];
    }
    return _iconView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLable.text = self.hotModel.title;
    [self.titleLable sizeToFit];
    
    self.iconView.image = [UIImage imageNamed:self.hotModel.iconName];
    CGFloat const nodeSizeWidth = 40;
    self.iconView.size = CGSizeMake(nodeSizeWidth,nodeSizeWidth);
    
    self.titleLable.centerX = self.iconView.centerX = self.width / 2.;
    CGFloat const gap = 10;
    CGFloat const baseY = (self.height - self.titleLable.height - self.iconView.height - gap) / 2;
    self.iconView.y = baseY;
    self.titleLable.y = self.iconView.maxY + gap;
}

@end

@interface RefreshHotViewCell()

@property(nonatomic,retain)UIView* bottomLine;

@end

@implementation RefreshHotViewCell

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
    
    NSArray<HotModel*>* hotModels = GET_CELL_ARRAY_DATA(HotModel.class); //self.data;
    CGFloat const itemWidth = self.contentView.width / hotModels.count;
    for (NSInteger i = 0; i < hotModels.count; i++) {
        HotModel* hotModel = hotModels[i];
        HomeFastItem* item = [[HomeFastItem alloc]init];
        item.hotModel = hotModel;
        [self.contentView addSubview:item];
        item.frame = CGRectMake(i * itemWidth, 0, itemWidth, self.contentView.height);
//        item.tag = i;
    }
    
    self.bottomLine.x = 0;
    self.bottomLine.maxY = self.contentView.height;
    self.bottomLine.width = self.contentView.width;
}


@end
