//
//  RefreshFundViewSection.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/25.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "RefreshFundViewSection.h"

@interface RefreshFundViewSection()


@property(nonatomic,retain)UILabel* titleLabel;
@property(nonatomic,retain)UIView* square;
@property(nonatomic,retain)UIView* bottomLine;

@end

@implementation RefreshFundViewSection

#pragma mark 懒加载添加视图
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        //        _titleLabel.textColor =
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UIView *)square{
    if (!_square) {
        _square = [[UIView alloc] init];
        _square.backgroundColor = COLOR_PRIMARY_FUND;
        _square.size = CGSizeMake(5, 18);
        [self addSubview:_square];
    }
    return _square;
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = COLOR_LINE;
        _bottomLine.height = LINE_WIDTH;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

#pragma mark Section视图暂时使用原生的方法布局 以后可能封装成别的方法来代替
-(void)layoutSubviews{
    self.backgroundColor = COLOR_BACKGROUND;
    //square用懒加载方式添加一个UIView方块，具体创建方式不赘述
    self.square.x = 0;
    self.square.centerY = self.height / 2;
    //titleLabel用懒加载方式添加一个普通UILabel，具体创建方式不赘述
    self.titleLabel.text = self.data;//将外部传入的sectionVo.sectionData显示到标题文本上
    [self.titleLabel sizeToFit];
    self.titleLabel.x = self.square.maxX + 10;
    self.titleLabel.centerY = self.height / 2.;
    
    self.bottomLine.x = 0;
    self.bottomLine.maxY = self.height;
    self.bottomLine.width = self.width;
}

@end
