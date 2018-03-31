//
//  UIView+GY.m
//  GYTableViewController
//
//  Created by 高扬 on 17/3/1.
//  Copyright © 2017年 高扬. All rights reserved.
//

#import "UIView+GY.h"

@implementation UIView (GY)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

-(void)setMaxX:(CGFloat)maxX{
    self.x = maxX - self.width;
}

-(CGFloat)maxX{
    return self.x + self.width;
}

-(void)setMaxY:(CGFloat)maxY{
    self.y = maxY - self.height;
}

-(CGFloat)maxY{
    return self.y + self.height;
}

- (void)setSize:(CGSize)size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

-(void)removeAllSubViews{
    for (UIView* subView in self.subviews) {//子对象全部移除干净
        [subView removeFromSuperview];
    }
}

@end
