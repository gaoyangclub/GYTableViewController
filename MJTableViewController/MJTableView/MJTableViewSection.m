
//
//  MJTableViewHeader.m
//  MJRefreshTest
//
//  Created by admin on 16/10/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MJTableViewSection.h"

@interface MJTableViewSection(){
    
}
//@property(nonatomic,assign)BOOL *selected;

@end

@implementation MJTableViewSection

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self setNeedsLayout];
}

-(void)setItemIndex:(NSInteger)itemIndex{
    _itemIndex = itemIndex;
    [self setNeedsLayout];
}

-(void)setData:(NSObject *)data{
    _data = data;
    [self setNeedsLayout];
}

//-(void)setIsFirst:(BOOL)isFirst{
//    _isFirst = isFirst;
//    [self setNeedsLayout];
//}
//
//-(void)setIsLast:(BOOL)isLast{
//    _isLast = isLast;
//    [self setNeedsLayout];
//}


@end
