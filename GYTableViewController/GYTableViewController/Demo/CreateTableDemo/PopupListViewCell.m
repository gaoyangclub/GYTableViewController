//
//  PopupListViewCell.m
//  GYTableViewController
//
//  Created by gaoyang on 2019/2/7.
//  Copyright © 2019年 高扬. All rights reserved.
//

#import "PopupListViewCell.h"

@implementation PopupListViewCell

- (void)showSubviews {
    NSString *cellData = [self getCellData];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.text = cellData;
    [self.textLabel sizeToFit];
    self.textLabel.x = 15;
    self.textLabel.centerY = self.contentView.height / 2.0;
    self.textLabel.textColor = self.tableView.tintColor;
}

- (BOOL)showSelectionStyle {
    return YES;
}

@end
