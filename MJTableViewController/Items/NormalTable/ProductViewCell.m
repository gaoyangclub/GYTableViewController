//
//  ProductViewCell.m
//  MJTableViewController
//
//  Created by admin on 2018/3/19.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "ProductViewCell.h"

@interface ProductViewCell()

//@property(nonatomic,retain)UIImageView* iconView;
//@property(nonatomic,retain)UILabel* iconView;

@end

@implementation ProductViewCell

-(void)showSubviews{
    CGFloat const iconWidth = 40;
    
    self.imageView.image = [UIImage imageNamed:@"fundHot12"];
    self.imageView.frame = CGRectMake(30, (CGRectGetHeight(self.contentView.bounds) - iconWidth) / 2., iconWidth, iconWidth);
    
    self.textLabel.text = self.data;
}

-(BOOL)showSelectionStyle{
    return YES;
}

@end
