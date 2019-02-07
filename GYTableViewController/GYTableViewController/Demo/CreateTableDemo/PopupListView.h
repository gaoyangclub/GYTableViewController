//
//  PopupListView.h
//  GYTableViewController
//
//  Created by gaoyang on 2019/2/7.
//  Copyright © 2019年 高扬. All rights reserved.
//

#import "PopupWindowView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PopupListView : PopupWindowView

/**
 需要填充选项的数组
 */
@property (nonatomic, strong) NSArray *dataArray;

@end

NS_ASSUME_NONNULL_END
