//
//  RefreshHotViewCell.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/24.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "RefreshHotViewCell.h"
#import "HotModel.h"

@interface HomeFastItem : UIControl

@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIImageView *iconView;//图片文本
@property (nonatomic, strong) HotModel *hotModel;

@end

@implementation HomeFastItem

- (void)layoutSubviews {
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

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UICreationUtils createLabel:TVStyle.sizeTextPrimary color:TVStyle.colorTextPrimary];
        [self addSubview:_titleLable];
    }
    return _titleLable;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        [self addSubview:_iconView];
    }
    return _iconView;
}

@end

@interface RefreshHotViewCell()

@property (nonatomic, strong)UIView *bottomLine;

@end

@implementation RefreshHotViewCell

#pragma mark 根据外部传入数据开始布局
/**
 * 批量创建HomeFastItem按钮实例，一字排开
 */
- (void)showSubviews {
    self.backgroundColor = [UIColor whiteColor];
    
    NSArray<HotModel *> *hotModels = [self getCellData];
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
