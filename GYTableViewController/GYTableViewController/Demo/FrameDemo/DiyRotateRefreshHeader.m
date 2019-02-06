//
//  DiyRotateRefreshHeader.m
//  GYTableViewController
//
//  Created by 高扬 on 2017/12/14.
//  Copyright © 2017年 高扬. All rights reserved.
//

#import "DiyRotateRefreshHeader.h"
#import "TVStyle.h"

@interface DiyRotateRefreshHeader()

@property (nonatomic, strong) UILabel *rotateView;

@end

@implementation DiyRotateRefreshHeader

- (void)placeSubviews {
    [super placeSubviews];
    
    CGFloat arrowCenterX = self.mj_w * 0.5;
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 圈圈
    self.rotateView.center = arrowCenter;
}

- (void)startRotateRepert {
    [UIView animateWithDuration:0.05f
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.rotateView.transform = CGAffineTransformRotate(self.rotateView.transform, M_PI / 6);
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             if (self.state == MJRefreshStateIdle) {
                                 [self stopRotate];
                             }else{
                                 [self startRotateRepert];
                             }
                         }
                     }];
}

- (void)stopRotate {
    [UIView animateWithDuration:0.2f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.rotateView.transform = CGAffineTransformRotate(self.rotateView.transform, M_PI_2);
                     }
                     completion:^(BOOL finished){
                         self.rotateView.transform = CGAffineTransformIdentity;
                     }];
}

- (void)setState:(MJRefreshState)state {
    
    MJRefreshCheckState
    
    if (state == MJRefreshStateRefreshing) {
        
        [self startRotateRepert];
    }
}

- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.state == MJRefreshStatePulling) {
            self.rotateView.transform = CGAffineTransformMakeRotation(pullingPercent * 360 * M_PI / 180.0);
//            NSLog(@"pullingPercent:%f",pullingPercent);
        }
    });
}

- (UILabel *)rotateView {
    if (!_rotateView) {
        _rotateView = [[UILabel alloc]init];
        UIFont *iconfont = [UIFont fontWithName:TVStyle.iconFontName size: 25];
        _rotateView.font = iconfont;
        _rotateView.text = @"\U0000e60e";// \U0000e652
        [_rotateView sizeToFit];
        _rotateView.textColor = TVStyle.colorPrimaryDishes;
        [self addSubview:_rotateView];
    }
    return _rotateView;
}

@end
