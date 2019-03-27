//
//  GYRefreshAutoFooter.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/16.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "GYRefreshAutoFooter.h"

@implementation GYRefreshAutoFooter

- (void)setState:(MJRefreshState)state {
    [super setState:state];
    self.hidden = (self.scrollView.mj_totalDataCount == 0);
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
//    [super scrollViewPanStateDidChange:change];
    
    if (self.state != MJRefreshStateIdle && self.state != MJRefreshStateNoMoreData) return;
    
    UIGestureRecognizerState panState = _scrollView.panGestureRecognizer.state;
    if (panState == UIGestureRecognizerStateEnded) {// 手松开
        if (_scrollView.mj_insetT + _scrollView.mj_contentH <= _scrollView.mj_h) {  // 不够一个屏幕
            if (_scrollView.mj_contentH > 0 && _scrollView.mj_offsetY >= - _scrollView.mj_insetT) { //有数据(mj_contentH > 0) 且 向上拽
                [self beginRefreshing];
            }
        } else { // 超出一个屏幕
            if (_scrollView.mj_offsetY >= _scrollView.mj_contentH + _scrollView.mj_insetB - _scrollView.mj_h) {
                [self beginRefreshing];
            }
        }
    } else if (panState == UIGestureRecognizerStateBegan) {
        [self setValue:@(YES) forKey:@"oneNewPan"];
//        self.oneNewPan = YES;
    }
}

@end
