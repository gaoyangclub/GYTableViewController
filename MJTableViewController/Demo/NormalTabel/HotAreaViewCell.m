//
//  HotAreaViewCell.m
//  MJTableViewController
//
//  Created by admin on 2018/3/19.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "HotAreaViewCell.h"

@implementation HotAreaViewCell

-(void)showSubviews{
    self.backgroundColor = [UIColor whiteColor];
    CGFloat const cellWidth = CGRectGetWidth(self.contentView.bounds);
    CGFloat const cellHeight = CGRectGetHeight(self.contentView.bounds);
    CGFloat const iconWidth = 60;
    NSArray* iconNames = self.data;
    NSInteger const lastCount = self.contentView.subviews.count;
    NSInteger index = 0;
    CGFloat gapSpcae = cellWidth / iconNames.count;
    for (NSString* iconName in iconNames) {
        UIImageView* iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:iconName]];
        iconView.frame = CGRectMake(index * gapSpcae + (gapSpcae - iconWidth) / 2. + lastCount * 5, (cellHeight - iconWidth) / 2., iconWidth, iconWidth);
        [self.contentView addSubview:iconView];
        index++;
    }
}

@end
