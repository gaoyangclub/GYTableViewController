//
//  UIView+GY.h
//  GYTableViewController
//
//  Created by 高扬 on 2017/3/1.
//  Copyright © 2017年 高扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GY)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

- (void)removeAllSubViews;

@end
